import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  //final void Function()? onTap;

  ItemCard({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: EdgeInsets.only(left: 25),
        width: 240,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Pic
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(item.imagePath),
            ),

            // Name + Price
            Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'LKR ' + item.price,
                        style: TextStyle(
                          color: Colors.brown[900],
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),

                  // Button to add to cart
                  GestureDetector(
                    onTap: () {
                      _showItemDetails(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.brown[900],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

    );
  }

  void _showItemDetails(BuildContext context) {

    String selectedSize = 'M'; // Default size = Medium
    int selectedQuantity = 1; // Default quantity = 1

    showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.brown[900],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade400,
                    thickness: 2,
                    height: 20,
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //SizedBox(height: 10),
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      item.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.brown[700],
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(height: 17),

                  Text(
                    'Select Size:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['S', 'M', 'L'].map((size) {
                      return GestureDetector(
                        onTap: () {
                          //  selected size when tapped
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: size == selectedSize ? Colors.brown[900] : Colors.white,
                            border: Border.all(
                              color: size == selectedSize ? Colors.brown : Colors.grey.shade700,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              color: size == selectedSize ? Colors.white : Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Select Quantity:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //border: Border.all(color: Colors.brown),
                            color: Colors.brown[900],
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero, // padding to center the icon
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              // Decrease quantity
                              if (selectedQuantity > 1) {
                                setState(() {
                                  selectedQuantity--;
                                });
                              }
                            },
                            iconSize: 20, //  size of the icon
                            color: Colors.white, // Minus Icon Color
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '$selectedQuantity',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.brown[900],
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 30, // width of the buttons
                        height: 30, // height of the buttons
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //border: Border.all(color: Colors.brown),
                            color: Colors.brown[900],
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero, //  padding to center the icon
                            icon: Icon(Icons.add),
                            onPressed: () {
                              // Increase quantity
                              setState(() {
                                selectedQuantity++;
                              });
                            },
                            iconSize: 20, //  size of the icon
                            color: Colors.white, // Plus Icon Color
                          ),
                        ),
                      ),
                    ],
                  ),




                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Price: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[900],
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'LKR ${item.price}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[900],
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),


                  SizedBox(height: 7),
                ],
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.brown[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    //  add to cart function with selectedSize and quantity
                    Provider.of<Cart>(context, listen: false).addItemToCart(item, selectedSize, selectedQuantity);
                    _showSnackbar(context);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[900],
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

void _showSnackbar(BuildContext context) {
  final snackBar = SnackBar(
    content: Text('Item added to the cart successfully'),
    duration: Duration(seconds: 1),
    backgroundColor: Colors.brown[900],
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}