import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/cart_item.dart';
import '../models/cart.dart';
import '../models/item.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Container(
              height: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/cart_banner3.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'My Cart',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cart.getUserCart().length,
                itemBuilder: (context, index) {
                  // Get individual item
                  Item individualItem = cart.getUserCart()[index];
                  // Return cart item
                  return CartItem(item: individualItem, showEditAndDeleteOptions: true,);

                },
              ),
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: cart.getUserCart().isEmpty // Check if cart is empty
                    ? null // If cart is empty, onTap will be null and button will be disabled
                    : () {
                  // Store cart data when checkout button is clicked
                  cart.storeCartData();
                  Navigator.pushNamed(context, '/checkoutpage');
                },
                child: Container(
                  width: 110,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: cart.getUserCart().isEmpty ? Colors.grey : Colors.brown[900],
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Text(
                    'Checkout',
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

