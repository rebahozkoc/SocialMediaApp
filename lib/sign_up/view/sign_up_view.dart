import 'package:flutter/material.dart';
import "package:sabanci_talks/util/styles.dart";
import "package:sabanci_talks/util/colors.dart";
import "package:sabanci_talks/util/dimensions.dart";
import "package:sabanci_talks/util/screen_sizes.dart";
import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();

  static const String routeName = '/signup';
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String pass = '';
  late String s;

   Future<void> _showDialog(String title, String message) async {
    
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
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
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LOGIN',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: Dimen.regularPadding,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                width: screenWidth(context, dividedBy: 1.1),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Container(
                      width: 100,
                      child: Row(
                        children: [
                          const Icon(Icons.email),
                          const SizedBox(width: 4),
                          const Text('Email'),
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
                      borderRadius: BorderRadius.circular(30),
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
                padding: EdgeInsets.all(8),
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
                      borderRadius: BorderRadius.circular(30),
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

            ],
          ),
        ),
      ),
    );
  }
}
