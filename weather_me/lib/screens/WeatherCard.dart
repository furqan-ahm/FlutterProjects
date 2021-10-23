
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6),
      child: Card(
        color: Colors.blue[100],
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.lightBlue,),
                  title: Text('Sunny'),
                  subtitle: Text('slighty cloudy'),
                ),
            Image(image: NetworkImage('https://img.freepik.com/free-vector/colorful-palm-silhouettes-background_23-2148541792.jpg?size=626&ext=jpg'))
          ],
        ),
      ),
    );
  }
}
