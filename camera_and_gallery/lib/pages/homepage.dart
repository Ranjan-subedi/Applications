import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _imagePath = '';
  List<XFile> _images = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Camera"),
          centerTitle: true,
        ),
        body:Column(
          children: [
            Expanded(
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 9,
                mainAxisSpacing: 9
              ),
                itemCount: _images.length,

                itemBuilder: (context, index) {

                    return Padding(padding: EdgeInsets.all(2),
                    child:Image.file(File(_images[index].path),
                    fit: BoxFit.cover,),);
                  },),
            )

          ],
        ),
      bottomNavigationBar: BottomAppBar(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.copyright),
            SizedBox(width: 6,),
            Text('Ranjan Subedi'),
          ],
        ),
      ),
      floatingActionButton:_actionButtonCollection(),
    );
  }
  _actionButtonCollection(){
    return Padding(padding: EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(onPressed: ()async{
          final photoes = await ImagePicker().pickImage(
              source: ImageSource.camera);
          if(photoes == null) return null ;

          setState(() {

            _images.add(photoes);
          });


        },
          child:
        Icon(Icons.camera_alt_outlined),),

        SizedBox(height: 10,),

        FloatingActionButton(onPressed: ()async{
          final List<XFile> pickedfile  =await  ImagePicker().pickMultiImage();
          if(pickedfile == null) {
            return null;
          }
         setState(() {
           // pickedfile.addAll(_images);
           _images.addAll(pickedfile);
         });
          
        },
        child: Icon(Icons.image),)

      ],
    ),
    );

  }
}
