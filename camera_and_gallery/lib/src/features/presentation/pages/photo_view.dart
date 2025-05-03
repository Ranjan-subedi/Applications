import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatelessWidget {
  final String imagePath;

   const PhotoViewPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[600],
        title: const Text('Photo',style: TextStyle(fontSize: 24,
      fontWeight: FontWeight.bold,
        color: Colors.white,
      ),),
      centerTitle: true,),
      body: Center(
        child: PhotoView(
          imageProvider: FileImage(File(imagePath),
          ),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.contained*6,
        ),
      ),
    );
  }
}
