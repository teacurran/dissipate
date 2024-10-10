import 'package:dissipate/home/tabbed_home_screen.dart';
import 'package:dissipate/style/app_theme.dart';
import 'package:dissipate/users/user_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:grpc/grpc.dart';

import 'generated/dissipate.pbgrpc.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  if (kIsWeb) {
    // FirebaseCrashlytics doesn't work on web
    // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    if (kDebugMode && false) {
      // Force disable Crashlytics collection while doing every day development.
      // Temporarily toggle this to true if you want to test crash reporting in your app.
    } else {
      // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
  }
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final channel = grpc.ClientChannel(
    '192.168.0.69',
    port: 9000,
    options: const grpc.ChannelOptions(credentials: grpc.ChannelCredentials.insecure()),
  );

  final dissipateClient = DissipateServiceClient(channel);

  getIt.registerSingleton<UserApi>(UserApi(dissipateClient));

  try {
    RegisterRequest registerRequest = RegisterRequest(email: "tea@grilledcheese.com");

    var response = await dissipateClient.register(registerRequest);

    print(response.result);

    ///do something with your response here
  } on GrpcError catch (e) {
    ///handle all grpc errors here
    ///errors such us UNIMPLEMENTED,UNIMPLEMENTED etc...
    print(e);
  } catch (e) {
    ///handle all generic errors here
    print(e);
  }

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
  final List<Widget> screens = [
    ScreenWidget(title: 'Screen 1', color: Colors.blue),
    ScreenWidget(title: 'Screen 2', color: Colors.green),
    ScreenWidget(title: 'Screen 3', color: Colors.orange),
  ];

  Future<void> _init(context) async {}

  @override
  Widget build(BuildContext context) {
    return AppTheme(
        child: MaterialApp(
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
        '/test': (context) => const TabbedHomeScreen(),
      },
    ));
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
        child: MaterialApp(
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
    ));
    // show your app’s home page after login
  }
}

class ScreenWidget extends StatelessWidget {
  final String title;
  final Color color;

  const ScreenWidget({Key? key, required this.title, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        color: color,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
