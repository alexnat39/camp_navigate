import 'package:camp_navigate/Models/Activity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Add extends StatefulWidget {

late String collection;

Add(this.collection);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add'),
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
                          FormBuilderTextField(
                            name: 'title',
                            decoration: InputDecoration(
                              labelText: 'Title',
                            ),

                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.maxLength(context, 50),
                            ]),
                            keyboardType: TextInputType.name,
                          ),
                          FormBuilderTextField(
                            name: 'points',
                            decoration: InputDecoration(
                              labelText: 'Number of Points',
                            ),

                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.numeric(context),
                              FormBuilderValidators.required(context),
                            ]),
                            keyboardType: TextInputType.numberWithOptions(),
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
                                final name =
                                    _formKey.currentState!.fields['title']!.value;
                                print(name);
                                final points = _formKey
                                    .currentState!.fields['points']!.value;

                                final photoFileLinks;

                                try {
                                  //uploading logo and data only  for non chamber member, photoFileLinks
                                  // is uploaded empty nd can be changed later if they become a member
                                  uploadData(context, points, name,widget.collection
                                    );
                                } catch (error) {
                                  print(error);
                          //        HelperMethods.showAlertDialog(context, 'Error',
                                    //  'You need to add an image or deselect Chamber Member');
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

void uploadData(BuildContext context,points, name, collection
   ) async {
  final activity = Activity(name, points);

  FirebaseFirestore.instance
      .collection(collection)
      .add(activity.toMap())
      .whenComplete(() {
 //   HelperMethods.showAlertDialog(
   //     context, 'Success', '$name has successfully added');
  });
}