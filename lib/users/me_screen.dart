import 'package:dissipate/style/app_theme.dart';
import 'package:dissipate/users/user_api.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get_it/get_it.dart';

import '../common/dates.dart';
import '../generated/dissipate.pb.dart';

final getIt = GetIt.instance;

class MeScreen extends StatefulWidget {
  static const String webPath = '/users/me';
  final VoidCallback? onLogin;

  const MeScreen({super.key, this.onLogin});

  @override
  State<MeScreen> createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  UserApi userApi = getIt<UserApi>();
  Future<RegisterResponse?>? registerResponse;
  fba.FirebaseAuth fbAuth = fba.FirebaseAuth.instance;

  Future<void> _loadData() async {
    setState(() {
      registerResponse = userApi.me();
    });
  }

  Future<void> _onLogin() async {
    if (widget.onLogin != null) {
      widget.onLogin!();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: registerResponse,
        builder: (context, AsyncSnapshot<RegisterResponse?> snapshot) {
          Widget screenBody = const LoadingIndicator(size: 30, borderWidth: 1);

          if (snapshot.hasError) {
            // Navigator.pushReplacementNamed(context, LoginScreen.webPath);
            // Future.delayed(Duration.zero, () async {
            //   VxNavigator.of(context).clearAndPush(Uri(path: LoginScreen.webPath));
            // });
          }

          if (snapshot.connectionState == ConnectionState.done) {
            var user = snapshot.data;
            if (user != null) {
              screenBody = getMeScreen(context, user);
            } else {
              screenBody = const SignInScreen(providerConfigs: [
                EmailProviderConfiguration(),
                PhoneProviderConfiguration()
              ]);
            }
          }

          return screenBody;
        });
  }

  Widget getMeScreen(BuildContext context, RegisterResponse user) {
    var l10n = AppLocalizations.of(context);
    final theme = context.appTheme.materialTheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          l10n!.me,
          style: theme.textTheme.displayLarge,
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          Card(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 20),
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: const BorderSide(
                    color: Color(0xFF9970A9),
                    width: 1.0,
                  )),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                      width: double.infinity,
                      child: Column(children: [
                        SelectableText(l10n.loggedIn),
                        SelectableText(
                          l10n.homeAccountSince(formatDateTime(user.created.toDateTime())),
                          style: theme.textTheme.titleLarge,
                        )
                      ])))),
          TextButton(
              onPressed: () => {fbAuth.signOut().then((value) => _loadData())},
              child: Text(l10n.logout))
        ],
      )),
    );
  }
}
