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
  List<XFile> _images = [];
  List<String> _imagePaths = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? imagePaths = prefs.getStringList('Image_Key');
    if (imagePaths != null) {
      setState(() {
        _imagePaths = imagePaths;
        _images = _imagePaths.map((path) => XFile(path)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 9,
                mainAxisSpacing: 9,
              ),
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: InkWell(
                    onLongPress: () {
                      setState(() {
                        if (_images.isNotEmpty && index < _images.length) {
                          _images.removeAt(index);
                          _imagePaths.removeAt(index);
                        }
                      });
                    },
                    child: Image.file(
                      File(_images[index].path),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.copyright),
            const SizedBox(
              width: 6,
            ),
            const Text('Ranjan Subedi'),
          ],
        ),
      ),
      floatingActionButton: _actionButtonCollection(),
    );
  }

  _actionButtonCollection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final photo =
              await ImagePicker().pickImage(source: ImageSource.camera);
              if (photo == null) return;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                _images.add(photo);
                _imagePaths.add(photo.path);
              });
              await prefs.setStringList('Image_Key', _imagePaths);
            },
            child: const Icon(Icons.camera_alt_outlined),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async {
              final List<XFile> pickedFiles =
              await ImagePicker().pickMultiImage();
              if (pickedFiles.isEmpty) return;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              List<String> paths = pickedFiles.map((e) => e.path).toList();
              await prefs.setStringList('Image_Key', paths);
              setState(() {
                _images.addAll(pickedFiles);
                _imagePaths.addAll(paths);
              });
            },
            child: const Icon(Icons.image),
          ),
        ],
      ),
    );
  }
}

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   List<XFile> _images = [];
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loadImage();
//   }
//
//
//   loadImage()async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.getStringList('Image_Key');
//     setState(() {
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Camera"),
//           centerTitle: true,
//         ),
//         body:Column(
//           children: [
//             Expanded(
//               child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 9,
//                 mainAxisSpacing: 9
//               ),
//                 itemCount: _images.length,
//
//                 itemBuilder: (context, index) {
//
//                     return Padding(padding: EdgeInsets.all(2),
//                     child:InkWell(
//                       onLongPress: () {
//                         setState(() {
//                           _images.removeAt(index);
//                         });
//                       },
//                       child: Image.file(File(_images[index].path),
//                       fit: BoxFit.cover,),
//                     ),);
//                   },),
//             )
//
//           ],
//         ),
//       bottomNavigationBar: BottomAppBar(
//         height: 40,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.copyright),
//             SizedBox(width: 6,),
//             Text('Ranjan Subedi'),
//           ],
//         ),
//       ),
//       floatingActionButton:_actionButtonCollection(),
//     );
//   }
//   _actionButtonCollection(){
//     return Padding(padding: EdgeInsets.all(16),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         FloatingActionButton(onPressed: ()async{
//           final photoes = await ImagePicker().pickImage(
//               source: ImageSource.camera);
//           if(photoes == null) return null ;
//
//           setState(() {
//
//             _images.add(photoes);
//           });
//
//
//         },
//           child:
//         Icon(Icons.camera_alt_outlined),),
//
//         SizedBox(height: 10,),
//
//         FloatingActionButton(onPressed: ()async{
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           prefs.setString('Image_Key', ImagePicker().pickMultiImage().toString());
//
//           setState(() {
//
//           });
//
//          //  final List<XFile> pickedfile  =await  ImagePicker().pickMultiImage();
//          //  if(pickedfile == null) {
//          //    return null;
//          //  }
//          // setState(() {
//          //   // pickedfile.addAll(_images);
//          //
//          //
//          //   _images.addAll(pickedfile);
//          // });
//
//         },
//         child: Icon(Icons.image),)
//
//       ],
//     ),
//     );
//
//   }
// }
