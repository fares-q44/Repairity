import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/screens/auth_screen/map_helpers/location_input.dart';
import 'package:repairity/widgets/top_notch.dart';

import 'components/auth.dart';

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
  String phoneNumber = '';
  bool isLoadingAuth = false;
  bool agreedToTerms = false;

  Future<void> validateForm() async {
    setState(() {
      isLoadingAuth = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await Provider.of<Auth>(context, listen: false).authinticate(
          email,
          password,
          isLogin,
          widget.isWorkshop,
          username,
        );
        if (widget.isWorkshop) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/view_posts',
            (route) => false,
          );
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/user_home',
            (route) => false,
          );
        }
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
        );
      }
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
            TopNotch(withBack: true, withAdd: false),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: sHeight * (widget.isWorkshop ? 0.02 : 0.1),
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
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
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
                            obscureText: true,
                            decoration: const InputDecoration(
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
                            ? LocationInput(
                                onSelectPlace: () {},
                              )
                            : Container(),
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
