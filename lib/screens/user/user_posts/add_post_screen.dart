import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/screens/user/user_posts/components/user_posts.dart';
import 'package:repairity/widgets/top_notch.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  String title = '';
  String contact = '';
  String details = '';
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
            .addPost(title, contact, details);
      } on Exception catch (e) {
        String err = e.toString();
        print(err);
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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopNotch(withBack: true),
            SizedBox(
              height: sHeight * 0.05,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                          borderSide: BorderSide(width: 1.0, color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0, color: Colors.red),
                        ),
                        hintText: 'Enter the title here',
                        labelText: 'Post Title',
                        labelStyle: TextStyle(fontSize: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                          borderSide: BorderSide(width: 1.0, color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0, color: Colors.red),
                        ),
                        hintText: 'Enter your contact info here',
                        labelText: 'Contact Info',
                        labelStyle: TextStyle(fontSize: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                          borderSide: BorderSide(width: 1.0, color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0, color: Colors.red),
                        ),
                        hintText: 'Enter post details here',
                        labelText: 'Post Details',
                        labelStyle: TextStyle(fontSize: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Row(
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
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
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
                          Container(
                            margin: EdgeInsets.only(right: sWidth * 0.03),
                            width: sWidth * 0.7,
                            height: sHeight * 0.17,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: sHeight * 0.03,
                  ),
                  isPublishing
                      ? const CircularProgressIndicator()
                      : GestureDetector(
                          onTap: addPost,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: Colors.black,
                            ),
                            height: sHeight * 0.08,
                            width: sWidth * 0.8,
                            child: const Center(
                              child: Text(
                                'Publish',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
