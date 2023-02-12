import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileImageHandler extends StatefulWidget {
  const ProfileImageHandler({
    Key? key,
    required this.onSelectImage,
    required this.allowMultiple,
  }) : super(key: key);
  final Function onSelectImage;
  final bool allowMultiple;
  @override
  State<ProfileImageHandler> createState() => _ImageHandlerState();
}

class _ImageHandlerState extends State<ProfileImageHandler> {
  List<File> storedImages = [];

  Future<void> takePictures() async {
    final imagePicker = ImagePicker();
    final chosenImages = await imagePicker.pickMultiImage();
    for (var element in chosenImages) {
      setState(() {
        storedImages.insert(0, File(element.path));
      });
    }
    widget.onSelectImage(chosenImages);
  }

  Future<void> takeSinglePicture(ImageSource src) async {
    final imagePicker = ImagePicker();
    final chosenImage = await imagePicker.pickImage(source: src);
    if (chosenImage != null) {
      setState(() {
        storedImages.insert(0, File(chosenImage.path));
      });
      widget.onSelectImage(chosenImage);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final result = await Supabase.instance.client.storage
            .from('profile-pictures')
            .download(Supabase.instance.client.auth.currentUser!.id);
        final tempDir = await getTemporaryDirectory();
        File file = await File(
                '${tempDir.path}/${Supabase.instance.client.auth.currentUser!.id}.png')
            .create();
        file.writeAsBytesSync(result);
        setState(() {
          storedImages.insert(0, file);
        });
      });
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;

    return Row(
      children: [
        SizedBox(
          width: sWidth * 0.01,
        ),
        Column(
          children: [
            const Text(
              ' Add image:',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: sHeight * 0.03,
            ),
            IconButton(
              onPressed: () {
                takeSinglePicture(ImageSource.camera);
              },
              icon: Icon(
                Icons.camera_alt,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              onPressed: () {
                if (widget.allowMultiple) {
                  takePictures();
                } else {
                  takeSinglePicture(ImageSource.gallery);
                }
              },
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
                  height:
                      storedImages.length == 1 ? sHeight * 0.2 : sHeight * 0.17,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: storedImages.isEmpty
                      ? const Center(
                          child: Text('No images to preview'),
                        )
                      : Image.file(
                          storedImages[0],
                          fit: BoxFit.fill,
                        )),
            ),
          ],
        )
      ],
    );
  }
}
