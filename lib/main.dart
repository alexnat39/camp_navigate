import 'package:camp_navigate/Admin/admin.dart';
import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:camp_navigate/Pages/AuthPages/login_page.dart';
import 'package:camp_navigate/Pages/AuthPages/welcome_page.dart';
import 'package:camp_navigate/Pages/main_page.dart';
import 'package:camp_navigate/Services/physical_activity_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/UserVM.dart';
import 'Pages/AuthPages/reset_password_page.dart';
import 'Pages/AuthPages/sign_up_page.dart';
import 'Pages/TrackerPages/mental_health_tracker_page.dart';
import 'Pages/TrackerPages/nutrition_tracker_page.dart';
import 'Pages/TrackerPages/physical_activities_tracker_page.dart';
import 'Services/authentication_service.dart';
import 'Services/user_service.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => AuthenticationService());
  GetIt.instance.registerLazySingleton(() => UserService());
  GetIt.instance.registerLazySingleton(() => PhysicalActivityService());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  SharedPreferences? _prefs;

  Future<void> _getSharedPreferencesInstance() async {
    //setting up the shared preferences
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    _getSharedPreferencesInstance();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else
          return true;
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserVM>(
            create: (context) => (_prefs!.getString("email") != null) ? UserVM(
              id: _prefs!.getString("id"),
              email: _prefs!.getString("email"),
              firstName: _prefs!.getString("first_name"),
              lastName: _prefs!.getString("last_name"),
              totalPoints: _prefs!.getInt("total_points"),
            ) : UserVM(),
          ),
        ],
        child: FutureBuilder(
          future: fetchUserData(context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return (snapshot.data == null)
                ? Container(
              color: CustomColors.WHITE,
            )
                : MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return ScrollConfiguration(
                  behavior: NoGlowBehavior(),
                  child: child!,
                );
              },
              theme: ThemeData(
                fontFamily: 'GothamPro',
              ),
              initialRoute: (FirebaseAuth.instance.currentUser != null)
                  ? (snapshot.data ? '/admin' : '/home')
                  : '/welcome',
              routes: {
                "/home": (context) => MainPage(),
                "/admin": (context) => Admin(),
                "/welcome": (context) => WelcomeScreenPage(),
                "/login": (context) => LoginPage(),
                "/signup": (context) => SignUpPage(),
                "/reset_password": (context) => ResetPasswordPage(),
                "/physical": (context) => PhysicalActivitiesTrackerPage(),
                "/nutrition": (context) => NutritionTrackerPage(),
                "/mental": (context) => MentalHealthTrackerPage(),
              },
            );
          },
        ),
      ),
    );
  }
}

/**
 * this function is used above to disable glow when scrolling
 */
class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

Future<bool> fetchUserData(context) async {
  bool _admin = false;
  bool errorPresent = false;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) => {
    _admin = value['admin'],
    print("admin: $_admin")
  })
      .catchError((e) => {
    errorPresent = true,
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
  if (errorPresent) {
    return false;
  }
  // Send report
  return _admin;
}
