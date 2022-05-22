import 'package:flutter/material.dart';
import 'package:sabanci_talks/new_post/view/add_image_view.dart';
import 'package:sabanci_talks/util/dimensions.dart';
import 'new_post_form_view.dart';
import 'package:image_picker/image_picker.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({Key? key}) : super(key: key);

  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: Dimen.regularParentPadding,
          child: Column(
            children: [
              MyCustomForm(),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    InkWell(
                      onTap: () =>{},
                      child: AddImageView()),
                      
                    AddImageView(),
                    AddImageView(),
                    AddImageView(),
                    AddImageView()
                  ]))
            ],
          ),
        ),
      ),
    );
  }


  AppBar _appBar() {
    return AppBar(
      title: Text('New Post'),
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
