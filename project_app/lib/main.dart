import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_app/routs.dart';
import 'package:project_app/ui/screens/login/login_screen.dart';
import 'package:project_app/ui/screens/main/main_screen.dart';
import 'package:project_app/ui/screens/testScreen/TestScreen.dart';
import 'package:project_app/ui/screens/testScreen/googleMap/google_map_screen.dart';

import 'constants.dart';
import 'core/services/AuthService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget screen = LoginScreen();
  if (await AuthService.isLogin() == true) {
    screen = MainScreen();
  }
  runApp(MyApp(screen: screen));
}

class MyApp extends StatelessWidget {
  final Widget screen;

  MyApp({
    Key key,
    @required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: UiFont,
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          color: creamPrimaryColor,
          brightness: Brightness.light,
          iconTheme: IconThemeData(
            color: navyPrimaryColor,
          ),
          textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 18,
              fontFamily: UiFont,
              fontWeight: FontWeight.bold,
              color: navyPrimaryColor,
            ),
          ),
        ),
      ),
      title: 'Flutter Demo',
      routes: routes,
     home: screen,
       // home: TestScreen(),
      // home: LocationScreen(),
      // home: GoogleMapScreen(),
      // home: SelectField(),
      // home: FirstScreen(),
      // home: ClubScreen(),
      // home: HomeScreen(),
      // home: ProfileScreen(),
      // home: LoginScreen(),
    );
  }
}
