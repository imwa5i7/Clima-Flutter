import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {

  final locationWeather;
  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  int temperature;
  int condition;
  String cityName;

  String weatherIcon;
  String weatherMessage;

  WeatherModel model=WeatherModel();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateUi(widget.locationWeather);

  }

  void updateUi(dynamic weatherData){

    setState(() {

      if(weatherData == null){
        temperature=0;
        condition=0;
        cityName="";
        weatherIcon="error";
        weatherMessage="error";
        return;
      }
      var temp=weatherData['main']['temp'];
      //converting double to integer
      this.temperature=temp.toInt();
      condition = weatherData['weather'][0]['id'];
      cityName=weatherData['name'];


      weatherIcon=model.getWeatherIcon(condition);
      weatherMessage=model.getMessage(temperature);

    });

    print(temperature);
    print(condition);
    print(cityName);

  }

  double convertKelvinToCelsius(){
    double celsius= temperature - 273.15;
    return celsius;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await model.getLocationWeatherData();
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      var typedName=await Navigator.push(context, MaterialPageRoute(builder: (context)=> CityScreen()));
                      print("Value from TextField :$typedName");
                      if(typedName !=null){
                       var weatherData= await model.getCityWeather(typedName);
                       updateUi(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
