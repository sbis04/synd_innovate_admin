import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
bool authSignedIn;
String name;
String uid;
String imageUrl;

final CollectionReference mainCollection =
    Firestore.instance.collection('synd');

// use this for testing database
final DocumentReference documentReference = mainCollection.document('test');

// use this for production [Warning: LIVE Database]
// final DocumentReference documentReference = mainCollection.document('prod');

Future getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  authSignedIn = prefs.getBool('auth') ?? false;

  final FirebaseUser user = await _auth.currentUser();

  if (authSignedIn == true) {
    if (user != null) {
      name = user.displayName;
      uid = user.uid;
      imageUrl = user.photoUrl;
    }
  }
}

// Future deleteUser() async {
//   final FirebaseUser user = await _auth.currentUser();

//   user.delete();
// }

Future<String> signInWithGoogle() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  // FirebaseUser user = await _auth.signInWithGoogle();

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.uid != null);

  name = user.displayName;
  uid = user.uid;
  imageUrl = user.photoUrl;

  // if (name.contains(" ")) {
  //   name = name.substring(0, name.indexOf(" "));
  // }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  prefs.setBool('auth', true);
  authSignedIn = true;

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);
  authSignedIn = false;

  print("User Sign Out");
}
