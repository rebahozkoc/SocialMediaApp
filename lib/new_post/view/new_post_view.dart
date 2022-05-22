import 'package:flutter/material.dart';
import 'package:sabanci_talks/new_post/view/add_image_view.dart';
import 'package:sabanci_talks/new_post/view/added_image_view.dart';
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
    final List<String> imgList = [
    "https://picsum.photos/600",
    "https://picsum.photos/501",
    "https://picsum.photos/601",
    "https://picsum.photos/502",
    "https://picsum.photos/603",
    "https://picsum.photos/404",
    "https://picsum.photos/605",
  ];
  
  

  @override
  Widget build(BuildContext context) {
    List<Widget> imgViewList = [];
    for(var i=0;i<imgList.length;i++){
        imgViewList.add(InkWell(
          onTap: () => setState((){
            imgList.removeAt(i);
          }),
          child: AddedImageView(imgList[i])));
    }

    
    imgViewList.add( InkWell(
                      onTap: () =>{},
                      child: 
                      
                      const AddImageView()),);
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
                  child: Row(children:imgViewList))
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
