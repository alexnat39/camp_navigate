
import 'package:camp_navigate/CustomWidgets/TrackerPageWidgets/chosen_option_widget.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/AppBarWidgets/container_app_bar.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/custom_universal_button.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/show_alert.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/show_loading_dialog.dart';
import 'package:camp_navigate/CustomWidgets/UniversalWidgets/show_snack_bar.dart';
import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:camp_navigate/Services/physical_activity_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PhysicalActivitiesTrackerPage extends StatefulWidget {
  // const PhysicalActivitiesTrackerPage({Key? key}) : super(key: key);

  @override
  _PhysicalActivitiesTrackerPageState createState() =>
      _PhysicalActivitiesTrackerPageState();
}

class _PhysicalActivitiesTrackerPageState
    extends State<PhysicalActivitiesTrackerPage> {
  PhysicalActivityService get physicalActivityService => GetIt.instance<PhysicalActivityService>();

  List<String>? whatDidYouDoTodayOptions;
  List<String>? chosenOptions = [];
  bool _showSubmitButton = false;

  @override
  void initState() {
    whatDidYouDoTodayOptions = [
      "Run",
      "Walk",
      "Workout",
      "Play football",
      "Play basketball"
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.WHITE,
        body: ListView(
          children: [
            CustomContainerAppBar(
              title: "Physical Activity Tracker",
              isInitialPage: false,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                        isExpanded: true,
                        hint: Text(
                          "What did you do today?",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: "GothamProNormal",
                              color: CustomColors.GREY,
                              fontSize: 16),
                        ),
                        items:
                            List.generate(whatDidYouDoTodayOptions!.length, (index) {
                          return DropdownMenuItem(
                            child: Text(
                              whatDidYouDoTodayOptions![index],
                              style: TextStyle(fontFamily: 'GothamProNormal'),
                            ),
                            value: index,
                          );
                        }),
                        onChanged: (index) {
                          print(index);
                          setState(() {
                            if (!chosenOptions!.contains(whatDidYouDoTodayOptions![int.parse(index.toString())])) {
                              _showSubmitButton = true;
                              chosenOptions!
                                  .insert(0, whatDidYouDoTodayOptions![int.parse(index.toString())]);
                            }
                          });
                        }),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: chosenOptions!.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          onDismissed: (direction) {
                            setState(() {
                              chosenOptions!.removeAt(index);
                              if (chosenOptions!.length == 0) {
                                _showSubmitButton = false;
                              }
                            });
                          },
                          key: Key(chosenOptions![index]),
                          child: CustomChosenTrackerOptionWidget(
                            optionName: chosenOptions![index],
                          ),
                        );
                      }),
                  (_showSubmitButton) ? CustomUniversalButton(text: "Submit", borderColor: CustomColors.PHYSICAL, mainColor: CustomColors.PHYSICAL, textColor: CustomColors.WHITE, onPressedFunction: () async {
                    //todo send a request to firestore
                    showLoadingDialog(context);
                    int result = await physicalActivityService.sendPhysicalActivitiesList(FirebaseAuth.instance.currentUser!.uid, chosenOptions!);
                    //popping loading dialog
                    Navigator.pop(context);
                    if (result == 0) {
                      //show success snack bar
                      showCustomSnackBar(context, "success");
                      setState(() {
                        chosenOptions!.clear();
                        _showSubmitButton = false;
                      });
                    }
                   else if (result == 1) {
                      showAlert(context, "An error occurred");
                    }


                  },) : Container()
                ],
              ),
            ),

          ],
        ));
  }
}
