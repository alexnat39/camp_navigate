import 'package:camp_navigate/Models/Rewards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

class AddReward extends StatefulWidget {
  late String collection;

  AddReward(this.collection);

  @override
  _AddRewardState createState() => _AddRewardState();
}

class _AddRewardState extends State<AddReward> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add a Reward'),
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
                          labelText: 'Reward TItle',
                        ),

                        // valueTransformer: (text) => num.tryParse(text),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.maxLength(context, 15),
                        ]),
                        keyboardType: TextInputType.name,
                      ),
                      FormBuilderTextField(
                        name: 'description',
                        decoration: InputDecoration(
                          labelText: 'Description',
                        ),

                        // valueTransformer: (text) => num.tryParse(text),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.max(context, 200),
                        ]),
                        keyboardType: TextInputType.multiline,
                      ),
                      FormBuilderTextField(
                        name: 'points',
                        decoration: InputDecoration(
                          labelText: 'Points',
                        ),

                        // valueTransformer: (text) => num.tryParse(text),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.max(context, 100),
                        ]),
                        keyboardType: TextInputType.multiline,
                      ),
                      FormBuilderImagePicker(
                        name: 'image',
                        decoration: const InputDecoration(labelText: 'Logo'),
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
                            final title =
                                _formKey.currentState!.fields['title']!.value;

                            final description = _formKey
                                .currentState!.fields['description']!.value;
                            final points =
                                _formKey.currentState!.fields['points']!.value;

                            final image =
                                _formKey.currentState!.fields['image']!.value;
                            print(image);



                            try {
                              //uploading logo and data

                              uploadLogoFileAndData(context, image, title,
                                  description, points, widget.collection);
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

void uploadLogoFileAndData(BuildContext context, List<dynamic> _images, name,
    description, points, collection) async {
  String logoLink = "";
  Reference ref = FirebaseStorage.instance.ref().child('$name/logo.jpg');
  for (var image in _images)
    await ref.putFile(image).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        print('Logo Link:$value');
        logoLink = value;
      });
    });
  final reward = Reward(name, description, points, logoLink);

  FirebaseFirestore.instance
      .collection(collection)
      .add(reward.toMap())
      .whenComplete(() {
    //  HelperMethods.showAlertDialog(
    //     context, 'Success', '$name has successfully added');
  });
}
