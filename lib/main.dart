import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/screens/auth_screen/components/auth.dart';
import 'package:repairity/screens/auth_screen/map_helpers/location_helper.dart';
import 'package:repairity/screens/auth_screen/terms_and_conditions_screen.dart';
import 'package:repairity/screens/starting_screen/splash_screen.dart';
import 'package:repairity/screens/starting_screen/starting_screen.dart';
import 'package:repairity/screens/user/bottom_nav_bar_screen/bottom_nav_bar.dart';
import 'package:repairity/screens/user/user_posts/add_post_screen.dart';
import 'package:repairity/screens/user/user_posts/user_posts_screen.dart';
import 'package:repairity/screens/workshop/view_posts_screen/view_posts_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

import 'screens/user/user_posts/components/user_posts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await Supabase.initialize(
    url: 'https://atpuopxuvfwzdzfzxawq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF0cHVvcHh1dmZ3emR6Znp4YXdxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzAxNjYwNzAsImV4cCI6MTk4NTc0MjA3MH0.8SG6mX8oT2rDlkv5YRmULk3PlG-zK-Y8IVlbTgfbsRI',
  );
  runApp(const MyApp());
}
// abns
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => Auth(),
        ),
        Provider(
          create: (_) => UserPosts(),
        ),
        Provider(
          create: (_) => LocationHelper(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: const Color.fromRGBO(
              88,
              101,
              242,
              1,
            )),
        routes: {
          '/terms_and_conditions': (context) =>
              const TermsAndConditionsScreen(),
          '/user_posts': (context) => const UserPostsScreen(),
          '/view_posts': (context) => const ViewPostsScreen(),
          '/starting_screen': (context) => const StartingScreen(),
          '/user_home': (context) => const BottomNavBar(),
          '/add_post': (context) => const AddPostScreen(),
        },
        home: const SplashScreen(),
      ),
    );
  }
}
