import 'package:ctrl_money/account/views/account_details.dart';
import 'package:ctrl_money/account/views/account_transactions_page.dart';
import 'package:ctrl_money/account/views/accounts_page.dart';
import 'package:ctrl_money/account/views/add_account_page.dart';
import 'package:ctrl_money/home/repositories/home_repository.dart';
import 'package:ctrl_money/home/views/home_page.dart';
import 'package:ctrl_money/profile/views/profile_edit_page.dart';
import 'package:ctrl_money/profile/views/profile_page.dart';
import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:ctrl_money/shared/utils/custom_dio.dart';
import 'package:ctrl_money/signup/views/signup_page.dart';
import 'package:ctrl_money/transactions/views/transaction_add_page.dart';
import 'package:ctrl_money/transactions/views/transaction_edit_page.dart';
import 'package:ctrl_money/transactions/views/transaction_list_page.dart';
import 'package:ctrl_money/transactions/views/transaction_list_pending.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'home/stores/home_store.dart';
import 'login/view/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<HomeStore>(
              create: (_) => HomeStore(HomeReposiory(CustomDio())))
        ],
        child: MaterialApp(
          title: 'Ctrl Pay',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              backgroundColor: darker,
              cursorColor: blue,
              fontFamily: GoogleFonts.nunito(color: primaryText).fontFamily,
              primaryColor: blue,
              accentColor: lighter,
              textTheme: TextTheme(button: TextStyle(color: secondaryText)),
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(),
                  fillColor: lighter,
                  filled: true,
                  isDense: true,
                  labelStyle: TextStyle(color: secondaryText))),
          routes: {
            '/': (context) => LoginPage(),
            '/home': (context) => HomePage(),
            '/login': (context) => LoginPage(),
            '/signup': (context) => SignUpPage(),
            '/profile': (context) => ProfilePage(),
            '/profile/edit': (context) => ProfileEditPage(),
            '/account': (context) => AccountsPage(),
            '/account/add': (context) => AddAccountPage(),
            '/account/details': (context) => AccountDetailsPage(),
            '/account/transactions': (context) => AccountTransactionsPage(),
            '/transaction/add': (context) => TransactionAddPage(),
            '/transaction': (context) => TransactionListPage(),
            '/transaction/pending': (context) => TransactionListPendingPage(),
            '/transaction/edit': (context) => TransactionEditPage()
          },
        ));
  }
}
