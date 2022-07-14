import 'package:dissipate/components/first_page_exception_indicator.dart';
import 'package:dissipate/models/user.dart';
import 'package:dissipate/style/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../users/me_screen.dart';
import '../users/user_api.dart';

final getIt = GetIt.instance;

final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

class TabbedHomeScreen extends StatefulWidget {
  const TabbedHomeScreen({Key? key}) : super(key: key);

  static const String webPath = '/';

  @override
  State<TabbedHomeScreen> createState() => _TabbedHomeScreenState();
}

class _TabbedHomeScreenState extends State<TabbedHomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  UserApi userApi = getIt<UserApi>();
  Future<User?>? user;

  int _selectedIndex = 0;
  int _lastTabIndex = 0;
  List<BuildContext?> navStack = [
    null,
    null,
    null
  ]; // one buildContext for each tab to store history  of navigation
  late List<Widget> mainTabs;

  Future<void> _userSignedIn() async {
    setState(() {
      _tabController.animateTo(1);
      //user = userApi.me();
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    mainTabs = <Widget>[
      Navigator(onGenerateRoute: (RouteSettings settings) {
        return PageRouteBuilder(pageBuilder: (context, animiX, animiY) {
          // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation
          navStack[0] = context;
          return MeScreen(onLogin: _userSignedIn);
        });
      }),
      Navigator(onGenerateRoute: (RouteSettings settings) {
        return PageRouteBuilder(pageBuilder: (context, animiX, animiY) {
          // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation

          navStack[1] = context;
          return MeScreen(onLogin: _userSignedIn);
        });
      }),
      Navigator(onGenerateRoute: (RouteSettings settings) {
        return PageRouteBuilder(pageBuilder: (context, animiX, animiY) {
          // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation

          navStack[1] = context;
          return MeScreen(onLogin: _userSignedIn);
        });
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme.materialTheme;

    return Theme(
        data: ThemeData.dark().copyWith(
            appBarTheme: theme.appBarTheme,
            scaffoldBackgroundColor: theme.scaffoldBackgroundColor,
            textTheme: theme.textTheme),
        child: WillPopScope(
          onWillPop: () async {
            setState(() {
              _selectedIndex = _tabController.index;
            });
            var whatContext = navStack[_selectedIndex] ?? context;
            if (Navigator.of(whatContext).canPop()) {
              Navigator.of(whatContext).pop();
              return false;
            } else {
              if (_tabController.index == 0) {
                SystemChannels.platform
                    .invokeMethod('SystemNavigator.pop'); // close the app
                return true;
              } else {
                setState(() {
                  _selectedIndex = _tabController.index;
                });
                _tabController.index =
                    0; // back to first tap if current tab history stack is empty
                return false;
              }
            }
          },
          child: Scaffold(
            appBar: AppBar(
              flexibleSpace: SafeArea(
                  child: TabBar(
                onTap: (value) {
                  if (value == _lastTabIndex) {
                    var whatContext = navStack[value] ?? context;
                    if (Navigator.of(whatContext).canPop()) {
                      Navigator.of(whatContext).pop();
                    }
                  }
                  _lastTabIndex = value;
                },
                controller: _tabController,
                tabs: const [
                  Tab(icon: Icon(Icons.public)),
                  Tab(icon: Icon(IconData(0x0047, fontFamily: 'Gffft'))),
                  Tab(icon: Icon(Icons.account_box)),
                ],
              )),
              automaticallyImplyLeading: false,
            ),
            body: TabBarView(
              controller: _tabController,
              children: mainTabs,
            ),
          ),
        ));
  }
}

class NoFeaturedFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const FirstPageExceptionIndicator(
        title: 'No featured gfffts found',
        message: 'Guess nothing is featured',
      );
}

class NoBookmarksFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const FirstPageExceptionIndicator(
        title: 'No bookmarks found',
        message: 'Gfffts that you bookmark will appear here',
      );
}
