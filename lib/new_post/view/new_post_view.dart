import 'package:flutter/material.dart';
import 'package:sabanci_talks/new_post/view/add_image_view.dart';
import 'package:sabanci_talks/new_post/view/added_image_view.dart';
import 'package:sabanci_talks/util/dimensions.dart';
import 'package:sabanci_talks/util/screen_sizes.dart';
import 'new_post_form_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:sabanci_talks/util/styles.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({Key? key, required this.analytics, required this.observer})
      : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  final ImagePicker _picker = ImagePicker();
  Future<void> _setCurrentScreen() async {
    await widget.analytics.setCurrentScreen(
      screenName: 'New Post',
      screenClassOverride: 'newpost',
    );
  }

  Future<void> _setuserId() async {
    await widget.analytics.setUserId(
      id: "",
    );

    final List<XFile> imgList = [];

    Future pickImageCamera() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        if (pickedFile == null) {
          debugPrint("No photo selected");
        } else {
          imgList.add(pickedFile);
        }
      });
    }

    Future pickImageGallery() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile == null) {
          debugPrint("No photo selected");
        } else {
          imgList.add(pickedFile);
        }
      });
    }

    Future uploadImageToFirebase(BuildContext context, XFile image) async {
      String fileName = basename(image.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      try {
        await firebaseStorageRef.putFile(File(image.path));
        print("Upload complete");
      } on FirebaseException catch (e) {
        print('ERROR: ${e.code} - ${e.message}');
      } catch (e) {
        print(e.toString());
      }
    }

    AppBar _appBar(BuildContext context) {
      return AppBar(
        title: const Text('New Post'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
              debugPrint("Next");
              uploadImageToFirebase(context, imgList[0]);
            },
            child: const Text("Share",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                )),
          )
        ],
      );
    }

    @override
    Widget build(BuildContext context) {
      _setCurrentScreen();
      List<Widget> imgViewList = [];
      for (var i = 0; i < imgList.length; i++) {
        imgViewList.add(InkWell(
            onTap: () => setState(() {
                  imgList.removeAt(i);
                }),
            child: AddedImageView(imgList[i].path)));
      }

      imgViewList.add(InkWell(
        onTap: () {
          showGeneralDialog(
            barrierLabel: "Label",
            barrierDismissible: true,
            barrierColor: Colors.black.withOpacity(0.5),
            transitionDuration: const Duration(milliseconds: 400),
            context: context,
            pageBuilder: (context, anim1, anim2) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      SizedBox(
                          width: screenWidth(context),
                          child: TextButton(
                            onPressed: pickImageCamera,
                            child: Padding(
                              padding: Dimen.regularParentPadding,
                              child: Text(
                                "Take a photo",
                                style: kButtonDaTextStyle,
                              ),
                            ),
                          )),
                      SizedBox(
                          width: screenWidth(context),
                          child: TextButton(
                              onPressed: pickImageGallery,
                              child: Padding(
                                padding: Dimen.regularParentPadding,
                                child: Text(
                                  "Select image from galery",
                                  style: kButtonDaTextStyle,
                                ),
                              ))),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              );
            },
            transitionBuilder: (context, anim1, anim2, child) {
              return SlideTransition(
                position:
                    Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                        .animate(anim1),
                child: child,
              );
            },
          );
        },
        child: const AddImageView(false),
      ));
      return Scaffold(
        appBar: _appBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: Dimen.regularParentPadding,
            child: Column(
              children: [
                const MyCustomForm(),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: imgViewList)),
              ],
            ),
          ),
        ),
      );
    }
  }
}
