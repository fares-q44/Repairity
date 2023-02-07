import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

import '../auth_screen/components/auth.dart';
import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      Navigator.of(context).pushReplacementNamed('/starting_screen');
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const IntroScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bool isLoggedIn = Provider.of<Auth>(context, listen: false).isLoggedIn();

      if (isLoggedIn) {
        final client = Supabase.instance.client;
        client
            .from('users')
            .select(
              'uid',
              const FetchOptions(
                count: CountOption.exact,
              ),
            )
            .eq('uid', client.auth.currentUser!.id)
            .then((value) {
          if (value.count == 0) {
            Navigator.of(context).pushNamed('/workshop_home');
          } else {
            Navigator.of(context).pushNamed('/user_home');
          }
        });
      } else {
        checkFirstSeen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
