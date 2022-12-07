import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewPostsScreen extends StatelessWidget {
  const ViewPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('This is view workshop posts screen'),
            ElevatedButton(
              onPressed: () {
                Supabase.instance.client.auth.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/starting_screen',
                  (route) => false,
                );
              },
              child: const Text('Signout'),
            )
          ],
        ),
      ),
    );
  }
}
