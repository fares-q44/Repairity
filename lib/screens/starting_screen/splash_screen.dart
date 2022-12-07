import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

import '../auth_screen/components/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bool isLoggedIn = Provider.of<Auth>(context, listen: false).isLoggedIn();

      if (isLoggedIn) {
        final client = Supabase.instance.client;
        client
            .from('users')
            .select('type')
            .eq('uid', client.auth.currentUser!.id)
            .then((value) {
          if (value == 'workshop') {
            Navigator.of(context).pushNamed('/view_posts');
          } else {
            Navigator.of(context).pushNamed('/user_home');
          }
        });
      } else {
        Navigator.of(context).pushNamed('/starting_screen');
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
