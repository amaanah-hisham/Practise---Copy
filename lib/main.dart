import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:practise/pages/checkout_page.dart';
import 'package:practise/pages/location_page.dart';
import 'package:practise/pages/weather.dart';
import 'firebase_options.dart';

import 'package:practise/pages/cart_page.dart';
import 'package:practise/pages/home_page.dart';
import 'package:practise/pages/profile_page.dart';
import 'package:practise/pages/promotions_page.dart';
import 'package:practise/pages/register_page.dart';
import 'package:practise/pages/settings_page.dart';
import 'package:practise/pages/home_content_page.dart';
import 'package:provider/provider.dart';
import 'models/cart.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures that binding is initialized before Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (Context)=> Cart(),
      builder: (context, child)=> MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/login_page': (context) => LoginPage(),
        '/homepage': (context) => HomePage(),
        '/homecontenet': (context) => HomeContentPage(),
        '/registerpage': (context) => RegisterPage(),
        '/cartpage': (context) => CartPage(),
        '/settingspage': (context) => SettingsPage(),
        '/profilepage': (context) => ProfilePage(),
        '/promotionspage': (context) => PromotionsPage(),
        '/location_page': (context) => LocationPage(),
        '/weather_page': (context) => WeatherPage(),
        '/checkoutpage': (context) => CheckoutPage(),

      },
    ),
    );
  }
}
