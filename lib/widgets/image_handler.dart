import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageHandler extends StatefulWidget {
  const ImageHandler({
    Key? key,
    required this.onSelectImage,
  }) : super(key: key);
  final Function onSelectImage;
  @override
  State<ImageHandler> createState() => _ImageHandlerState();
}

class _ImageHandlerState extends State<ImageHandler> {
  List<File> storedImages = [];

  Future<void> takePictures() async {
    final imagePicker = ImagePicker();
    final chosenImages = await imagePicker.pickMultiImage();
    for (var element in chosenImages) {
      setState(() {
        storedImages.add(File(element.path));
      });
    }
    widget.onSelectImage(chosenImages);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;

    return Row(
      children: [
        SizedBox(
          width: sWidth * 0.03,
        ),
        Column(
          children: [
            const Text(
              'Add image:',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: sHeight * 0.03,
            ),
            IconButton(
              onPressed: () => takePictures(),
              icon: Icon(
                Icons.camera_alt,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              onPressed: () => takePictures(),
              icon: Icon(
                Icons.image,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: sHeight * 0.05,
            )
          ],
        ),
        SizedBox(
          width: sWidth * 0.02,
        ),
        Column(
          children: [
            SizedBox(
              height: sHeight * 0.04,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: sWidth * 0.7,
                height: sHeight * 0.17,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: storedImages.isEmpty
                    ? const Center(
                  child: Text('No images to preview'),
                )
                    : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    margin:
                    EdgeInsets.symmetric(horizontal: sWidth * 0.01),
                    child: Image.file(
                      storedImages[index],
                    ),
                  ),
                  itemCount: storedImages.length,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
