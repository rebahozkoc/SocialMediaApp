import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sabanci_talks/bottom_bar/view/bottom_bar_view.dart';
import 'package:sabanci_talks/sign_in/view/sign_in_view.dart';
import 'package:sabanci_talks/sign_up/view/sign_up_view.dart';
import 'package:sabanci_talks/util/authentication/auth.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/walkthrough/view/walkthrough_view.dart';
import 'package:sabanci_talks/welcome/view/welcome_view.dart';
import 'package:sabanci_talks/home/view/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: AppColors.primary,
        secondaryHeaderColor: AppColors.secondary,
      ),
      home: const MyFirebaseApp(),
      routes: {
        
        Welcome.routeName: (context) => const Welcome(),
        SignUp.routeName: (context) => const SignUp(),
        SignIn.routeName: (context) => const SignIn(),
        HomeView.routeName: (context) => const HomeView(),
        BottomBarView.routeName: (context) => const BottomBarView(),
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) =>
              const Scaffold(body: Center(child: Text('Not Found'))),
        );
      }));
}

class MyFirebaseApp extends StatefulWidget {
  const MyFirebaseApp({Key? key}) : super(key: key);

  @override
  State<MyFirebaseApp> createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {
  final Future<FirebaseApp> _init = Firebase.initializeApp();
  final is_logined = false;
  late int firstLoad;
  late SharedPreferences prefs;

  decideRoute() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      firstLoad = (prefs.getInt('appInitialLoad') ?? 0);
    });
  }

  @override
  void initState() {
    super.initState();
    decideRoute();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorScreen(message: snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (firstLoad == 0) {
              firstLoad = 1;
              prefs.setInt('appInitialLoad', firstLoad);
              return const IntroScreen();
            } else if (is_logined) {
              return const BottomBarView();
            } else {
              return const Welcome();
            }
          }
          return const Waiting();
        });
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key, required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sabanci Talks Error Screen'),
          centerTitle: true,
        ),
        body: Text(message));
  }
}

class Waiting extends StatelessWidget {
  const Waiting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Waiting Screen for Sabanci Talks"),
          centerTitle: true,
        ),
        body: const Center(child: Text("Welcome to Sabanci Talks")));
  }
}
