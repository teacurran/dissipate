import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dissipate/home/tabbed_home_screen.dart';
import 'package:dissipate/style/app_theme.dart';
import 'package:dissipate/users/user_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';
import 'generated/dissipate.pbgrpc.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await Firebase.initializeApp(options: firebaseOptions);

  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    // FirebaseCrashlytics doesn't work on web
    // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    if (kDebugMode && false) {
      // Force disable Crashlytics collection while doing every day development.
      // Temporarily toggle this to true if you want to test crash reporting in your app.

      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
  }
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (dotenv.get("EMULATE_FIRESTORE", fallback: "false") == "true") {
    FirebaseFirestore.instance.settings = Settings(
        host: dotenv.get('FIRESTORE_HOST', fallback: 'localhost:8080'),
        sslEnabled: false,
        persistenceEnabled: true);
  }

  if (dotenv.get("EMULATE_AUTH", fallback: "false") == "true") {
    if (kDebugMode) {
      print('using emulated firebase auth at: localhost, port: 9099');
    }
    FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  final channel = grpc.ClientChannel(
    '192.168.0.69',
    port: 9299,
    options: const grpc.ChannelOptions(credentials: grpc.ChannelCredentials.insecure()),
  );

  final dissipateClient = DissipateServiceClient(channel);

  getIt.registerSingleton<UserApi>(UserApi(dissipateClient));

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}


/// -----------------------------------
///              App State
/// -----------------------------------

class _AppState extends State<App> {
  Future<void> _init(context) async {
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _init(context),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return loadingScreen(context);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return authenticationGate(context);
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return loadingScreen(context);
      },
    );
  }

  Widget loadingScreen(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        highlightColor: Colors.teal,
        primaryColor: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.light,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.system,
      home: const Scaffold(),
      title: "¡gffft!",
    );
  }

  Widget authenticationGate(BuildContext context) {
    return AppTheme(
        child: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        final User? user = snapshot.data;

        if (user == null) {
          // id like to remove thi eentire StreamBuilder, but for some reason
          // when I do the page doesn't render at all

          // navigation can't happen here because the router isn't set up yet.
          // instead this auth check is taking place in home_screen.dart

          //navigator.push(Uri(path: LoginScreen.webPath));
          // VxNavigator.of(context).push(Uri(path: LoginScreen.webPath));
        } else {
          if (kDebugMode) print("user is not null");
        }

        // final User? user = snapshot.data;
        // var initialRoute = snapshot.hasData && user != null ? HomeScreen.webPath : LoginScreen.webPath;

        return MaterialApp(
          title: 'dissipate',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('es', ''), // Spanish
            Locale('pt', ''), // Portugese
          ],
          darkTheme: context.appTheme.materialTheme,
          theme: context.appTheme.materialTheme,
          routes: {
            '/': (context) => const TabbedHomeScreen(),
          },
        );
        // show your app’s home page after login
      },
    ));
  }
}
