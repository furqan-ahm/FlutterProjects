import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setUpWorldTime () async {

    WorldTime instance=WorldTime(location: 'Karachi',flag: 'pakistan.png',url: 'Asia/Karachi');
    await instance.getTime();
    if(!instance.time.contains('Could not')) Navigator.pushReplacementNamed(context,'/home',arguments: instance);
  }

  @override
  void initState() {
    super.initState();
    setUpWorldTime();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Center(
        child: SpinKitCubeGrid(
        color: Colors.white,
          size: 50,
        )
      ),
    );
  }
}
