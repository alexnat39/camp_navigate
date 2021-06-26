import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class fetch_user_data  {

  static Future<Map<String,dynamic>>fetch_user_dataM(BuildContext context) async {
    var data = Map<String, dynamic>();


    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => {
      data = value.data()!
    })
        .catchError((e) => {

      Alert(
          context: context,
          type: AlertType.error,
          title: "Something went wrong.",
          desc: 'Please try again.',
          buttons: [
            DialogButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.red,
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ]).show()
    });
   return data;
  }


}

