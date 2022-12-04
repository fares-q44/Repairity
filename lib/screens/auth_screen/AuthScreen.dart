import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.isWorkshop});
  final bool isWorkshop;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    // Used for size setting
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(
          88,
          101,
          242,
          1,
        ),
        toolbarHeight: sHeight * 0.09,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: sHeight * 0.15,
              ),
              const Text(
                'Login',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: sHeight * 0.05,
              ),
              Form(
                child: Column(
                  children: [
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
                        decoration: const InputDecoration(
                          hintText: 'Enter your email here',
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 20),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    // The password text field
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your Password here',
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 20),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: sWidth * 0.05,
                        ),
                        // Forgot password text
                        const Text(
                          'Forgot your password?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromARGB(255, 3, 99, 177),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sHeight * 0.04,
                    ),
                    // The login or signup button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.black,
                        ),
                        height: sHeight * 0.08,
                        width: sWidth * 0.8,
                        child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
