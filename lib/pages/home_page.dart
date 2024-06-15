import 'package:practise/pages/promotions_page.dart';
import 'package:flutter/material.dart';
import 'package:practise/pages/profile_page.dart';
import 'package:practise/pages/home_content_page.dart';
import 'package:practise/pages/register_page.dart';
import 'package:practise/pages/settings_page.dart';


import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KOFFEE KORNER',
          style: TextStyle(
            color: Colors.brown[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.brown[900]),
        actions: [

          InkWell(
            onTap: () {

              Navigator.pushNamed(context, '/profilepage');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('lib/images/profile2.jpg'),
                radius: 20,
              ),
            ),
          ),
        ],
      ),
      drawer: Container(
        width: 330,
        child: Drawer(
          backgroundColor: Colors.brown[900],
          child: Column(
            children: [
              DrawerHeader(
                child: Image.asset(
                  'lib/images/logo.png',
                  height: 100,
                ),
              ),
              SizedBox(height: 30),
              buildDrawerItem(Icons.home, 'Home', '/homepage', 0),
              buildDrawerItem(Icons.settings, 'Settings', '/settingspage', _currentIndex),
              buildDrawerItem(Icons.location_on, 'Location', '/location_page', 0),
              buildDrawerItem(Icons.thumb_up, 'Recommendation', '/weather_page', 0),
              buildDrawerItem(Icons.logout, 'Log Out', '/login_page', 0),
            ],
          ),
        ),
      ),
      body: _buildHomeContent(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Promotions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedIconTheme: IconThemeData(color: Colors.brown),
        unselectedIconTheme: IconThemeData(color: Colors.brown[200]),
      ),
    );
  }

  Widget buildDrawerItem(IconData icon, String title, String route, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _currentIndex = index;
          });
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }

  Widget _buildHomeContent(int index) {
    switch (index) {
      case 0:
        return HomeContentPage();
      case 1:
        return CartPage();
      case 2:
        return PromotionsPage();
      case 3:
        return ProfilePage();
      default:
        return Container();
    }
  }


}