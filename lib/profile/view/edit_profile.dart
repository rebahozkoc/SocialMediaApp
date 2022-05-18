import 'package:flutter/material.dart';
import 'package:sabanci_talks/util/dimensions.dart';
import 'package:sabanci_talks/widgets/person_header_widget.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../util/styles.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  static const String routeName = '/editProfile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile', style: kWhiteTextStyle,),
                actions: [_saveButton()],

        ),
        body: _body());
  }

  Padding _body() => Padding(
        padding: Dimen.regularParentPadding,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                _networkImage(),
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
      );

  Divider _divider() => const Divider(height: 30);

  TextButton _saveButton() => TextButton(
      onPressed: () => {},
      child: Text(
        "Save",
        
        style: kWhiteTextStyle
      ));

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
        const Text("Full Name:"),
        _padding(),
        const Text("Username:"),
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
          _editContainer(widget: _username()),
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
      );

  TextFormField _username() => TextFormField(
        cursorColor: const Color(0xFF5271FF),
        //controller: viewModel.usernameController,
        textInputAction: TextInputAction.next,
        onChanged: (value) {},
        autocorrect: false,
        maxLines: 1,
        style: const TextStyle(fontSize: 14),
      );

  TextFormField _bio() => TextFormField(
        cursorColor: const Color(0xFF5271FF),
        //controller: viewModel.bioController,
        textInputAction: TextInputAction.done,
        onChanged: (value) {},
        autocorrect: false,
        maxLines: 1,
        style: const TextStyle(fontSize: 14),
      );


    CachedNetworkImage _networkImage() {
    return CachedNetworkImage(
      imageUrl: "https://media-exp1.licdn.com/dms/image/C4D03AQEHt0PHBly75g/profile-displayphoto-shrink_800_800/0/1577740655027?e=1658361600&v=beta&t=KaSKjXDM6aldHaLR1-otcpGBTV64J6oZstv3yTD6mRM",
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

}
