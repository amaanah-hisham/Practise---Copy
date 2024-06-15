import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

import '../components/item_card.dart';
import '../models/item.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPage();
}

class _WeatherPage extends State<WeatherPage> {
  String temperature = '';
  String description = '';
  String weatherMessage = '';
  String? weatherImage;
  String recommendation = '';

  double latitude = 0.0;
  double longitude = 0.0;

  List _weatherItems = [];

  //To fetch items from the json file
  Future<void> getItemsJson(double tempInCelsius) async {
    final String result = await rootBundle.loadString('assets/recommendation.json');
    final data = await json.decode(result);
    if (tempInCelsius > 30) {
      setState(() {
        weatherMessage = 'Hot weather';
        weatherImage = 'lib/images/hot.jpg';
        _weatherItems = (data["warmWeather"]  as List)
            .map((item) => Item(
          name: item['name'],
          price: item['price'],
          imagePath: item['imagePath'],
          description: item['description'],
        )).toList();
      });
    } else if (tempInCelsius < 20) {
      setState(() {
        weatherMessage = 'Cold weather';
        weatherImage = 'lib/images/cold.jpg';
        _weatherItems = (data["coldWeather"]  as List)
            .map((item) => Item(
          name: item['name'],
          price: item['price'],
          imagePath: item['imagePath'],
          description: item['description'],
        )).toList();
      });
    } else {
      setState(() {
        weatherMessage = 'Mild weather';
        weatherImage = 'lib/images/mild.jpg';
        _weatherItems = (data["mildWeather"]  as List)
            .map((item) => Item(
          name: item['name'],
          price: item['price'],
          imagePath: item['imagePath'],
          description: item['description'],
        )).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getWeatherInfo();
    getGeolocation();
  }

  void getWeatherInfo() async {
    Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=e3286c439c2ecf08e9e43c44da0cbe19');
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      setState(() {
        double tempKelvin =
        double.parse(decodedData["main"]["temp"].toString());
        double tempCelsius = _convertKelvinToCelsius(tempKelvin);
        temperature = tempCelsius.toStringAsFixed(
            2); // for temperature with 2 decimal places
        description = decodedData["weather"][0]["description"];
        getItemsJson(tempCelsius);
      });
    } else {
      setState(() {
        temperature = 'Failed to fetch data';
        description = '';
        weatherMessage = '';
      });
    }
  }

  double _convertKelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  void getGeolocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    //since, getCurrentPosition returns type "future position" we need to use await async fucntion.
    //so first once the getCurrentPosition is satisfied, it executes the getGeoLocation (the main method) and then assigns the value to a object of type position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    latitude = position.latitude;
    longitude = position.longitude;

  }

  void _showWeatherInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Weather Info', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21), ),
          contentPadding: EdgeInsets.fromLTRB(24, 0, 24, 0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: Colors.grey.shade400,
                  thickness: 2,
                  height: 20,
                ),
              ),
              SizedBox(height:10),
              Row(
                children: [
                  Icon(Icons.thermostat, size: 18, color: Colors.brown[900]),
                  SizedBox(width: 10),
                  Text(
                    'Temperature: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '$temperature°C',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.brown[900],
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height:13),

              Row(
                children: [
                  Icon(Icons.cloud, size: 18, color: Colors.brown[900]),
                  SizedBox(width: 10),
                  Text(
                    'Forecast: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.brown[900],
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height:13),
              Row(
                children: [
                  Icon(Icons.sunny_snowing, size: 18, color: Colors.brown[900]),
                  SizedBox(width: 10),
                  Text(
                    'Weather: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    weatherMessage,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.brown[900],
                      fontSize: 18,
                    ),
                  ),
                ],
              ),

              SizedBox(height:25),

              Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[900],
                  ),
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              SizedBox(height:18),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Recommendation',
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5),
                Container(
                  height: 160.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/images/cart_banner3.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 25),

                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:  [
                        Text(
                          'Try Some:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:23,
                            color: Colors.brown[900],
                          ),
                        ),
                      ],
                    )
                ),

                SizedBox(height: 20),

                Container(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _weatherItems.length,
                      itemBuilder: (context, index) {
                        Item weatherItem = _weatherItems[index];
                        return ItemCard(item: weatherItem);
                      },
                    ),
                  ),
                ),


                SizedBox(height: 40),

                Stack(
                  children: [
                    Container(
                      height: 130.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('$weatherImage'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 130.0,
                        child: ElevatedButton.icon(
                          onPressed: () => _showWeatherInfoDialog(context),
                          icon: Icon(
                            Icons.cloud,
                            color: Colors.white,
                          ),
                          label: Text(
                            'View Weather Info',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  height: 35,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      getWeatherInfo();
                      getGeolocation();
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Refresh',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[900],
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

}