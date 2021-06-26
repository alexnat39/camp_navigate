import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  var _firebase = FirebaseFirestore.instance;

  /**
   * adds the user to the database of users
   */
  Future<dynamic> addUser({
    String? firstName,
    String? lastName,
    String? email,
    String? id,
    bool? admin,
  }) async {
    try {
      _firebase
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'id': id,
        'admin': false,
        'totalPoints': 0,
        'physicalActivityPoints': 0,
        'mentalHealthPoints':0
      });
    } catch (e) {
      print(e);
      return;
    }
  }

  /**
   * updates the user in the database of users
   * if returns 1 - error, 2 - email already exists, 0 - success
   */
  Future<int> updateUserInAuth({
    String? email,
  }) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      if (email != _prefs.getString("email")) {
        var authResult = await FirebaseAuth.instance.currentUser!
            .reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: _prefs.getString("email")!,
            password: _prefs.getString("password")!,
          ),
        );
        var emails = await FirebaseFirestore.instance
            .collection("users")
            .where('email', isEqualTo: email)
            .get();
        if (emails.docs.length != 0) {
          return 2;
        }
        authResult.user!.updateEmail(email!);
      }
      return 0;
    } catch (e) {
      return 1;
    }
  }

  Future<int> updateUserInFirestore(
      {String? email,
      String? firstName,
      String? lastName}) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _firebase
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
      });
      _prefs.setString("email", email!);
      return 0;
    } on Exception catch (e) {
      print(e);
      return 1;
    } catch (e) {
      print(e);
      return 1;
    }
  }

  /**
   * gets the data of the user with specified id
   */
  Future<dynamic> fetchUserData() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        var result = await _firebase
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        return result;
      }
    } catch (e) {
      print(e);
      return;
    }
  }
}
