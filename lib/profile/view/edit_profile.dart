import 'package:flutter/material.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:sabanci_talks/util/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io' show Platform;
import '../../util/styles.dart';
import 'package:flutter/cupertino.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({
    Key? key,
    required this.docId,
    required this.genderPre,
    required this.fullNamePre,
    required this.biographyPre,
    required this.picturePre,
  }) : super(key: key);
  final String docId;
  final String genderPre;
  final String fullNamePre;
  final String biographyPre;
  final String picturePre;
  final _formKey = GlobalKey<FormState>();
  static const String routeName = '/editProfile';

  String fullName = '';
  String biography = '';
  String profilePicture = '';
  String gender = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: kWhiteTextStyle,
          ),
          actions: [_saveButton(context)],
        ),
        body: _body());
  }

  Padding _body() => Padding(
      padding: Dimen.regularParentPadding,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                _networkImage(picturePre),
                _sized(),
                _profileImageButton(),
              ],
            ),
            _divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                _editTitles(),
                _sized(),
                Flexible(child: _editInputs()),
              ],
            ),
          ],
        ),
      ));

  Divider _divider() => const Divider(height: 30);

  TextButton _saveButton(BuildContext context) => TextButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          Firestore f = Firestore();
          await f.UpdateUser(docId, fullName, gender, biography, picturePre);
          NavigationService.instance
              .navigateToPageClear(path: NavigationConstants.BOTTOM_BAR);
        } else {
          debugPrint("Error is from ${fullName}");
          //_showDialog('Form Error', 'Your form is invalid', context);
        }
      },
      child: Text("Save", style: kWhiteTextStyle));

  TextButton _profileImageButton() => TextButton(
        onPressed: () {
          //_imageModal();
        },
        child: const Text("Change Your Profile Photo"),
      );

  SizedBox _sized() {
    return const SizedBox(width: 25);
  }

  Column _editTitles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Username:"),
        _padding(),
        const Text("Gender:"),
        _padding(),
        const Text("Biography:"),
      ],
    );
  }

  Padding _padding() =>
      const Padding(padding: EdgeInsets.symmetric(vertical: 15));

  Column _editInputs() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          _editContainer(widget: _name()),
          _divider(),
          _editContainer(widget: _gender()),
          _divider(),
          _editContainer(widget: _bio()),
        ],
      );

  SizedBox _editContainer({required Widget widget}) {
    return SizedBox(
      height: 16,
      width: double.infinity,
      child: widget,
    );
  }

  TextFormField _name() => TextFormField(
        cursorColor: const Color(0xFF5271FF),
        //controller: viewModel.nameController,
        textInputAction: TextInputAction.next,
        onChanged: (value) {},
        autocorrect: false,
        maxLines: 1,
        style: const TextStyle(fontSize: 14),
        initialValue: fullNamePre,
        validator: (value) {
          if (value != null) {
            if (value.isEmpty) {
              return 'Cannot leave password empty';
            }
            if (value.length < 3) {
              debugPrint("Error is from length");
              return 'Password too short';
            }
          }
        },
        onSaved: (value) {
          debugPrint("Error is from onsaved");
          fullName = value ?? '';
        },
      );

  TextFormField _gender() => TextFormField(
        cursorColor: const Color(0xFF5271FF),
        //controller: viewModel.usernameController,
        textInputAction: TextInputAction.next,
        onChanged: (value) {},
        autocorrect: false,
        initialValue: genderPre,
        maxLines: 1,
        style: const TextStyle(fontSize: 14),
        validator: (value) {
          if (value != null) {
            if (value.isEmpty) {
              return 'Cannot leave gender empty';
            }
          }
        },
        onSaved: (value) {
          gender = value ?? '';
        },
      );

  TextFormField _bio() => TextFormField(
        cursorColor: const Color(0xFF5271FF),
        //controller: viewModel.bioController,
        textInputAction: TextInputAction.done,
        onChanged: (value) {},
        autocorrect: false,
        initialValue: biographyPre,
        maxLines: 1,
        style: const TextStyle(fontSize: 14),
        validator: (value) {
          if (value != null) {
            if (value.isEmpty) {
              return 'Cannot leave biography empty';
            }
          }
        },
        onSaved: (value) {
          biography = value ?? '';
        },
      );

  CachedNetworkImage _networkImage(profileImage) {
    return CachedNetworkImage(
      imageUrl: profileImage,
      imageBuilder: (context, imageProvider) => Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Future<void> _showDialog(
      String title, String message, BuildContext context) async {
    bool isAndroid = Platform.isAndroid;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (isAndroid) {
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
}
