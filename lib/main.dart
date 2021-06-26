import 'package:camp_navigate/Pages/AuthPages/welcome_page.dart';
import 'package:camp_navigate/Pages/mental_health_tracker.dart';
import 'package:camp_navigate/Pages/nutrition_tracker.dart';
import 'package:camp_navigate/Pages/physical_activities_tracker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Pages/home_page.dart';

void setupLocator() {
  // GetIt.instance.registerLazySingleton(() => SlidersService());
  // GetIt.instance.registerLazySingleton(() => UserService());
  // GetIt.instance.registerLazySingleton(() => ServiceService());
  // GetIt.instance.registerLazySingleton(() => ClinicService());
  // GetIt.instance.registerLazySingleton(() => InsuranceService());
  // GetIt.instance.registerLazySingleton(() => GalleryService());
  // GetIt.instance.registerLazySingleton(() => ReviewService());
  // GetIt.instance.registerLazySingleton(() => AppointmentService());
  // GetIt.instance.registerLazySingleton(() => DocumentService());
  // GetIt.instance.registerLazySingleton(() => FileService());
  // GetIt.instance.registerLazySingleton(() => CertificatesService());
  // GetIt.instance.registerLazySingleton(() => PushNotificationsService());
  // GetIt.instance.registerLazySingleton(() => PartnerService());
  // GetIt.instance.registerLazySingleton(() => FirebaseService());
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


  @override
  void initState() {
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
      child: MaterialApp(
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
        initialRoute: '/welcome',
        routes: {
          "/home": (context) => HomePage(),
          "/welcome": (context) => WelcomeScreenPage(),
          "/physical": (context) => PhysicalActivitiesTracker(),
          "/nutrition": (context) => NutritionTracker(),
          "/mental": (context) => MentalHealthTracker(),
        },
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