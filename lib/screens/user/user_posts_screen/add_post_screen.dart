import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:repairity/screens/user/user_posts_screen/components/user_posts.dart';
import 'package:repairity/widgets/button.dart';
import 'package:repairity/widgets/top_notch.dart';

import 'widgets/image_handler.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  String title = '';
  String contact = '';
  String details = '';
  List<XFile> pickedImages = [];
  bool isPublishing = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> addPost() async {
    setState(() {
      isPublishing = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await Provider.of<UserPosts>(context, listen: false)
            .addPost(title, contact, details, pickedImages.length);
        if (pickedImages.isNotEmpty) {
          await Provider.of<UserPosts>(context, listen: false)
              .uploadPhotos(pickedImages);
        }
      } on Exception catch (e) {
        print(e);
        String err = e.toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(err),
          ),
        );
      }
    }
    setState(() {
      isPublishing = false;
    });
    Navigator.popAndPushNamed(context, '/user_home');
  }

  void _selectImage(dynamic chosenImages) async {
    try {
      if (chosenImages is List<XFile>) {
        for (var element in chosenImages) {
          pickedImages.add(element);
        }
      } else {
        pickedImages.add(chosenImages);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sHeight = size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopNotch(
              withBack: true,
              withAdd: false,
            ),
            SizedBox(
              height: sHeight * 0.05,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: sHeight * 0.015),
                    padding: EdgeInsets.symmetric(
                        horizontal: sHeight * 0.025, vertical: sHeight * 0.005),
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a title for your post';
                        }
                        return null;
                      },
                      onSaved: (newValue) => title = newValue!,
                      decoration: const InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.6, color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.6, color: Colors.red),
                        ),
                        hintText: 'Enter the title here',
                        labelText: 'Post Title',
                        labelStyle: TextStyle(fontSize: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.6, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: sHeight * 0.015),
                    padding: EdgeInsets.symmetric(
                        horizontal: sHeight * 0.025, vertical: sHeight * 0.005),
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a contact info';
                        }
                        return null;
                      },
                      onSaved: (newValue) => contact = newValue!,
                      decoration: const InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.6, color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.6, color: Colors.red),
                        ),
                        hintText: 'Enter your contact info here',
                        labelText: 'Contact Info',
                        labelStyle: TextStyle(fontSize: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.6, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: sHeight * 0.015),
                    padding: EdgeInsets.symmetric(
                        horizontal: sHeight * 0.025, vertical: sHeight * 0.005),
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a description for your post';
                        }
                        return null;
                      },
                      onSaved: (newValue) => details = newValue!,
                      decoration: const InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.6, color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.6, color: Colors.red),
                        ),
                        hintText: 'Enter post details here',
                        labelText: 'Post Details',
                        labelStyle: TextStyle(fontSize: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.6, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  ImageHandler(
                    onSelectImage: _selectImage,
                    allowMultiple: true,
                  ),
                  SizedBox(
                    height: sHeight * 0.03,
                  ),
                  isPublishing
                      ? const CircularProgressIndicator()
                      : Button(label: 'Publish', function: addPost)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
