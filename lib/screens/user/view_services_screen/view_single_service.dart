import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:repairity/screens/user/view_services_screen/widgets/single_service_item.dart';
import 'package:repairity/widgets/top_notch.dart';

import '../../../models/service2.dart';
import 'components/view_services_handler.dart';

class ViewSingleServiceScreen extends StatefulWidget {
  const ViewSingleServiceScreen({super.key, required this.title});
  final String title;

  @override
  State<ViewSingleServiceScreen> createState() =>
      _ViewSingleServiceScreenState();
}

class _ViewSingleServiceScreenState extends State<ViewSingleServiceScreen> {
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

  late Future<List<Service2>> future;
  @override
  void initState() {
    // TODO: implement initState
    future = Provider.of<ViewServicesHandler>(context, listen: false)
        .fetchAndSetService(widget.title);
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
          TopNotch(withBack: true, withAdd: false),
          FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                final List<Service2> fetchedServices = snapshot.data!;
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: sHeight * 0.005),
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
