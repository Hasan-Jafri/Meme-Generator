// ignore_for_file: non_constant_identifier_names, must_be_immutable, prefer_final_fields
import 'dart:ui' as ui;
import "package:flutter/material.dart";
import 'package:meme_generator/images_class/image.dart';
import 'package:meme_generator/pages/drag.dart';
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class Second extends StatefulWidget {
  late List<String> texts = [];
  final Image_Class image_1;
  Second({super.key, required this.texts, required this.image_1});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  GlobalKey _imageKey = GlobalKey();
  List<String> Texts = [];
  List<GlobalKey> _textKeys = [];


  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.texts.length; i++) {
      _textKeys.add(GlobalKey());
    }
  }

  Future<void> saveImage() async {
    // Capture the current UI state as an image
    RenderRepaintBoundary boundary =
        _imageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      Uint8List uint8List = byteData.buffer.asUint8List();

      final result = await ImageGallerySaver.saveImage(uint8List);
      print('Image saved: $result');
    } else {
      print('Failed to convert image to ByteData');
    }
    // Save the image to the device's gallery
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 230, 202, 247),
          title: const Text("Edit Area"),
          
          actions: [
            ElevatedButton(
                onPressed: () {
                  widget.texts.clear();
                  Navigator.pop(context);
                },
                child: const Text("Back")),
          ],
        ),
        body: Stack(
          children: [

            Positioned(
              left: 10,
              right: 10,
              bottom: 50,
              top: 150,
              child: RepaintBoundary(
                key: _imageKey,
                child: SizedBox(
                  height: 250,
                  width: 500,
                  child: Image.network(
                    widget.image_1.image_url,
                    fit: BoxFit.contain,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Center(
                        child: Text(
                          "Image could not be loaded",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        const Color.fromARGB(255, 230, 202, 247)),
                    foregroundColor:
                        MaterialStateProperty.all<Color?>(Colors.black),
                  ),
                  onPressed: () {
                    saveImage();
                  },
                  child: const Text("Download"),
                ),
              ),
            ),
            for (String text in widget.texts)
              DraggableText(data: text, image_1: widget.image_1),
            
          ],
        ),
      ),
    );
  }
}
