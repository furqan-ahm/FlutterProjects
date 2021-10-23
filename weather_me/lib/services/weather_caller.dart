
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:weather_me/datamodels/weatherdata.dart';
import 'package:weather_me/screens/WeatherCard.dart';

class WeatherService{

  WeatherState? state;
  List<WeatherState>? states;
  String lat;
  String lon;
  List<String> days=['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];

  WeatherService({required this.lat,required this.lon});

  Future<void> getWeather()async{

    try{
      Response response= await get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=b75af819e7df6fa6f0e8c566bc34904a'));
      Map currentData=jsonDecode(response.body);

      response=await get(Uri.parse('http://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&exclude=current,minutely&appid=b75af819e7df6fa6f0e8c566bc34904a'));
      Map forecastData=jsonDecode(response.body);


      Map weather=currentData['weather'][0];
      Map main=currentData['main'];

      int weekday=(DateTime.fromMillisecondsSinceEpoch(currentData['dt'])).add(Duration(hours: 5)).weekday-1;
      String decide='';

      if((weather['main'] as String).toLowerCase().contains('clouds')){decide='Cloudy';}
      else if((weather['main'] as String).toLowerCase().contains('clear')){decide='Clear Sky';}
      else decide=weather['main'];

      state=WeatherState(
          desc: weather['description'],
          state: decide,
          temp: main['temp'],
          humidity: main['humidity'],
          name: currentData['name'],
          wind: currentData['wind']['speed'],
          morntemp: forecastData['daily'][0]['temp']['morn'],
          eventemp: forecastData['daily'][0]['temp']['eve'],
          nightemp: forecastData['daily'][0]['temp']['night'],
          date: days[weekday],
      );

      //print(DateFormat('EEEE').format((DateTime.fromMillisecondsSinceEpoch(currentData['dt']))));


      states=List.generate(8, (index) {

        if(index==0)return state!;

        if((forecastData['daily'][index]['weather'][0]['main'] as String).toLowerCase().contains('clouds')){decide='Cloudy';}
        else if((forecastData['daily'][index]['weather'][0]['main'] as String).toLowerCase().contains('clear')){decide='Clear Sky';}
        else decide=forecastData['daily'][index]['weather'][0]['main'];

        weekday=(DateTime.fromMillisecondsSinceEpoch(forecastData['daily'][index]['dt']*1000)).add(Duration(hours: 0)).weekday-1;


        return WeatherState(
          name: currentData['name'],
          state: decide,
          temp: forecastData['daily'][index]['temp']['day'],
          morntemp: forecastData['daily'][index]['temp']['morn'],
          nightemp: forecastData['daily'][index]['temp']['night'],
          eventemp: forecastData['daily'][index]['temp']['eve'],
          date: days[weekday],
          desc: forecastData['daily'][index]['weather'][0]['description'],
          wind: forecastData['daily'][index]['wind_speed'],
          humidity: forecastData['daily'][index]['humidity'],
          );
        }
        );




    }
    catch(e) {
      print(e);
    }
  }

}