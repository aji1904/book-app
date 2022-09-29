import 'package:flutter/material.dart';

class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({Key? key, required this.ImageUrl}) : super(key: key);
  // ignore: non_constant_identifier_names
  final String ImageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Image.network(ImageUrl),
          const BackButton(),
        ],
      )),
    );
  }
}
