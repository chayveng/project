import 'package:flutter/widgets.dart';
import 'package:project_app/ui/screens/booking/booking_screen.dart';
import 'package:project_app/ui/screens/club/club_screen.dart';
import 'package:project_app/ui/screens/home/home_screen.dart';
import 'package:project_app/ui/screens/login/login_screen.dart';
import 'package:project_app/ui/screens/profile/profile_screen.dart';
import 'package:project_app/ui/screens/register/register_screen.dart';
import 'package:project_app/ui/screens/testScreen/TestScreen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  BookingScreen.routeName: (context) => BookingScreen(),
  TestScreen.routeName: (context) => TestScreen(),
  ClubScreen.routeName: (context) => ClubScreen(),
};


