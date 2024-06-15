import 'package:flutter/material.dart';

class PromotionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/offers_banner.png'),
                  fit: BoxFit.cover,
                ),
              ),

            ),
            SizedBox(height: 20.0),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Offers & Promotions',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Colors.brown[900],

                      ),
                    ),
                  ],
                )
            ),

            SizedBox(height: 16.0),

            _buildPromotionCard(
              'Coffee of the Day',
              'Enjoy our special blend of the day at a 5% discount. Perfect for coffee enthusiasts!',
              'lib/images/day2.png',
            ),
            SizedBox(height: 16.0),
            _buildPromotionCard(
              'Buy One, Get One Free!',
              'Share the joy of coffee with a friend. Buy one coffee and get the second one absolutely free!',
              'lib/images/buy1.png',
            ),
            SizedBox(height: 16.0),
            _buildPromotionCard(
              'Loyalty Rewards',
              'Become a loyal customer and earn rewards with every purchase.',
              'lib/images/loyalty2.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionCard(String title, String description,
      String imagePath) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
            child: Image.asset(
              imagePath,
              height: 210.0,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade900,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.brown.shade900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}