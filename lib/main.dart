// ignore_for_file: prefer_conditional_assignment, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:meme_generator/constants/form_decoration.dart';
import 'package:meme_generator/images_class/image.dart';
import 'package:meme_generator/pages/second.dart';
import 'package:meme_generator/shared/form_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meme Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 1, 99)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Meme Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final imagelinkController = TextEditingController();
  final textnumbersController = TextEditingController();
  List<CustomTextFormField> forms = [];
  List<String> data = [];
  Image_Class image_1 = Image_Class(
      text_amount: 1,
      image_url:
          "https://cdn.vox-cdn.com/thumbor/eVoshjyykMmnHs0xsekYFllO6IM=/1400x0/filters:no_upscale()/cdn.vox-cdn.com/uploads/chorus_asset/file/23265504/Spider_Man_meme.jpg");

  void updateFormFields() {
    forms.clear();
    for (int i = 0; i < image_1.text_amount; i++) {
      TextEditingController controller = TextEditingController();
      forms.add(CustomTextFormField(
        controller: controller,
        hintText: "Content Here",
        labelText: "",
      ));
    }
  }

  void initstate() {
    super.initState();
    updateFormFields();
  }

  @override
  Widget build(BuildContext context) {
    forms.clear();
    for (int i = 0; i < image_1.text_amount; i++) {
      TextEditingController controller = TextEditingController();
      forms.add(CustomTextFormField(
          controller: controller, hintText: "Content Here", labelText: ""));
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 63, 1, 99),
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(
            label: const Text("Update Data"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Center(child: Text("Update Menu")),
                      content: SizedBox(
                        height: 190,
                        width: 300,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: imagelinkController,
                              decoration: textInputDecoration.copyWith(
                                  hintText: "URL Here",
                                  labelText: "Image Link"),
                              keyboardType: TextInputType.url,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: textnumbersController,
                              decoration: textInputDecoration.copyWith(
                                  hintText: "No. of Texts here",
                                  labelText: "Texts"),
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                        Color?>(
                                    const Color.fromARGB(255, 230, 202, 247)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color?>(
                                        Colors.black),
                              ),
                              onPressed: () {
                                String imageUrl = imagelinkController.text;
                                int textNum =
                                    int.parse(textnumbersController.text);
                                if (imageUrl.isEmpty) {
                                  imageUrl = image_1.image_url;
                                }

                                if (textNum.isNaN) {
                                  textNum = image_1.text_amount;
                                }
                                setState(() {
                                  image_1.update_data(textNum, imageUrl);
                                });
                                updateFormFields();
                              },
                              child: const Text("Update"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Close"),
                        )
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.update),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 230, 202, 247),
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: const Color.fromARGB(255, 63, 1, 99),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: forms,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            const Color.fromARGB(255, 230, 202, 247)),
                        foregroundColor:
                            MaterialStateProperty.all<Color?>(Colors.black),
                      ),
                      onPressed: () {
                        for (int i = 0; i < forms.length; i++) {
                          data.add(forms[i].controller.text);
                        }

                        // for (int i = 0; i < data.length; i++) {
                        //   DraggableText(data: data[i]);
                        // }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Second(
                                      texts: data,
                                      image_1: image_1,
                                    )));
                      },
                      child: const Text("Submit"),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            const Color.fromARGB(255, 230, 202, 247)),
                        foregroundColor:
                            MaterialStateProperty.all<Color?>(Colors.black),
                      ),
                      onPressed: () {
                        for (int i = 0; i < image_1.text_amount; i++) {
                          forms[i].controller.text = "";
                        }
                      },
                      child: const Text("Reset"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 250,
                  width: 500,
                  child: Image.network(
                    image_1.image_url,
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
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
