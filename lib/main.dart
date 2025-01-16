import 'package:boookie/firebase_options.dart';
import 'package:boookie/pages/home_page.dart';
import 'package:boookie/pages/splash_screen.dart';
import 'package:boookie/pages/ticket_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BookNest',
      debugShowCheckedModeBanner: false,
      home: TicketPage(eventName: "Ikigai", eventPrice: "800/-"),
    );
  }
}
