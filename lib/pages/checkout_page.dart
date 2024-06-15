import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practise/pages/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/cart_item.dart';
import '../models/cart.dart';
import '../models/item.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key});

  @override
  _CheckoutPage createState() => _CheckoutPage();
}

class _CheckoutPage extends State<CheckoutPage> {
  late List<Item> cartItemsCheckout;
  double totalAmount = 0.0;

  //to fetch user info
  String fetchedEmail = '';
  String fetchedMobile = '';
  String fetchedAddress = '';


  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadCartData();
  }


  //to load the cart items using shared Preferences package
  Future<void> _loadCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartDataString = prefs.getString('cart');
    if (cartDataString != null) {
      List<dynamic> decodedData = json.decode(cartDataString);
      setState(() {
        cartItemsCheckout = decodedData.map((data) => Item.fromJson(data)).toList();
        totalAmount = cartItemsCheckout.fold(0.0,
                (previousValue, element) => previousValue + (double.parse(element.price) * element.selectedQuantity));
      });
    } else {
      setState(() {
        cartItemsCheckout = [];
        totalAmount = 0.0;
      });
    }

    await _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          fetchedEmail = userDoc['email'];
          fetchedMobile = userDoc['mobile'];
          fetchedAddress = userDoc['address'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(
            color: Colors.brown[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.brown[900]),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'My Order',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: Colors.brown[900]),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cartItemsCheckout.length,
                itemBuilder: (context, index) {
                  // Get individual item
                  Item individualItem = cartItemsCheckout[index];
                  // Return cart item
                  return CartItem(item: individualItem, showEditAndDeleteOptions: false,);
                },
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
              thickness: 2,
              height: 10,
            ),
            SizedBox(height: 15),

            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.brown[900]),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivery Address:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.brown[900]),
                      ),
                      SizedBox(height: 5),
                      Text(
                        fetchedAddress.isNotEmpty ? fetchedAddress : 'Address',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.brown[900]),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward, color: Colors.brown[900]),
                onPressed: () {
                  // Navigate to the existing profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
            ],
          ),
            SizedBox(height:5),
            Divider(
              color: Colors.grey.shade400,
              thickness: 2,
              height: 10,
            ),
            SizedBox(height:5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.call, color: Colors.brown[900]),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mobile Number:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.brown[900]),
                        ),
                        SizedBox(height: 5),
                        Text(
                          fetchedMobile.isNotEmpty ? fetchedMobile : 'Mobile',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.brown[900]),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.brown[900]),
                  onPressed: () {
                    // Navigate to the existing profile page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 10),
            Divider(
              color: Colors.grey.shade400,
              thickness: 2,
              height: 10,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.shopping_cart_checkout_rounded, color: Colors.brown[900]),
                    SizedBox(width: 15),
                    Text(
                      'Total: ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.brown[900]),
                    ),
                  ],
                ),
                Text(
                  'LKR ${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.brown[900]),
                ),
              ],
            ),
            SizedBox(height:10),
            Divider(
              color: Colors.grey.shade400,
              thickness: 2,
              height: 10,
            ),
            SizedBox(height:10),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: double.infinity, // Full width
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    'Pay Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
