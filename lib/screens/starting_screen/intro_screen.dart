import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:repairity/widgets/top_notch.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    List<PageViewModel>? listPagesViewModel = [
      PageViewModel(
        title: "Post",
        bodyWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Publish a post to get pricing\n offers from workshops')
          ],
        ),
        image: SvgPicture.asset(
          'assets/icons/Post.svg',
          fit: BoxFit.cover,
        ),
      ),
      PageViewModel(
        title: "Services",
        bodyWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('You can view all kinds of services with workshops')
          ],
        ),
        image: SvgPicture.asset(
          'assets/icons/Service.svg',
        ),
      ),
      PageViewModel(
        title: "Workshops",
        bodyWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('View all workshops with its location and reviews')
          ],
        ),
        image: SvgPicture.asset(
          'assets/icons/Workshops.svg',
          fit: BoxFit.cover,
          height: sHeight * 0.27,
        ),
      ),
    ];
    return Scaffold(
        body: Column(
      children: [
        TopNotch(withBack: false, withAdd: false),
        SizedBox(
          height: sHeight * 0.1,
        ),
        SizedBox(
          height: sHeight * 0.7,
          child: IntroductionScreen(
            pages: listPagesViewModel,
            showSkipButton: false,
            skip: const Icon(Icons.skip_next),
            next: const Text("Next"),
            done: const Text("Done",
                style: TextStyle(fontWeight: FontWeight.w700)),
            onDone: () {
              // On Done button pressed
              Navigator.of(context).pushReplacementNamed('/starting_screen');
            },
            dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              activeColor: Theme.of(context).colorScheme.secondary,
              color: Colors.black26,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
            ),
          ),
        )
      ],
    ));
  }
}
