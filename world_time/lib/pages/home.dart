import 'dart:async';

import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  WorldTime? clock;
  Timer? timer;
  String? time;
  bool start=true;


  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) =>
    {
      setState(() {
        clock!.getIncTime();
      })
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   //set background

    if(start) {
      clock = ModalRoute.of(context)!.settings.arguments as WorldTime;
      start=false;
    }
    String bgImage = clock!.isDayTime?'Morning.gif':'Night.gif';
    Color? bgColor=clock!.isDayTime?Colors.purple[200]:Colors.pink[200];
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child:  Container(
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Column(
                children: [
                  TextButton.icon(
                      onPressed: () async{
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        setState(() {
                          clock=result;
                        });
                        },
                      icon: Icon(Icons.edit_location,color: Colors.blueGrey[800],),
                      label: Text('Change Location',style: TextStyle(color: Colors.blueGrey[800]),)
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        clock!.location,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          letterSpacing: 2,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(
                    clock!.time,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 66
                    ),
                  )

                ],
              ),
            ),
          )
      ),
    );
  }
}