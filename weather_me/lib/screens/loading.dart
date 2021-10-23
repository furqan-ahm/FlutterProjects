import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_me/services/weather_caller.dart';
import 'package:geolocator/geolocator.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String state='';
  Position? _currentLoc;



  void setWeatherState()async{
    //getting location permission if need be
    LocationPermission isGranted;
    bool isEnabled;

    state='checking location service';


    //getting location service if need be
    try{
      isEnabled= await Geolocator.isLocationServiceEnabled();
    }
    catch(e)
    {
      setState(() {
        state=e.toString();
      });
      return;
    }

    setState(() =>state='Service check done');

    if(!isEnabled){
      setState(() {
        state='Please Enable Location Services and Restart the app';
      });
      return;
    }


    setState(() =>state='Location privilege check');

    isGranted=await Geolocator.checkPermission();

    if(isGranted==LocationPermission.denied){
      setState(() =>state='Getting permission');
      isGranted=await Geolocator.requestPermission();
      if(isGranted==LocationPermission.denied||isGranted==LocationPermission.deniedForever)return;

    }


    setState(() =>state='Getting location');
    //getting location
    _currentLoc=await Geolocator.getCurrentPosition();

    setState(() =>state='Getting weather data');

    WeatherService w1;
    w1=WeatherService(lat: _currentLoc!.latitude.toString(), lon: _currentLoc!.longitude.toString());

    //getting weather details
    await w1.getWeather();

    setState(() =>state='Done');
    Navigator.pushReplacementNamed(context, '/home',arguments: w1.states);
  }

  @override
  void initState() {
    super.initState();
    setWeatherState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFoldingCube(
              size: 60,
              color: Colors.white,
            ),
            SizedBox(height: 30,),
            Text(state,style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
