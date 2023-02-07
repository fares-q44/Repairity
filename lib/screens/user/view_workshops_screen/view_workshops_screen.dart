import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:repairity/models/workshop.dart';
import 'package:repairity/screens/user/view_workshops_screen/components/view_workshops_handler.dart';
import 'package:repairity/widgets/top_notch.dart';

import 'widgets/single_workshop_item.dart';

class ViewWorkshopScreen extends StatelessWidget {
  const ViewWorkshopScreen({super.key});

  Future<double> calculateDistance(lat2, lon2) async {
    try {
      final currentLocation = await Geolocator.getCurrentPosition();
      final lat1 = currentLocation.latitude;
      final lon1 = currentLocation.longitude;
      return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Container(
      color: const Color.fromARGB(255, 218, 218, 218),
      child: Column(
        children: [
          TopNotch(withBack: false, withAdd: false),
          FutureBuilder(
            future: Provider.of<ViewWorkshopHandler>(context, listen: false)
                .fetchAndSetWorkshops(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: [
                    SizedBox(
                      height: sHeight * 0.35,
                    ),
                    const CircularProgressIndicator(),
                  ],
                );
              } else {
                final List<Workshop> fetchedWorkshops = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: sHeight * 0.01),
                    itemCount: fetchedWorkshops.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                        future: calculateDistance(fetchedWorkshops[index].lat,
                            fetchedWorkshops[index].lon),
                        builder: (context, snapshot) => SingleWorkshopItem(
                          workshop: fetchedWorkshops[index],
                          snapshot: snapshot,
                        ),
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
