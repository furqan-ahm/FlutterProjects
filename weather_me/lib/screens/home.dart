
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:weather_me/datamodels/weatherdata.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  WeatherState? currentWeather;
  List<WeatherState>? weatherStates;
  List<String> days=['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
  double _value=1;
  bool day=true;
  double index=0;

  Color textColor=Colors.white;

  @override
  Widget build(BuildContext context) {


  //  currentWeather=ModalRoute.of(context)!.settings.arguments as WeatherState;
    weatherStates=ModalRoute.of(context)!.settings.arguments as List<WeatherState>;


    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/bg.jpg'),fit: BoxFit.cover)
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_city,color: Colors.white,),
                    Text(weatherStates![index.toInt()].name,style: TextStyle(color: Colors.white),)
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${weatherStates![index.toInt()].temp.toStringAsFixed(1)}',
                      style: TextStyle(
                          fontSize: 90,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      '°C',
                      style: TextStyle(
                          fontSize: 70,
                          color: Colors.white,
                          fontWeight: FontWeight.normal
                      ),
                    )
                  ],
                ),

                SizedBox(height: 6,),
                Text(
                  weatherStates![index.toInt()].desc,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.normal
                  ),
                ),
                Container(
                  width:200,
                  child: Divider(
                    height: 60,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 300,
                          width: 250,
                          child: Card(
                            borderOnForeground: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            color: Colors.transparent,
                            shadowColor: Colors.indigo[900],
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 40,),
                                  Text(
                                    weatherStates![index.toInt()].state,
                                    style: TextStyle(color: textColor, fontSize: 40,fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    'Wind: ${weatherStates![index.toInt()].wind} m/s',
                                    style: TextStyle(color: textColor,fontSize: 18),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    'Humidity: ${weatherStates![index.toInt()].humidity}%',
                                    style: TextStyle(color: textColor,fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 80,
                          child: Card(
                              borderOnForeground: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              color: Colors.transparent,
                              shadowColor: Colors.indigo[900],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Morn \n${weatherStates![index.toInt()].morntemp.round()}°C',
                                  style: TextStyle(color: textColor,fontSize: 16),
                                ),
                                Text(
                                  'Evening\n${weatherStates![index.toInt()].eventemp.round()}°C',
                                  style: TextStyle(color: textColor,fontSize: 16),
                                ),
                                Text(
                                  'Night\n${weatherStates![index.toInt()].nightemp.round()}°C',
                                  style: TextStyle(color: textColor,fontSize: 16),
                                ),
                              ],
                            ),

                          )
                        )
                      ],
                    ),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        Container(
                          height: 300,
                          width: 100,
                          child: Card(
                            borderOnForeground: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            color: Colors.transparent,
                            shadowColor: Colors.indigo[900],
                            child:  SfSlider.vertical(
                              thumbIcon: Icon(Icons.timelapse),
                              value: index,
                              min: 0.0,
                              max: 7.0,
                              interval: 1.0,
                              stepSize: 1.0,
                              showTicks: true,
                              labelFormatterCallback: (dynamic actualValue, String formattedText) {
                                return weatherStates![actualValue.toInt()].date;
                              },
                              showLabels: true,
                              showDivisors: true,
                              inactiveColor: Colors.blueGrey,
                              activeColor: Colors.blueGrey,
                              onChanged: (dynamic value){
                                  setState(() {
                                    index=value;
                                  });
                                },
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 100,
                          child: Card(
                            borderOnForeground: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            color: Colors.transparent,
                            shadowColor: Colors.indigo[900],
                            child: FloatingActionButton(
                              child: Text(
                                  'Reload',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16
                                  ),
                              ),
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              onPressed: (){
                                setState(() {
                                  Navigator.popAndPushNamed(context, '/');
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
