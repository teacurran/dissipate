import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';

import '../generated/dissipate.pbgrpc.dart';

class UserApi {
  DissipateServiceClient _client;

  UserApi(this._client);

  Future<Account?> me() async {
    print("me()");
    fb_auth.FirebaseAuth auth = fb_auth.FirebaseAuth.instance;
    final fbUser = await auth.authStateChanges().first;
    if (fbUser == null) {
      return null;
    }
    await FirebaseAnalytics.instance.setUserId(id: fbUser.uid);

    try {
      print("getting user: ");

      final String token = await fbUser.getIdToken(false);
      if (kDebugMode) {
        print('auth token: $token');
      }
      final response = await _client.register(RegisterRequest(), options: CallOptions(
        metadata: {'Authentication': token}
      ));
      print("got user: " + response.toDebugString());

      return response.account;
    } catch (error) {
      print("error: " + error.toString());
    }
  }
}
