import 'package:practise/models/item.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../components/item_card.dart';
import '../models/cart.dart';

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({Key? key}) : super(key: key);

  @override
  _HomeContentPageState createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  List imageList = [
    {"id": 1, "image_path": 'lib/images/home_banner.png'},
    {"id": 2, "image_path": 'lib/images/day2.png'},
    {"id": 3, "image_path": 'lib/images/buy2.png'}
  ];
  final CarouselController carouselController = CarouselController();

  int sliderIndex = 0;



  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, value, child) => Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search...',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            onChanged: (value) {
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              InkWell(
                  onTap: () {
                    print(sliderIndex);
                  },
                  child: CarouselSlider(
                    items: imageList
                        .map(
                          (item)=> Image.asset(
                        item['image_path'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                        .toList(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio:2,
                        viewportFraction: 1,
                        onPageChanged: (index, reason){
                          setState(() {
                            sliderIndex = index;
                          });
                        }
                    ),
                  )
              )

            ],
          ),

          SizedBox(height: 30),


          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:  [
                  Text(
                    'Hot Beverages',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:23,
                      color: Colors.brown[900],
                    ),
                  ),
                ],
              )
          ),

          SizedBox(height: 10),

          Container(
            height: 240,
            child: Padding(
              padding: EdgeInsets.only(right:  20.0),
            child: ListView.builder(
              itemCount: value.getHotBeverages().length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                //create an item
                Item item = value.getHotBeverages()[
                  index
                ];

                return ItemCard(
                  item: item,
                  //onTap: () => addCoffeeToCart(item),
                );
              },
            ),
          ),
          ),

          SizedBox(height: 40),


          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:  [
                  Text(
                    'Cold Beverages',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:23,
                      color: Colors.brown[900],
                    ),
                  ),
                ],
              )
          ),

          SizedBox(height: 10),

          Container(
            height: 240,
            child: Padding(
              padding: EdgeInsets.only(right:  20.0),
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  //create an item
                  Item item = value.getColdBeverages()[
                  index
                  ];

                  return ItemCard(
                    item: item,
                    //onTap: () => addCoffeeToCart(item),
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 40),

          Container(
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/dessert_banner.png'),
                fit: BoxFit.cover,
              ),
            ),

          ),
          SizedBox(height: 30.0),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:  [
                  Text(
                    'Desserts',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:23,
                      color: Colors.brown[900],
                    ),
                  ),
                ],
              )
          ),

          SizedBox(height: 10),

          Container(
            height: 240,
            child: Padding(
              padding: EdgeInsets.only(right:  20.0),
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  //create an item
                  Item item = value.getDesserts()[
                  index
                  ];

                  return ItemCard(
                    item: item,
                    //onTap: () => addCoffeeToCart(item),
                  );
                },
              ),
            ),
          ),



          SizedBox(height: 40),


          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:  [
                  Text(
                    'Savoury Items',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:23,
                      color: Colors.brown[900],
                    ),
                  ),
                ],
              )
          ),

          SizedBox(height: 10),

          Container(
            height: 240,
            child: Padding(
              padding: EdgeInsets.only(right:  20.0),
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  //create an item
                  Item item = value.getSavoury()[
                  index
                  ];

                  return ItemCard(
                    item: item,
                    //onTap: () => addCoffeeToCart(item),
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 20),



        ],


      ),
    ),
    );
    }
}