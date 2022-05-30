import 'package:flutter/material.dart';
import 'package:sabanci_talks/navigation/navigation_route.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:sabanci_talks/util/bloc_observer.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:sabanci_talks/main_bloc/main_page.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
      () => runApp(
            MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.red,
                primaryColor: AppColors.primary,
                secondaryHeaderColor: AppColors.secondary,
              ),
              home: const MyFirebaseApp(),
              onGenerateRoute: NavigationRoute.instance.generateRoute,
              navigatorKey: NavigationService.instance.navigatorKey,
            ),
          ),
      blocObserver: AppBlocObserver());
}
