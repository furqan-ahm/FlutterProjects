import 'package:flutter/material.dart';
import 'package:weather_me/screens/home.dart';
import 'package:weather_me/screens/loading.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(context)=>Loading(),
      '/home':(context)=>Home(),
    },
  ));
}