import 'package:flutter/material.dart';
import 'package:sabanci_talks/bottom_bar/view/bottom_bar_view.dart';
import 'package:sabanci_talks/sign_in/view/sign_in_view.dart';
import 'package:sabanci_talks/sign_up/view/sign_up_view.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/welcome/view/welcome_view.dart';
import 'package:sabanci_talks/home/view/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:sabanci_talks/main_bloc/block_observer/block_observer.dart";
import "package:sabanci_talks/main_bloc/main_page.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
      () => runApp(MaterialApp(
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
          })),
      blocObserver: AppBlocObserver());
}
