import '../api_base.dart';
import '../models/user.dart';

class FeedApi extends ApiBase {
  Future<User?> me() async {
    // fb_auth.FirebaseAuth auth = fb_auth.FirebaseAuth.instance;
    // final fbUser = await auth.authStateChanges().first;
    // if (fbUser == null) {
    //   return null;
    // }
    // await FirebaseAnalytics.instance.setUserId(id: fbUser.uid);

    final response = await getAuthenticated("users/me");

    return User.fromJson(response);
  }

  Future<User> changeUsername() async {
    final response = await postAuthenticated("users/me/change-username");

    return User.fromJson(response);
  }
}
