import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:repairity/models/service.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

import '../../api/service.dart';

class ScreenServices extends StatefulWidget {
  const ScreenServices({super.key});

  @override
  State<ScreenServices> createState() => _ScreenServicesState();
}

class _ScreenServicesState extends State<ScreenServices> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: sHeight * 0.12,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              color: Color.fromRGBO(
                88,
                101,
                242,
                1,
              ),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/service_upsert');
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          isDeleting
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: const CircularProgressIndicator())
              : const SizedBox(
                  height: 1,
                ),
          FutureBuilder(
            future:
                Provider.of<Services>(context, listen: false).getOwnServices(),
            builder: (context, AsyncSnapshot<List<Service>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasError) {
                  PostgrestException error =
                      snapshot.error as PostgrestException;
                  return Column(
                    children: [
                      Center(
                        child: Text(
                          error.message,
                          style: const TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  Axis direction = Axis.vertical;
                  return Expanded(
                    child: ListView.separated(
                        scrollDirection: direction,
                        itemBuilder: (context, int index) {
                          Service item = snapshot.data![index];
                          return Slidable(
                            // Specify a key if the Slidable is dismissible.
                            key: ValueKey<int>(index),

                            // The start action pane is the one at the left or the top side.
                            startActionPane: ActionPane(
                              extentRatio: .25,
                              // A motion is a widget used to control how the pane animates.
                              motion: const DrawerMotion(),

                              // A pane can dismiss the Slidable.
                              // dismissible: DismissiblePane(onDismissed: () { }),
                              dismissible: DismissiblePane(
                                onDismissed: () {},
                                closeOnCancel: true,
                                confirmDismiss: () async {
                                  return await showDialog<bool>(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Are you sure?'),
                                            content: const Text(
                                                'Are you sure to delete?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () async {
                                                  bool result =
                                                      await deleteService(
                                                          item.id);
                                                  Navigator.of(context)
                                                      .pop(result);
                                                  setState(() {
                                                    isDeleting = !result;
                                                  });
                                                },
                                                child: const Text('Yes'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: const Text('No'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                                },
                              ),

                              // All actions are defined in the children parameter.
                              children: const [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  flex: 1,
                                  onPressed: doNothing,
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                                /*SlidableAction(
                                  onPressed: doNothing,
                                  backgroundColor: Color(0xFF21B7CA),
                                  foregroundColor: Colors.white,
                                  icon: Icons.share,
                                  label: 'Share',
                                ),*/
                              ],
                            ),

                            // The end action pane is the one at the right or the bottom side.
                            endActionPane: ActionPane(
                              extentRatio: .25,
                              motion: const ScrollMotion(),
                              children: [
                                /*SlidableAction(
                                  // An action can be bigger than the others.
                                  flex: 2,
                                  onPressed: doNothing,
                                  backgroundColor: Color(0xFF7BC043),
                                  foregroundColor: Colors.white,
                                  icon: Icons.archive,
                                  label: 'Archive',
                                ),*/
                                SlidableAction(
                                  flex: 1,
                                  onPressed: (BuildContext context) {
                                    Navigator.pushNamed(
                                        context, '/service_upsert',
                                        arguments: item);
                                  },
                                  backgroundColor: const Color(0xFF0392CF),
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                              ],
                            ),

                            // The child of the Slidable is what the user sees when the
                            // component is not dragged.
                            child: ListTile(
                              selectedTileColor: Colors.lightBlueAccent,
                              tileColor: const Color.fromRGBO(0, 255, 255, 0.5),
                              // leading: const Icon(Icons.add),
                              title: Text(item.type,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color:
                                          Color.fromARGB(200, 247, 247, 140)),
                                  textScaleFactor: 1.5),
                              trailing:
                                  LayoutBuilder(builder: (context, constraint) {
                                return _icon(
                                    item.name, constraint.biggest.height);
                              }),
                              subtitle: Text(
                                  "Name: ${item.name}\nPrice: ${item.price}\nCost: ${item.costLabor}",
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white)),
                              selected: true,
                              onTap: () {
                                setState(() {
                                  // txt = 'List Tile pressed';
                                });
                              },
                            ),
                          );
                        },
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 3,
                            )),
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: sHeight * 0.35,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/service_upsert');
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: sHeight * 0.02),
                          width: sWidth * 0.18,
                          height: sHeight * 0.09,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(Icons.add),
                          ),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'No Services Yet',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  );
                }
              }
            },
          )
        ],
      ),
    );
  }

  bool isDeleting = false;

  Future<bool> deleteService(String id) async {
    try {
      setState(() {
        isDeleting = true;
      });
      return Provider.of<Services>(context, listen: false).deleteService(id);
    } on Exception catch (e) {
      String err = e.toString();
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err),
        ),
      );
    }
    return false;
  }
}

void doNothing(BuildContext context) {}

Widget _icon(String type, double mySize) {
  switch (type) {
    case 'Oil':
      return Icon(Icons.oil_barrel_outlined, color: Colors.white, size: mySize);
    /*return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/images/serviceMotorOil.png'),
      );*/
    case 'Tires':
      return Icon(Icons.tire_repair, color: Colors.white, size: mySize);
    case 'Brakes':
      return Icon(Icons.view_carousel, color: Colors.white, size: mySize);
    case 'Anything':
      return Icon(Icons.car_crash, color: Colors.white, size: mySize);
    default:
      return Icon(Icons.car_repair, color: Colors.white, size: mySize);
  }
}
