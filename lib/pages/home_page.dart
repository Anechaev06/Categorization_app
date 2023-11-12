import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? _image; // Changed from PickedFile to XFile
  bool _loading = false;
  List<dynamic>? _outputs;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> classifyImage(XFile image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  Future<void> pickImage(ImageSource source) async {
    var image = await _picker.pickImage(source: source);
    if (image == null) return;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Classification'),
        backgroundColor: Colors.purple,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _image == null ? Container() : Image.file(File(_image!.path)),
                  const SizedBox(height: 20),
                  _outputs != null
                      ? Text(
                          '${_outputs![0]["label"]}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            // background: Colors.white,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _optionDialogBox(context),
        backgroundColor: Colors.purple,
        child: const Icon(Icons.image),
      ),
    );
  }

  Future<void> _optionDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.purple,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text(
                    "Take a Picture",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    pickImage(ImageSource.camera);
                  },
                ),
                const Padding(padding: EdgeInsets.all(10.0)),
                GestureDetector(
                  child: const Text(
                    "Select Image from Gallery",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
