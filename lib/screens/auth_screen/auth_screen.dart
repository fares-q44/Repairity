import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/screens/auth_screen/map_helpers/location_input.dart';
import 'package:repairity/screens/user/user_posts_screen/widgets/image_handler.dart';
import 'package:repairity/widgets/top_notch.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

import 'components/auth.dart';

import 'widgets/error_list.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.isWorkshop});
  final bool isWorkshop;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String username = '';
  String password = '';
  bool isLoadingAuth = false;
  bool agreedToTerms = false;

  Future<void> validateForm() async {
    setState(() {
      isLoadingAuth = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await Provider.of<Auth>(context, listen: false).authenticate(
          email,
          password,
          isLogin,
          widget.isWorkshop,
          username,
        );
        if (widget.isWorkshop) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/workshop',
                (route) => false,
          );
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/user_home',
                (route) => false,
          );
        }
      } on AuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${e.statusCode} - ${e.message}'),
          ),
        );
      } on Exception catch (e) {
        String err = e.toString();
        if (e.toString() == 'user-not-found' ||
            e.toString() == 'wrong-password') {
          err = 'Incorrect username or password, Please try again.';
        } else if (e.toString() == 'email-already-in-use') {
          err = 'Email is already taken';
        } else {
          err =
          'Invalid login credentials, please check your email and password';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(err),
          ),
  String phoneNumber = '';
  double lat = 0;
  double lon = 0;
  List<XFile> chosenImage = [];
  bool isLoadingAuth = false;
  bool agreedToTerms = false;
  List<String> errorTextList = [];

  Future<void> validateForm() async {
    if (isLogin) {
      agreedToTerms = true;
    }
    if (widget.isWorkshop && !isLogin) {
      if (!agreedToTerms) {
        if (errorTextList
            .contains('You must agree to our terms and conditions')) {
          return;
        } else {
          setState(() {
            errorTextList.add('You must agree to our terms and conditions');
          });
          return;
        }
      }
      errorTextList.remove('You must agree to our terms and conditions');
      if (chosenImage.isEmpty) {
        if (errorTextList.contains('You must select an image')) {
          return;
        } else {
          setState(() {
            errorTextList.add('You must select an image');
          });
          return;
        }
      }
      errorTextList.remove('You must select an image');
      if (lat == 0 && lon == 0) {
        if (errorTextList.contains('You must select A location')) {
          return;
        } else {
          setState(() {
            errorTextList.add('You must select A location');
          });
          return;
        }
      }
      errorTextList.remove('You must select A location');
    }

    if (_formKey.currentState!.validate()) {
      await attemptAuthinticate();
    }
  }

  Future<void> attemptAuthinticate() async {
    setState(() {
      isLoadingAuth = true;
    });
    _formKey.currentState!.save();
    try {
      await Provider.of<Auth>(context, listen: false).authinticate(
        email,
        password,
        isLogin,
        widget.isWorkshop,
        lat,
        lon,
        username,
      );
      if (widget.isWorkshop) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/workshop_home',
          (route) => false,
        );
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/user_home',
          (route) => false,
        );
      }
      if (widget.isWorkshop) {
        Future.wait(
          [Auth.uploadPhoto(chosenImage[0])],
        );
      }
    } on Exception catch (e) {
      String err = e.toString();
      if (e.toString() == 'user-not-found' ||
          e.toString() == 'wrong-password') {
        err = 'Incorrect username or password, Please try again.';
      } else if (e.toString() == 'email-already-in-use') {
        err = 'Email is already taken';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err),
        ),
      );
      setState(
        () {
          isLoadingAuth = false;
        },
      );
    }
    setState(() {
      isLoadingAuth = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Used for size setting
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
           // const TopNotch(withBack: true),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: sHeight * 0.1,
                  ),
                  Text(
                    isLogin ? 'Login' : 'Register',
                    style: const TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: sHeight * 0.04,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // The Username text field
                        !isLogin
                            ? Container(
                          margin:
                          const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty || value.length < 4) {
                                return 'Please provide a valid username';
                              }
                              return null;
                            },
                            onSaved: (newValue) => username = newValue!,
                            decoration: const InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.red),
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
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.black),
                              ),
                            ),
                          ),
                        )
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                width: size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(29),
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return 'Please provide a valid username';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) => username = newValue!,
                                  decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.account_box),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.0, color: Colors.red),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.0, color: Colors.red),
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
                                      borderSide: BorderSide(
                                          width: 1.0, color: Colors.black),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        // The email text field
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please provide a valid email';
                              }
                              return null;
                            },
                            onSaved: (newValue) => email = newValue!,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.email),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 1.0, color: Colors.red),
                              ),
                              hintText: 'Enter your email here',
                              labelText: 'Email',
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
                        // Phone number text field
                        (widget.isWorkshop && !isLogin)
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                width: size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(29),
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !value.startsWith('05') ||
                                        value.length < 10) {
                                      return 'Please provide a valid phone number';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) =>
                                      phoneNumber = newValue!,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.local_phone),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.0, color: Colors.red),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.0, color: Colors.red),
                                    ),
                                    hintText: 'Enter your phone number here',
                                    labelText: 'Phone number',
                                    labelStyle: TextStyle(fontSize: 20),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.0, color: Colors.black),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        // The password text field
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'Please provide a valid password';
                              }
                              return null;
                            },
                            onSaved: (newValue) => password = newValue!,
                            obscureText: false,
                            decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.password),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(width: 1.0, color: Colors.red),
                                ),
                                hintText: 'Enter your Password here',
                                labelText: 'Password',
                                labelStyle: TextStyle(fontSize: 20),
                                floatingLabelBehavior:
                                FloatingLabelBehavior.always,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.0, color: Colors.black),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(width: 1.0, color: Colors.red),
                                )),
                          ),
                        ),
                        (widget.isWorkshop && !isLogin)
                            ? HorizontalDivider(
                                sWidth: sWidth, sHeight: sHeight)
                            : Container(),
                        // Location map entry
                        (widget.isWorkshop && !isLogin)
                            ? LocationInput(
                                onSelectPlace: (double lat, double lon) {
                                  this.lat = lat;
                                  this.lon = lon;
                                },
                              )
                            : Container(),
                        (widget.isWorkshop && !isLogin)
                            ? HorizontalDivider(
                                sWidth: sWidth, sHeight: sHeight)
                            : Container(),
                        // choosing images for profile
                        (widget.isWorkshop && !isLogin)
                            ? ImageHandler(
                                onSelectImage: (XFile chosenImage) {
                                  this.chosenImage.add(chosenImage);
                                },
                                allowMultiple: false,
                              )
                            : Container(),
                        (widget.isWorkshop && !isLogin)
                            ? HorizontalDivider(
                                sWidth: sWidth, sHeight: sHeight)
                            : Container(),
                        // Agree to our terms and condition
                        isLogin
                            ? Container()
                            : Row(
                          children: [
                            SizedBox(
                              width: sWidth * 0.05,
                            ),
                            const Text('Agree to our'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/terms_and_conditions',
                                );
                              },
                              child: Text(
                                'Terms And Conditions',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            Checkbox(
                              value: agreedToTerms,
                              onChanged: (value) => setState(
                                    () {
                                  agreedToTerms = !agreedToTerms;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: sWidth * 0.05,
                            ),
                            // Forgot password text
                            Text(
                              isLogin ? 'Forgot your password?' : '',
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color.fromARGB(255, 3, 99, 177),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: isLogin ? sHeight * 0.04 : 0,
                        ),
                        // The login or signup button
                        isLoadingAuth
                            ? const CircularProgressIndicator()
                            : GestureDetector(
                          onTap: validateForm,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: Colors.black,
                            ),
                            height: sHeight * 0.08,
                            width: sWidth * 0.8,
                            child: Center(
                              child: Text(
                                isLogin ? 'Login' : 'Register',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sHeight * 0.03,
                        ),
                        Text(isLogin
                            ? 'You don\'t have an account?'
                            : 'Already have an account?'),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: Text(
                            isLogin ? 'Register Here' : 'Login Here',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
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
