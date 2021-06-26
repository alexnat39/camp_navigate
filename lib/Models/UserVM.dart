import 'package:flutter/cupertino.dart';


class UserVM with ChangeNotifier {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? password;

  UserVM(
      {this.id,
        this.email,
        this.password,
        this.firstName,
        this.lastName
        });


  void updateEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }


  void updatePassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }

  void updateFirstName(String newName) {
    firstName = newName;
    notifyListeners();
  }

  void updateLastName(String newName) {
    lastName = newName;
    notifyListeners();
  }


}
