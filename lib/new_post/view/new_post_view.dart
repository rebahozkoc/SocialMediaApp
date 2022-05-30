import 'package:flutter/material.dart';
import 'package:sabanci_talks/new_post/view/add_image_view.dart';
import 'package:sabanci_talks/new_post/view/added_image_view.dart';
import 'package:sabanci_talks/util/dimensions.dart';
import 'new_post_form_view.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NewPostView extends StatefulWidget {
  const NewPostView({Key? key}) : super(key: key);

  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  final ImagePicker _picker = ImagePicker();

  final List<XFile> imgList = [];

  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile == null){
        debugPrint("No photo selected");
      }else{
        imgList.add(pickedFile);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> imgViewList = [];
    for (var i = 0; i < imgList.length; i++) {
      imgViewList.add(InkWell(
          onTap: () => setState(() {
                imgList.removeAt(i);
              }),
          child: AddedImageView(imgList[i].path)));
    }

    imgViewList.add(
      InkWell(onTap: pickImage, child: const AddImageView()),
    );
    return Scaffold(
      appBar: _appBar(),
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

  AppBar _appBar() {
    return AppBar(
      title: const Text('New Post'),
      centerTitle: false,
      actions: [
        TextButton(
          onPressed: () {
            debugPrint("Next");
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
}
