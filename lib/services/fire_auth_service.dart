import '../main_index.dart';

class FireAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user anoymously for favorites
  static void createUser() {
    _auth.signInAnonymously().then((value) {
      if (value != null) {
        FirebaseUser _user = value.user;
        print(_user.uid.toString());
      }
    });
  }

  // check user login
  static Future<bool> checkUser() async {
    FirebaseUser _user = await _auth.currentUser();
    if (_user != null) {
      return true;
    } else {
      return false;
    }
  }
}
