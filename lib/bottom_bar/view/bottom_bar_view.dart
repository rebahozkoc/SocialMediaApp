import 'package:flutter/material.dart';
import 'package:sabanci_talks/explore/view/explore_view.dart';
import 'package:sabanci_talks/home/view/home_view.dart';
import 'package:sabanci_talks/notification/view/notification_view.dart';
import 'package:sabanci_talks/new_post/view/new_post_view.dart';
import 'package:sabanci_talks/profile/view/profile_view.dart';
//import 'package:nearbies/core/init/icon/font_awesome5.dart';
//import 'package:nearbies/view/discover/view/discover_view.dart';
//import 'package:nearbies/view/home/view/home_view.dart';
//import 'package:nearbies/view/notification/view/notification_view.dart';
//import 'package:nearbies/view/profile/view/profile_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sabanci_talks/util/colors.dart';
import 'package:sabanci_talks/walkthrough/view/walkthrough_view.dart';
import 'package:sabanci_talks/welcome/view/welcome_view.dart';

class BottomBarView extends StatelessWidget {
  const BottomBarView({Key? key}) : super(key: key);

  List<Widget> _buildScreens() {
    return [
      const HomeView(),
      ExploreView(),
      const NewPostView(),
      const NotificationView(),
      const ProfileView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            iconSize: 28,
            activeColorPrimary: AppColors.primary,
            inactiveColorPrimary: AppColors.grey),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.search),
            iconSize: 28,
            activeColorPrimary: AppColors.primary,
            inactiveColorPrimary: AppColors.grey),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.add_circle),
          iconSize: 42,
          activeColorPrimary: AppColors.secondary,
          inactiveColorPrimary: AppColors.secondary,
        ),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.notifications),
            iconSize: 28,
            activeColorPrimary: AppColors.primary,
            inactiveColorPrimary: AppColors.grey),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.person),
            iconSize: 28,
            activeColorPrimary: AppColors.primary,
            inactiveColorPrimary: AppColors.grey),
      ];
    }

    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      navBarStyle: NavBarStyle.style3,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
    );
  }
}
