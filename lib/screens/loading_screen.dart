

import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  getLocationData() async{

    WeatherModel model=WeatherModel();

    var weatherData= await model.getLocationWeatherData();

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationWeather: weatherData);
    }));

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();

  }

  @override
  Widget build(BuildContext context) {
    String myMargin="0";
    double myMarginAsDouble;
    try {
      myMarginAsDouble = double.parse(myMargin);
    }
    catch(e){
      print(e);
    }


    return Scaffold(
        body: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 100.0,
          ),
        ),
      );
  }
}


