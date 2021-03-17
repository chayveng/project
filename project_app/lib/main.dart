import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/routs.dart';
import 'package:project_app/ui/screens/login/login_screen.dart';
import 'package:project_app/ui/screens/main/main_screen.dart';
import 'core/services/AuthService.dart';
import 'ui/screens/booking/booking_screen.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/screens/other/other_screen.dart';
import 'ui/screens/other/other_screen.dart';
import 'ui/screens/profile/profile_screen.dart';

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

  // final darkTheme = ThemeData(
  //   primarySwatch: Colors.grey,
  //   primaryColor: Colors.black,
  //   brightness: Brightness.dark,
  //   backgroundColor: const Color(0xFF212121),
  //   accentColor: Colors.white,
  //   accentIconTheme: IconThemeData(color: Colors.black),
  //   dividerColor: Colors.black12,
  // );
  //
  // final lightTheme = ThemeData(
  //   primarySwatch: Colors.grey,
  //   primaryColor: Colors.white,
  //   brightness: Brightness.light,
  //   backgroundColor: const Color(0xFFE5E5E5),
  //   accentColor: Colors.black,
  //   accentIconTheme: IconThemeData(color: Colors.white),
  //   dividerColor: Colors.white54,
  // );

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
        ),
      ),
      title: 'Flutter Demo',
      routes: routes,
      // home: screen,
      // home: SelectField(),
      // home: FirstScreen(),
      // home: ClubScreen(),
      // home: HomeScreen(),
      // home: ProfileScreen(),
      // home: LoginScreen(),
      // home: TestScreen(),
      // home: OtherScreen(),
      home: MainScreen(),
    );
  }
}
