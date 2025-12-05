
import 'dart:io';
import 'package:camera_and_gallery/src/features/presentation/pages/photo_view.dart';
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

  int _gridAxisCount = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Camera"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.indigo[400],
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.copyright),
            const SizedBox(width: 6),
            const Text('Ranjan Subedi'),
            Expanded(child: SizedBox()),
            InkWell(
              onTap: () {
                if (_gridAxisCount < 6) {
                  setState(() {
                    _gridAxisCount++;
                  });
                }
              },
              onLongPress: () {
                if (_gridAxisCount > 3) {
                  setState(() {
                    _gridAxisCount--;
                  });
                }
              },
              child: Icon(Icons.photo_size_select_large),
            ),
          ],
        ),
      ),
      body:
          _images.isEmpty
              ? Center(
                child: Text(
                  ' Capture a photo or add photo',
                  style: TextStyle(fontSize: 20),
                ),
              )
              : Column(
                children: [
                  SizedBox(height: 9),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _gridAxisCount,
                          crossAxisSpacing: 9,
                          mainAxisSpacing: 9,
                        ),
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(2),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => PhotoViewPage(
                                          imagePath: _images[index].path,
                                        ),
                                  ),
                                );
                              },
                              onLongPress: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Delete !'),
                                        content: Text(
                                          'Do you want to delete this image ?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('No'),
                                          ),

                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              setState(() {
                                                _images.removeAt(index);
                                                _imagePaths.removeAt(index);
                                              });
                                            },
                                            child: Text('Yes'),
                                          ),
                                          // if (_images.isNotEmpty && index < _images.length) {
                                          // _images.removeAt(index);
                                          // _imagePaths.removeAt(index);
                                          // }
                                        ],
                                      );
                                    },
                                  );
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
                  ),
                ],
              ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(side: BorderSide(color: Colors.indigo, width: 2)),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return _actionButtonCollection(
              );
            },
          );
          setState(() {});
        },
        child: Icon(Icons.circle_outlined),
      ),
    );
  }

  _actionButtonCollection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final photo = await ImagePicker().pickImage(
                source: ImageSource.camera,imageQuality: 100,requestFullMetadata: true
              );
              if (photo == null) return;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                _images.add(photo);
                _imagePaths.add(photo.path);
              });
              await prefs.setStringList('Image_Key', _imagePaths);
              Navigator.pop(context);
            },
            child: const Icon(Icons.camera_alt_outlined),
          ),
          const SizedBox(width: 10),
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
              Navigator.pop(context);
            },
            child: const Icon(Icons.image),
          ),
        ],
      ),
    );
  }
}
