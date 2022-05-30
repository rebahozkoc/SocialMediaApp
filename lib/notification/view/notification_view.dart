import 'package:flutter/material.dart';
import 'package:sabanci_talks/notification/view/notification_widget_view.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class NotificationView extends StatefulWidget {
  const NotificationView(
      {Key? key, required this.analytics, required this.observer})
      : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  Future<void> _setCurrentScreen() async {
    await widget.analytics.setCurrentScreen(
      screenName: 'Notification Page',
      screenClassOverride: 'notificationPage',
    );
  }

  SizedBox _body() => SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemBuilder: (context, index) => const NotificationWidget(),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 12,
                  ),
              itemCount: 5),
        ),
      );
  @override
  Widget build(BuildContext context) {
    _setCurrentScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: false,
      ),
      body: SafeArea(child: _body()),
    );
  }
}
