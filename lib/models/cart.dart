import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'item.dart';

class Cart extends ChangeNotifier{
  List<Item> hotBeverages=[
    Item(
      name: 'Cafe Mocha',
      price: '800',
      description: 'A blend of espresso, steamed milk, and chocolate syrup, topped with whipped cream!!',
      imagePath:'lib/images/mocha3.png',
    ),
    Item(
      name: 'Cafe Latte',
      price: '600',
      description: 'A creamy drink made with espresso and steamed milk, topped with milk foam!!',
      imagePath:'lib/images/coffee_3.jpg',
    ),
    Item(
      name: 'Americano',
      price: '400',
      description: 'Made by diluting a shot of espresso with hot water, strength to drip coffee!!',
      imagePath:'lib/images/americano2.jpg',

    ),
    Item(
      name: 'Cappuccino',
      price: '700',
      description: 'A classic Italian beverage consisting of equal parts espresso, steamed milk!!',
      imagePath:'lib/images/capp.jpg',
    ),
    Item(
      name: 'Macchiato',
      price: '900',
      description: 'A blend of espresso, steamed milk, and caramel syrup, creating a sweet treat!!',
      imagePath:'lib/images/caramel.jpg',
    ),
  ];

  //list of items in the user cart
  List<Item> userCart = [];

  //get List of hot beverages items
  List<Item> getHotBeverages()
  {
    return hotBeverages;
  }

  //get cart
  List<Item> getUserCart()
  {
    return userCart;
  }

  //add items to cart
  void addItemToCart(Item item, String selectedSize, int selectedQuantity){
    item.selectedSize=selectedSize;
    item.selectedQuantity=selectedQuantity;
    userCart.add(item);
    notifyListeners();
  }

  //remove item from cart
  void removeItemFromCart(Item item){
    userCart.remove(item);
    notifyListeners();
  }


  //cold beverages

  List<Item> coldBeverages=[
    Item(
      name: 'Iced Coffee',
      price: '600',
      description: 'Chilled coffee served over ice, often with the option to add milk, cream, or sweeteners to taste!!',
      imagePath:'lib/images/iced.jpg',
    ),
    Item(
      name: 'Frappuccino',
      price: '800',
      description: 'A blended coffee beverage made with espresso, milk, ice, and flavored syrups!!',
      imagePath:'lib/images/frappe.jpg',
    ),
    Item(
      name: 'Milk Tea',
      price: '600',
      description: 'Chilled brewed tea served with milk and tapioca pearls, available in strong black tea flavour!!',
      imagePath:'lib/images/tea.jpg',
    ),
    Item(
      name: 'Iced Americano',
      price: '700',
      description: 'Espresso served over ice, offering a strong and refreshing coffee option!!',
      imagePath:'lib/images/americano3.jpg',
    ),

  ];

  List<Item> getColdBeverages()
  {
    return coldBeverages;
  }

  //desserts

  List<Item> desserts=[
    Item(
      name: 'Tiramisu',
      price: '900',
      description: 'Indulge in layers of espresso-soaked ladyfingers, mascarpone cheese, and a dusting of cocoa!!',
      imagePath:'lib/images/tiramisu.jpg',
    ),
    Item(
      name: 'Crème Brûlée',
      price: '1000',
      description: 'Velvety vanilla custard topped with a caramelized sugar crust, served in an elegant ramekin!!',
      imagePath:'lib/images/creme.jpg',
    ),
    Item(
      name: 'Brownie',
      price: '300',
      description: 'Indulge in our decadent chocolate brownie, boasting a fudgy interior and crackly top!!',
      imagePath:'lib/images/brownie.jpg',
    ),
    Item(
      name: 'Tres Leches',
      price: '900',
      description: 'A sponge cake soaked in three types of milk—evaporated milk, condensed milk, and cream!!',
      imagePath:'lib/images/tres.jpg',
    ),

  ];

  List<Item> getDesserts()
  {
    return desserts;
  }


  //getSavoury

  List<Item> savoury=[
    Item(
      name: 'Sausage Roll',
      price: '200',
      description: 'Flaky pastry wrapped around seasoned sausage meat, offering a savory and satisfying snack!!',
      imagePath:'lib/images/roll.jpg',
    ),
    Item(
      name: 'Chicken Pie',
      price: '300',
      description: 'Tender chunks of chicken and savory gravy encased in buttery pastry, a comforting meal!!',
      imagePath:'lib/images/pie.jpg',
    ),
    Item(
      name: 'Cheese Puff',
      price: '200',
      description: 'Light and airy pastry filled with gooey melted cheese, offering a delicious savory treat!!',
      imagePath:'lib/images/puff.jpg',
    ),
    Item(
      name: 'Chicken bagel',
      price: '800',
      description: 'A hearty bagel sandwich filled with tender grilled chicken, crispy bacon strips and eggs!!',
      imagePath:'lib/images/bagel.jpg',
    ),

  ];

  List<Item> getSavoury()
  {
    return savoury;
  }

  //Shared Preferences package storing

  List<Item> userCartCheckout = [];
  SharedPreferences? _prefs;

  Cart() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }


  // Store cart data in SharedPreferences
  Future<void> storeCartData() async {
    if (_prefs != null) {
      await _prefs!.setString('cart', json.encode(userCart.map((item) => item.toJson()).toList()));
    }
  }

}