import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/models/service.dart';
import 'package:repairity/widgets/dropdown_button.dart';
import 'package:repairity/widgets/top_notch.dart';

import '../../api/service.dart';

class ScreenServiceUpsert extends StatefulWidget {
  const ScreenServiceUpsert({super.key});

  @override
  State<ScreenServiceUpsert> createState() => _ScreenServiceUpsertState();
}

class _ScreenServiceUpsertState extends State<ScreenServiceUpsert> {
  String id = '';
  String type = '';
  String name = '';
  String price = '';
  String costLabor = '';
  bool isPublishing = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> upsertService() async {
    setState(() {
      isPublishing = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        if (id != '') {
          await Provider.of<Services>(context, listen: false)
              .editService(id, type, name, price, costLabor);
        } else {
          await Provider.of<Services>(context, listen: false)
              .addService(type, name, price, costLabor);
        }
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
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Object? serviceObject = ModalRoute.of(context)?.settings.arguments;
    if (serviceObject != null) {
      Service srv = serviceObject as Service;
      id = srv.id;
      type = srv.type;
      name = srv.name;
      price = srv.price;
      costLabor = srv.costLabor;
    }
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
          //  const TopNotch(withBack: true),
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
                    child: FeqraDropdownButton(
                      list: const <String>[
                        '',
                        'Oil',
                        'Tires',
                        'Brakes',
                        'Anything'
                      ],
                      defaultValue: type,
                      onSelectChanged: (String newValue) {
                        type = newValue;
                      },
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
                      initialValue: name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a name for your service';
                        }
                        return null;
                      },
                      onSaved: (newValue) => name = newValue!,
                      decoration: const InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0, color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0, color: Colors.red),
                        ),
                        hintText: 'Enter the name here',
                        labelText: 'Service Name',
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
                      initialValue: price,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a price';
                        }
                        return null;
                      },
                      onSaved: (newValue) => price = newValue!,
                      decoration: const InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0, color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0, color: Colors.red),
                        ),
                        hintText: 'Enter your price here',
                        labelText: 'Price',
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
                      initialValue: costLabor,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a cost for your service';
                        }
                        return null;
                      },
                      onSaved: (newValue) => costLabor = newValue!,
                      decoration: const InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0, color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0, color: Colors.red),
                        ),
                        hintText: 'Enter service cost here',
                        labelText: 'Service Cost',
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
                  SizedBox(
                    height: sHeight * 0.03,
                  ),
                  isPublishing
                      ? const CircularProgressIndicator()
                      : GestureDetector(
                    onTap: upsertService,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.black,
                      ),
                      height: sHeight * 0.08,
                      width: sWidth * 0.8,
                      child: Center(
                        child: Text(
                          id != '' ? 'Update' : 'Publish',
                          style: const TextStyle(
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
