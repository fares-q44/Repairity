import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/screens/workshop/view_profile_screen/components/view_profile_handler.dart';
import 'package:repairity/screens/workshop/view_profile_screen/widgets/profile_image_handler.dart';
import 'package:repairity/widgets/top_notch.dart';

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Column(
      children: [
        TopNotch(withBack: false, withAdd: false),
        FutureBuilder(
          future: Provider.of<ViewProfileHandler>(context, listen: false)
              .fetchAndSetWorkshop(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  SizedBox(
                    height: sHeight * 0.4,
                  ),
                  const CircularProgressIndicator(),
                ],
              );
            } else {
              final workshop = snapshot.data;
              return Column(
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: sHeight * 0.05,
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
                      initialValue: workshop!.username,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Please provide a valid username';
                        }
                        return null;
                      },
                      // onSaved: (newValue) => username = newValue!,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.account_box),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0, color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0, color: Colors.red),
                        ),
                        hintText: 'Enter your Username here',
                        labelText: 'Username',
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
                  ProfileImageHandler(
                      onSelectImage: () {}, allowMultiple: false)
                ],
              );
            }
          },
        )
      ],
    );
  }
}
