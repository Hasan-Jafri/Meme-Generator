// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import "package:flutter/material.dart";
import 'package:meme_generator/images_class/image.dart';

class DraggableText extends StatefulWidget {
  final String data;
  final Image_Class image_1;
  const DraggableText({super.key, required this.data, required this.image_1});

  @override
  State<DraggableText> createState() => _DraggableTextState();
}

class _DraggableTextState extends State<DraggableText> {
  Offset position = const Offset(100, 100);
  double fontsize = 20.0;
  @override
  void initState() {
    super.initState();
    position = const Offset(100, 100);
  }

  @override
  Widget build(BuildContext context) {
    return 
        Positioned(
          left: position.dx,
          top: position.dy,
          child: GestureDetector(
            onScaleUpdate: (details) {
              setState(() {
                fontsize = details.scale;
              });
            },
            child: Draggable(
              key: UniqueKey(),
              feedback: _buildTextWidget(),
              onDraggableCanceled: (Velocity, Offset offset) {
                setState(() {
                  position = offset;
                });
              },
              childWhenDragging: Container(
                color: Colors.white,
              ),
              child: _buildTextWidget(),
            ),
          ),
        );
  }

  Widget _buildTextWidget() {
    return Text(
      widget.data,
      style: TextStyle(
        fontSize: fontsize,
        color: Colors.black,
        decoration: TextDecoration.none,
        
      ),
    );
  }
}
