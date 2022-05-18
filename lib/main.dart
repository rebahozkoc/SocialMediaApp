import 'package:flutter/material.dart';
import 'package:sabanci_talks/bottom_bar/view/bottom_bar_view.dart';
import 'package:sabanci_talks/home/view/likes_view.dart';
import 'package:sabanci_talks/sign_up/view/sign_up_view.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/walkthrough/view/walkthrough_view.dart';
import 'package:sabanci_talks/welcome/view/welcome_view.dart';
import 'package:sabanci_talks/home/view/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final is_logined = true;
  int? firstLoad;
  SharedPreferences? prefs;

  decideRoute() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      firstLoad = (prefs!.getInt('appInitialLoad') ?? 0);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    decideRoute();
  }

  @override
  Widget build(BuildContext context) {
    if (firstLoad == null) {
      return Container();
    } else if (firstLoad == 0) {
      firstLoad = 1;
      prefs!.setInt('appInitialLoad', firstLoad!);
      return  MaterialApp(
         title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
            primaryColor: AppColors.primary,
            secondaryHeaderColor: AppColors.secondary,
          ),
          home: IntroScreen());
    } else {
      return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
            primaryColor: AppColors.primary,
            secondaryHeaderColor: AppColors.secondary,
          ),
          routes: {
            '/': (context) =>
                is_logined ? const BottomBarView() : const Welcome(),
            SignUp.routeName: (context) => const SignUp(),
            //Login.routeName: (context) => Login(),
            HomeView.routeName: (context) => const HomeView(),
          },
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute<void>(
              settings: settings,
              builder: (BuildContext context) =>
                  const Scaffold(body: Center(child: Text('Not Found'))),
            );
          });
    }
  }
}
