import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class AddImageView extends StatefulWidget {
  const AddImageView({ Key? key }) : super(key: key);

  @override
  State<AddImageView> createState() => _AddImageViewState();
}

class _AddImageViewState extends State<AddImageView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
        color: Colors.black,
        strokeWidth: 2,
        radius: const Radius.circular(20.0),
        dashPattern: const [10, 5],
       
        child: const SizedBox(
          height: 100,
          width: 100,
          child: Icon(
            Icons.add
          ),
        )),
    );
  }
}