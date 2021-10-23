
import 'package:bakar_brew/models/brew.dart';
import 'package:bakar_brew/screens/home/settings_form.dart';
import 'package:bakar_brew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:bakar_brew/services/database.dart';
import 'package:provider/provider.dart';

import 'brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth=AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child: SettingsForm()
        );
      });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService().brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Bakar Beverages'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: [
            TextButton.icon(
              icon: Icon(Icons.person,color: Colors.black,),
              onPressed: () async{
                await _auth.signOut();
              },
              label: Text('Logout',style: TextStyle(color: Colors.black),),
            ),
            TextButton.icon(
                onPressed: ()=>_showSettingsPanel(),
                icon: Icon(Icons.settings,
                  color: Colors.black,)
                , label: Text('Settings',
                    style: TextStyle(color: Colors.black),
              )
            )
          ],
        ),
        body: Container(
          child: BrewList(),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/coffee_bg.png'),fit: BoxFit.cover),

          )
        ),
      ),
    );
  }
}

