import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:repairity/models/workshop.dart';
import 'package:repairity/screens/auth_screen/map_helpers/location_input.dart';
import 'package:repairity/screens/workshop/view_profile_screen/components/view_profile_handler.dart';
import 'package:repairity/screens/workshop/view_profile_screen/widgets/profile_image_handler.dart';
import 'package:repairity/widgets/button.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

import '../../../main.dart';
import '../navigation_bar_screen/navigation_bar_screen.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  double lat = -1;
  double lon = -1;
  final usernameKey = GlobalKey<FormFieldState>();
  final contactKey = GlobalKey<FormFieldState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  XFile? chosenImage;
  bool isLoading = false;

  void updateProfile(Workshop workshop) async {
    setState(() {
      isLoading = true;
    });
    if (usernameKey.currentState!.validate() &&
        contactKey.currentState!.validate()) {
      if (usernameController.text != workshop.username) {
        await Provider.of<ViewProfileHandler>(context, listen: false)
            .updateUsername(usernameController.text);
      }
      if (contactController.text != workshop.contact) {
        await Provider.of<ViewProfileHandler>(context, listen: false)
            .updateContact(contactController.text);
      }
    }

    if ((lat != -1 && lat != workshop.lat) &&
        (lon != -1 && lon != workshop.lon)) {
      await Provider.of<ViewProfileHandler>(context, listen: false)
          .updateLocation(lat, lon);
    }
    if (chosenImage != null) {
      await Provider.of<ViewProfileHandler>(context, listen: false)
          .updateImage(chosenImage!);
    }
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkshopNavBar(pageIndex: 2),
        ));
  }

  late Future<Workshop> future;
  @override
  void initState() {
    // TODO: implement initState
    future = Provider.of<ViewProfileHandler>(context, listen: false)
        .fetchAndSetWorkshop();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const MyApp(),
                ),
                (_) => false,
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: future,
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
                  usernameController.text = workshop!.username;
                  contactController.text = workshop.contact;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: sHeight * 0.03,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: TextFormField(
                            key: usernameKey,
                            controller: usernameController,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 4) {
                                return 'Please provide a valid username';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.account_box),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.0, color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.0, color: Colors.red),
                              ),
                              hintText: 'Enter your Username here',
                              labelText: 'Username',
                              labelStyle: TextStyle(fontSize: 20),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: TextFormField(
                            key: contactKey,
                            controller: contactController,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !value.startsWith('05') ||
                                  value.length != 10) {
                                return 'Please provide a valid phone number';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.phone),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.0, color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.0, color: Colors.red),
                              ),
                              hintText: 'Enter your number here',
                              labelText: 'Contact',
                              labelStyle: TextStyle(fontSize: 20),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                            onSelectImage: (XFile image) {
                              chosenImage = image;
                            },
                            allowMultiple: false),
                        SizedBox(
                          height: sHeight * 0.02,
                        ),
                        LocationInput(
                          onSelectPlace: (double lat, double lon) {
                            this.lat = lat;
                            this.lon = lon;
                          },
                          previewLat: workshop.lat,
                          previewLon: workshop.lon,
                        ),
                        SizedBox(
                          height: sHeight * 0.02,
                        ),
                        isLoading
                            ? const CircularProgressIndicator()
                            : Button(
                                label: 'Save',
                                function: () => updateProfile(workshop)),
                      ],
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
