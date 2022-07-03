import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:velocity_x/velocity_x.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

// First way to monitor changes in the routing stack:
class NavigationObserver extends VxObserver {
  FirebaseAnalytics fba = FirebaseAnalytics.instance;

  @override
  void didChangeRoute(Uri route, Page page, String pushOrPop) {
    if (kDebugMode) print("${route.path} - $pushOrPop");

    final String? screenName = route.path;
    if (screenName != null) {
      fba.setCurrentScreen(screenName: screenName).catchError(
        (Object error) {
          debugPrint('$FirebaseAnalyticsObserver: $error');
        },
        test: (Object error) => error is PlatformException,
      );
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (kDebugMode) print("pushed $route - $previousRoute");
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (kDebugMode) print("popped $route - $previousRoute");
  }
}

/// -----------------------------------
///              App State
/// -----------------------------------

class _AppState extends State<App> {
  final navigator = VxNavigator(
      observers: [NavigationObserver()],
      notFoundPage: (uri, params) => MaterialPage(
            key: ValueKey('not-found-page'),
            child: Builder(
              builder: (context) => Scaffold(
                body: Center(
                  child: Text('Page ${uri.path} not found'),
                ),
              ),
            ),
          ),
      routes: {
        TabbedHomeScreen.webPath: (uri, params) {
          return const MaterialPage(child: TabbedHomeScreen());
        },
        BookmarkScreen.webPath: (uri, params) {
          return const MaterialPage(child: BookmarkScreen());
        },
        ConnectScreen.webPath: (uri, params) {
          return const MaterialPage(child: ConnectScreen());
        },
        GffftListScreen.webPath: (uri, params) =>
            const MaterialPage(child: GffftListScreen()),
        RegExp(r"^\/users\/[a-zA-Z0-9\.\-]+/gfffts/[a-zA-Z0-9]+$"):
            (uri, param) => MaterialPage(
                child: GffftHomeScreen(
                    uid: uri.pathSegments[1], gid: uri.pathSegments[3])),
        RegExp(r"^\/users\/[a-zA-Z0-9\.\-]+/gfffts/[a-zA-Z0-9]+/join"):
            (uri, param) => MaterialPage(
                child: GffftJoinScreen(
                    uid: uri.pathSegments[1], gid: uri.pathSegments[3])),
        RegExp(r"^\/users\/[a-zA-Z0-9\.\-]+/gfffts/[a-zA-Z0-9]+/membership"):
            (uri, param) => MaterialPage(
                child: GffftMembershipScreen(
                    uid: uri.pathSegments[1], gid: uri.pathSegments[3])),
        RegExp(r"^\/users\/[a-zA-Z0-9\.\-]+/gfffts/[a-zA-Z0-9]+/features$"):
            (uri, param) => MaterialPage(
                child: GffftFeatureScreen(
                    uid: uri.pathSegments[1], gid: uri.pathSegments[3])),
        RegExp(r"^\/users\/[a-zA-Z0-9\.\-]+/gfffts/[a-zA-Z0-9]+/features/[a-zA-Z0-9]+/[a-zA-Z0-9]+"):
            (uri, param) => VxRoutePage(
                child: GffftFeatureScreen(
                    uid: uri.pathSegments[1],
                    gid: uri.pathSegments[3],
                    tid: uri.pathSegments[5],
                    fid: uri.pathSegments[6]),
                transition: (animation, child) => FadeTransition(
                      opacity: Tween(begin: 0.0, end: 0.0).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: child,
                    )),
        RegExp(r"^\/users\/[a-zA-Z0-9\.\-]+/gfffts/[a-zA-Z0-9]+/boards/[a-zA-Z0-9]+$"):
            (uri, param) => MaterialPage(
                    child: BoardViewScreen(
                  uid: uri.pathSegments[1],
                  gid: uri.pathSegments[3],
                  bid: uri.pathSegments[5],
                )),
        RegExp(r"^\/users\/[a-zA-Z0-9\.\-]+/gfffts/[a-zA-Z0-9]+/boards/[a-zA-Z0-9]+/post$"):
            (uri, param) => MaterialPage(
                    child: CreatePostScreen(
                  uid: uri.pathSegments[1],
                  gid: uri.pathSegments[3],
                  bid: uri.pathSegments[5],
                )),
        RegExp(r"^\/users\/[a-zA-Z0-9\.\-]+/gfffts/[a-zA-Z0-9]+/boards/[a-zA-Z0-9]+/threads/[a-zA-Z0-9]+$"):
            (uri, param) => MaterialPage(
                    child: ThreadViewScreen(
                  uid: uri.pathSegments[1],
                  gid: uri.pathSegments[3],
                  bid: uri.pathSegments[5],
                  tid: uri.pathSegments[7],
                )),
        RegExp(r"^\/users\/[a-zA-Z0-9\.\-]+/gfffts/[a-zA-Z0-9]+/boards/[a-zA-Z0-9]+/threads/[a-zA-Z0-9]+/reply$"):
            (uri, param) => MaterialPage(
                    child: CreateReplyScreen(
                  uid: uri.pathSegments[1],
                  gid: uri.pathSegments[3],
                  bid: uri.pathSegments[5],
                  tid: uri.pathSegments[7],
                )),
        RegExp(r"^\/users\/[a-zA-Z0-9\.\-]+/gfffts/[a-zA-Z0-9]+/galleries/[a-zA-Z0-9]+$"):
            (uri, param) => MaterialPage(
                    child: GalleryViewScreen(
                  uid: uri.pathSegments[1],
                  gid: uri.pathSegments[3],
                  mid: uri.pathSegments[5],
                )),
        // RegExp(r"^\/users\/[a-zA-Z0-9\.\-]+/gfffts/[a-zA-Z0-9]+/galleries/[a-zA-Z0-9]+/i/[a-zA-Z0-9\-]+$"):
        //     (uri, param) => MaterialPage(
        //             child: ItemViewScreen(
        //           uid: uri.pathSegments[1],
        //           gid: uri.pathSegments[3],
        //           mid: uri.pathSegments[5],
        //           iid: uri.pathSegments[7],
        //         )),
        RegExp(r"^\/users\/[a-zA-Z0-9\.\-]+/gfffts/[a-zA-Z0-9]+/galleries/[a-zA-Z0-9]+/post$"):
            (uri, param) => MaterialPage(
                    child: GalleryPostScreen(
                  uid: uri.pathSegments[1],
                  gid: uri.pathSegments[3],
                  mid: uri.pathSegments[5],
                )),
        RegExp(r"^\/users\/[a-zA-Z0-9\.\-]+/gfffts/[a-zA-Z0-9]+/links/[a-zA-Z0-9]+$"):
            (uri, param) => MaterialPage(
                    child: LinkSetViewScreen(
                  uid: uri.pathSegments[1],
                  gid: uri.pathSegments[3],
                  lid: uri.pathSegments[5],
                )),
        RegExp(r"^\/users\/[a-zA-Z0-9\.\-]+/gfffts/[a-zA-Z0-9]+/links/[a-zA-Z0-9]+/post$"):
            (uri, param) => MaterialPage(
                    child: LinkPostScreen(
                  uid: uri.pathSegments[1],
                  gid: uri.pathSegments[3],
                  lid: uri.pathSegments[5],
                )),
        MeScreen.webPath: (uri, params) => MaterialPage(child: MeScreen()),
      });

  bool isBusy = false;
  bool isLoggedIn = false;
  late String errorMessage;
  late String name;
  late String picture;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth0 Demo',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
      ],
      home: Scaffold(
        appBar: AppBar(
          title: Text('Auth0 Demo'),
        ),
        body: Center(
          child: TextButton(
            onPressed: () => _onLogin(),
            child: Text('Login'),
          ),
        ),
      ),
    );
  }

  _onLogin() {
    setState(() {
      isBusy = true;
    });

    _login().then((user) {
      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = user.name;
        picture = user.picture;
      });
    }).catchError((error) {
      setState(() {
        isBusy = false;
        errorMessage = error.toString();
      });
    });
  }
}
