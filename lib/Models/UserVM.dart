import 'package:flutter/cupertino.dart';
import 'package:line_icons/line_icons.dart';

class UserVM with ChangeNotifier {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  String? gender;
  bool? admin;
  int? age;
  int? totalPoints;
  int? physicalActivityPoints;
  int? mentalHealthPoints;
  int? healthyPoints;

  UserVM(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.password,
      this.admin,
      this.totalPoints,
      this.physicalActivityPoints,
      this.mentalHealthPoints,
      this.healthyPoints,
      this.age,
      this.gender,
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

  void updateAdminAccess(bool admin) {
    this.admin = admin;
    notifyListeners();
  }

  void updateTotalPoints(int totalPoints) {
    this.totalPoints = totalPoints;
    notifyListeners();
  }

  void updatePhysicalActivityPoints(int physicalActivityPoints) {
    this.physicalActivityPoints = physicalActivityPoints;
    notifyListeners();
  }

  void updateMentalHealthPoints(int mentalHealthPoints) {
    this.mentalHealthPoints = mentalHealthPoints;
    notifyListeners();
  }

  void updateHealthyPints(int healthyPoints) {
   this.healthyPoints = healthyPoints;
    notifyListeners();
  }

  void updateAge(age) {
    this.age = age;
    notifyListeners();
  }

  void updateGender(gender) {
    this.gender = gender;
    notifyListeners();
  }
}
