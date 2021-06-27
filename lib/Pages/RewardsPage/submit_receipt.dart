import 'package:camp_navigate/Services/fetch_user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

class SubmitRecipt extends StatefulWidget {


  @override
  _SubmitReciptState createState() => _SubmitReciptState();
}

class _SubmitReciptState extends State<SubmitRecipt> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add a Receipt'),
        ),
        body: new Container(
            padding: new EdgeInsets.all(10.0),
            child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[

                          FormBuilderImagePicker(
                            name: 'image',
                            decoration: const InputDecoration(labelText: 'Receipt'),
                            maxImages: 1,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            color: Theme.of(context).accentColor,
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              print('execute');
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                print(_formKey.currentState!.value);


                                final image =
                                    _formKey.currentState!.fields['image']!.value;
                                print(image);



                                try {
                                  //uploading logo and data


                                } catch (Error) {
                                  //     HelperMethods.showAlertDialog(context, 'Error',
                                  //       'You need to add an image or deselect Chamber Member');
                                  return;
                                }
                                // print('creating businees');

                              } else {
                                print("validation failed");
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: MaterialButton(
                            color: Theme.of(context).accentColor,
                            child: Text(
                              "Reset",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _formKey.currentState!.reset();
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ))));
  }
}

void convertImage(BuildContext context, List<dynamic> _images,) async {
  String logoLink = "";

  for (var image in _images) {
    //encode to 64 bit string
  }

}
void updateTotalPoints (int points,BuildContext context) {
  var data = Map<String, dynamic>();
  var previousData = Map<String,dynamic>();
  fetch_user_data.fetch_user_dataM(context).then((value) => previousData = value);
  data['totalPoints'] = previousData['totalPoints']+points;
  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(data);
}


