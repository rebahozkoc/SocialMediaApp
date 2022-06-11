import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sabanci_talks/firestore_classes/firestore_main/firestore.dart';
import 'package:sabanci_talks/navigation/navigation_constants.dart';
import 'package:sabanci_talks/navigation/navigation_service.dart';
import 'package:sabanci_talks/new_post/view/add_image_view.dart';
import 'package:sabanci_talks/post/model/post_model.dart';
import 'package:sabanci_talks/post/view/post_view.dart';
import 'package:sabanci_talks/firestore_classes/post/my_posts.dart';
import 'package:sabanci_talks/util/dimensions.dart';
import 'package:sabanci_talks/util/screen_sizes.dart';
import 'package:sabanci_talks/util/styles.dart';
import 'dart:io';
import 'package:path/path.dart';

class EditPost extends StatefulWidget {
  const EditPost(
      {Key? key,
      required this.docId,
      required this.proUrl,
      required this.name,
      required this.date})
      : super(key: key);
  final String docId;
  final String proUrl;
  final String name;
  final String date;

  @override
  State<EditPost> createState() => _EditPostState();

  static const String routeName = '/singlePost';
}

class _EditPostState extends State<EditPost> {
  MyPost? post;
  List<Content> contents = [];
  final _formKey = GlobalKey<FormState>();
  final List<XFile> imgList = [];
  final ImagePicker _picker = ImagePicker();
  String description = "";
  bool isButtonActive = true;

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

  Future updatePostOnFirebase(BuildContext context, List<XFile> images) async {
    // Check the form for errors
    debugPrint("BUTTOON CLICKEEEEEDD");
    setState(() {
      isButtonActive = false;
    });

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      //String fileName = basename(image.path);
      _formKey.currentState!.save();
      Firestore f = Firestore();
      String? uid = await f.decideUser();
      // for every image in the list, upload it to firebase
      List<String> fileNames = [];
      try {
        for (var image in images) {
          String fileName = basename(image.path);
          Reference firebaseStorageRef =
              FirebaseStorage.instance.ref().child('uploads/$fileName');

          await firebaseStorageRef.putFile(File(image.path));

          await firebaseStorageRef.getDownloadURL().then((fileURL) {
            debugPrint("File uploaded");
            debugPrint(fileURL);
            fileNames.add(fileURL);
          });
        }
        debugPrint(description);
        debugPrint(fileNames.toString());
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd-kk:mm').format(now);

        await f.addPost(
            uid: uid,
            createdAt: formattedDate,
            urlArr: fileNames,
            postText: description);
        NavigationService.instance
            .navigateToPageClear(path: NavigationConstants.BOTTOM_BAR);
        debugPrint("Upload complete");
      } on FirebaseException catch (e) {
        debugPrint('ERROR: ${e.code} - ${e.message}');
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        setState(() {
          isButtonActive = true;
        });
      }
    }
  }

  Future<void> getMyPost() async {
    Firestore f = Firestore();
    post = await f.getSpecificPost(widget.docId);
    contents = [];
    for (String url in post!.pictureUrlArr) {
      contents.add(Content(
        type: "image",
        contentId: url,
        source: url,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMyPost(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: _appBar(),
            body: _body(context),
          );
        });
  }

  AppBar _appBar() => AppBar(
        title: const Text("Edit Post"),
        centerTitle: false,
      );

  SizedBox _body(BuildContext context) {
    debugPrint("contents $contents");
    return SizedBox(
      width: double.infinity,
      child: ListView(
        primary: true,
        shrinkWrap: true,
        children: [
          PostView(
            postModel: PostModel(
              name: widget.name,
              date: widget.date,
              profileImg: widget.proUrl,
              likeCount: post != null ? post!.likeArr.length : 0,
              commentCount: 58,
              contentCount: contents.length,
              postText: post != null ? post!.postText : "",
              contents: contents,
              postId: widget.docId,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(children: [_addImageButton(context)]),
            ],
          )
        ],
      ),
    );
  }

  Widget _addImageButton(BuildContext context) {
    return InkWell(
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
      child: const AddImageView(true),
    );
  }
}
