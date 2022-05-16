import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io' show Platform;
import "package:sabanci_talks/util/styles.dart";
import "package:sabanci_talks/util/colors.dart";
import "package:sabanci_talks/util/dimensions.dart";
import "package:sabanci_talks/util/screen_sizes.dart";
import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();

  static const String routeName = '/signup';
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String pass = '';
  late String s;
  int loginCounter = 0;

   Future<void> _showDialog(String title, String message) async {
    bool isAndroid = Platform.isAndroid;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        if(isAndroid) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        } else {
          return CupertinoAlertDialog(
            title: Text(title, style: kBoldLabelStyle),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message, style: kLabelStyle),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }

      });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          'Sign In',
          style: LittleTitle,),
        backgroundColor:Colors.white10,
        elevation:0,
        centerTitle:true,
      ),
      body: Padding(
        padding: Dimen.regularPadding,
        child: Column(
        children:[ 
        const Spacer(flex:1),
        Padding(padding: Dimen.regularParentPadding, child: Text(
          'Type in your Email and Password that you chose for Void and click go to Feed',
          style: smallTextStyle,),),
        const Spacer(flex:1),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: screenWidth(context, dividedBy: 1.1),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Container(
                      width: 100,
                      child: Row(
                        children: [
                          Icon(Icons.email),
                          SizedBox(width: 4),
                          Text('Email'),
                        ],
                      ),
                    ),
                    fillColor: AppColors.textFieldFillColor,
                    filled: false,
                    labelStyle: kBoldLabelStyle,
                    border: OutlineInputBorder(
                      
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.primary,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      
                    ),
                  ),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Cannot leave e-mail empty';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid e-mail address';
                      }
                    }
                  },
                  onSaved: (value) {
                    email = value ?? '';
                  },
                ),
              ),
              
              Container(
                padding: const EdgeInsets.all(16),
                width: screenWidth(context, dividedBy: 1.1),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    label: Container(
                      width: 150,
                      child: Row(
                        children: [
                          const Icon(Icons.password),
                          const SizedBox(width: 4),
                          const Text('Password'),
                        ],
                      ),
                    ),
                    fillColor: AppColors.textFieldFillColor,
                    filled: true,
                    labelStyle: kBoldLabelStyle,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Cannot leave password empty';
                      }
                      if (value.length < 6) {
                        return 'Password too short';
                      }
                    }
                  },
                  onSaved: (value) {
                    pass = value ?? '';
                  },
                ),
              ),
              
              OutlinedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    print('Email: $email');
                    _formKey.currentState!.save();
                    print('Email: $email');
                    setState(() {
                      loginCounter++;
                    });

                  } else {
                    _showDialog('Form Error', 'Your form is invalid');
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Login Attempt: $loginCounter',
                    style: kButtonDarkTextStyle,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        const Spacer(flex:2),
        ]
        )
      ),
    );
  }
}
