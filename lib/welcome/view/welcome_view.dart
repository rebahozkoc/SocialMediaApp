import 'package:flutter/material.dart';
//import 'package:week_5/routes/login.dart';
//import 'package:week_5/routes/signup.dart';
//import 'package:week_5/util/colors.dart';
//import 'package:week_5/util/dimensions.dart';
//import 'package:week_5/util/styles.dart';
import 'package:sabanci_talks/sign_up/view/sign_up_view.dart';
import 'package:sabanci_talks/home/view/home_view.dart';
import 'package:sabanci_talks/util/styles.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Center(
              child: Padding(
                //padding: Dimen.regularPadding,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                child: Text(
                  'Void',
                  style: voidStyle,
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: Padding(
                //padding: Dimen.regularPadding,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                child: Text(
                  'Welcome',
                  style: welcomeStyle,
                ),
              ),
            ),
            const SizedBox(),
            Center(
              child: Padding(
                //padding: Dimen.regularPadding,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                child: Text(
                  'Welcome to Void, find and contact with your friends. Enjoy Life!',
                  style: smallTextStyle,
                ),
              ),
            ),
           
            const Spacer(),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Signup',
                          //style: kButtonLightTextStyle,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        //backgroundColor: AppColors.secondary,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8.0,),

                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
