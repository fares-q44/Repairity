import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:repairity/screens/user/view_services_screen/widgets/single_service_item.dart';
import 'package:repairity/widgets/top_notch.dart';

import '../../../models/service2.dart';
import '../view_workshop_profile_screen/view_workshop_profile_screen.dart';
import 'components/view_services_handler.dart';

class ViewSingleServiceScreen extends StatelessWidget {
  const ViewSingleServiceScreen({super.key, required this.title});
  final String title;

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
    final future = Provider.of<ViewServicesHandler>(context, listen: false)
        .fetchAndSetService(title);
    return Scaffold(
      body: Column(
        children: [
          TopNotch(withBack: true, withAdd: false),
          FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                final List<Service2> fetchedServices = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: sHeight * 0.01),
                    itemCount: fetchedServices.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                        future: calculateDistance(
                            fetchedServices[index].workshop.lat,
                            fetchedServices[index].workshop.lon),
                        builder: (context, snapshot) => SingleServiceItem(
                          service: fetchedServices[index],
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
      backgroundColor: const Color.fromARGB(255, 218, 218, 218),
    );
  }
}
