
import 'package:flutter/material.dart';
import 'package:project_app/ui/screens/home/home_screen.dart';
import 'package:project_app/ui/screens/login/login_screen.dart';
import 'package:project_app/ui/screens/profile/profile_screen.dart';
import 'package:project_app/ui/screens/register/register_screen.dart';


class Config {
  // static String API_URL = 'http://172.20.10.3:8080';
  // static String API_URL = 'http://172.16.3.37:8080';
  // static String API_URL = 'http://172.24.161.141:8080';
  static String API_URL = 'http://localhost:8080';
  static final route = <String, WidgetBuilder>{
    '/home_screen': (BuildContext context) => HomeScreen(),
    '/login_screen': (BuildContext context) => LoginScreen(),
    '/register_screen': (BuildContext context) => RegisterScreen(),
    '/profile_screen': (BuildContext context) =>  ProfileScreen(),
  };
}
