

import 'package:geolocator/geolocator.dart';

class Location{
  double _longitude;
  double _latitude;


  double get getLongitude => _longitude;

  double get getLatitude => _latitude;



  Future<void> getCurrentLocation() async{
    try{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      print("Latitude : ${position.latitude}");
      print("Longitude : ${position.longitude}");
      _longitude = position.longitude;
      _latitude = position.latitude;
    }
    catch(e){
      print("Clima App Location Exception is : $e");
      openAppSettings();
    }
  }

  openAppSettings() async{
    await Geolocator.openAppSettings();
  }

}