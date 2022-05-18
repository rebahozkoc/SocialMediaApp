import 'package:flutter/material.dart';
import 'package:sabanci_talks/bottom_bar/view/bottom_bar_view.dart';
import 'package:sabanci_talks/home/view/likes_view.dart';
import 'package:sabanci_talks/sign_up/view/sign_up_view.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/welcome/view/welcome_view.dart';
import 'package:sabanci_talks/home/view/home_view.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final is_logined = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: AppColors.primary,
          secondaryHeaderColor: AppColors.secondary,
          
        ),
        routes: {
          '/': (context) => is_logined ? const BottomBarView() : const Welcome(),
          SignUp.routeName: (context) => const SignUp(),
          //Login.routeName: (context) => Login(),
          HomeView.routeName: (context) => const HomeView(),
        },

    onUnknownRoute: (RouteSettings settings) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) =>
            const Scaffold(body:Center(child: Text('Not Found'))),
      );
    }
    );
  }
}

