import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/screens/user/view_workshop_profile_screen/widgets/review_item.dart';

import '../components/view_workshop_handler.dart';

class AllReviews extends StatefulWidget {
  const AllReviews({
    Key? key,
    required this.workshopID,
  }) : super(key: key);
  final String workshopID;

  @override
  State<AllReviews> createState() => _AllReviewsState();
}

class _AllReviewsState extends State<AllReviews> {
  late Future future;
  @override
  void initState() {
    // TODO: implement initState
    future = Provider.of<ViewSingleWorkshopHandler>(context, listen: false)
        .fetchAndSetReviews(widget.workshopID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.isEmpty) {
              return const Align(
                alignment: Alignment.center,
                child: Text('There are no Reviews'),
              );
            }
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => ReviewItem(
                username: snapshot.data![index].userName,
                review: snapshot.data![index].comment,
                rate: snapshot.data![index].rate,
              ),
            );
          }
        });
  }
}
