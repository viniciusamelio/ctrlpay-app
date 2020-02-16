import 'package:ctrl_money/home/views/home_page.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:ctrl_money/signup/views/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login/view/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ctrl Pay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: darker,
        cursorColor: blue, 
        fontFamily: GoogleFonts.nunito(color: primaryText).fontFamily,
        primaryColor: blue,       
        textTheme: TextTheme(button: TextStyle(color: secondaryText)),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          fillColor: lighter,
          filled: true,
          isDense: true,                              
          labelStyle: TextStyle(
            color: secondaryText                        
          )
        )
      ),
      routes: {
        '/' : (context)=> LoginPage(),
        '/home' : (context) => HomePage(),
        '/login' : (context) => LoginPage(),
        '/signup' : (context) => SignUpPage()
      },
    );
  }
}
