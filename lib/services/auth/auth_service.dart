import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() => _auth.currentUser;

  // signin with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // return userCredential;

      _firestore.collection("Users").doc(userCredential.user!.uid).set(
       {
            "uid": userCredential.user!.uid,
            "email": email,
            }
                       );

    } on FirebaseAuthException catch (e) {
       throw Exception(e.code);
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // return userCredential;

       _firestore.collection("Users").doc(userCredential.user!.uid).set(
       {
            "uid": userCredential.user!.uid,
            "email": email,
            }
        );

    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // save user data to firestore

  //logout
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}