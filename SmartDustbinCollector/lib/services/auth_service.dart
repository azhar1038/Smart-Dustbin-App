// A service class implementing FirebaseAuth

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_dustbin/datamodels/user_model.dart';

@lazySingleton
class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _google = GoogleSignIn();

  /// To check is any [User] (FirebaseUser) exists
  bool isUserSigned() {
    return _auth.currentUser != null;
  }

  /// Get the uid of currently signed [User]
  String get userId => _auth.currentUser.uid;

  /// Get the firebase token of currently signed [User]
  Future<String> get userToken => _auth.currentUser.getIdToken();

  Future<UserModel> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _google.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final User user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    return UserModel(email: user.email, id: user.uid);
  }

  /// Logout the [User]
  Future logout() async {
    await _google.signOut();
    await _auth.signOut();
  }
}
