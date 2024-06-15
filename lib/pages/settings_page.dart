import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkModeEnabled = false;
  bool areNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),
     home: Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: isDarkModeEnabled ? Colors.white : Colors.brown[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isDarkModeEnabled ? Color(0xFF1E1E1E) : Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: isDarkModeEnabled ? Colors.white : Colors.brown[900]),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [

          SizedBox(height: 16),

          // Dark Mode
          ListTile(
            title: Text(
                'Dark Mode',
              style: TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.brown[900],
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Switch(
              value: isDarkModeEnabled,
              activeColor: isDarkModeEnabled ? Colors.white : Colors.brown[900],
              onChanged: (value) {
                setState(() {
                  isDarkModeEnabled = value;
                  // dark mode change
                });
              },
            ),
            onTap: () {
              //  dark mode settings
            },
          ),

          SizedBox(height: 16),
          // Send Notifications
          ListTile(
            title: Text('Send Notifications to Mobile',
              style: TextStyle(
                color: isDarkModeEnabled ? Colors.white : Colors.brown[900],
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Switch(
              value: areNotificationsEnabled,
              activeColor: isDarkModeEnabled ? Colors.white : Colors.brown[900],
              onChanged: (value) {
                setState(() {
                  areNotificationsEnabled = value;
                  //   notifications change
                });
              },
            ),
            onTap: () {
              //  notifications settings
            },
          ),

          SizedBox(height: 16),

          // Terms and Conditions
          InkWell(
            onTap: () {

            },
            child: ListTile(
              title: Text('Terms and Conditions',
                style: TextStyle(
                  color: isDarkModeEnabled ? Colors.white : Colors.brown[900],
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),

          SizedBox(height: 16),

          // About
          InkWell(
            onTap: () {

            },
            child: ListTile(
              title: Text('About',
                style: TextStyle(
                  color: isDarkModeEnabled ? Colors.white : Colors.brown[900],
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),

          SizedBox(height: 16),


          // Help
          InkWell(
            onTap: () {

            },
            child: ListTile(
              title: Text('Help',
                style: TextStyle(
                  color: isDarkModeEnabled ? Colors.white : Colors.brown[900],
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),

          SizedBox(height: 50),


          // Logout Button
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login_page');
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.brown[900],
                borderRadius: BorderRadius.circular(35),
              ),
              child: Center(
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
     ),
    );
  }
}
