
import 'package:bakar_brew/models/users.dart';
import 'package:bakar_brew/services/database.dart';
import 'package:bakar_brew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:bakar_brew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey=GlobalKey<FormState>();
  final List<String> sugars=['0','1','2','3','4'];

  //form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user =Provider.of<MyUser?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData? userData=snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Update your brew preferences',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  initialValue: userData!.name,
                  decoration: textInputDecoration,
                  validator: (val)=>val!.isEmpty?'Please enter a name':null,
                  onChanged: (val)=>setState(()=>_currentName=val),
                ),
                SizedBox(height: 20,),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars==null?userData.sugars:_currentSugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugar(s)'),
                    );
                  }).toList(),
                  onChanged: (val)=>setState(() => _currentSugars=val as String),
                ),
                Slider(
                  value: (_currentStrength??userData.strength)!.toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? 100],
                  inactiveColor: Colors.brown[_currentStrength ?? 100],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val)=>setState(()=>_currentStrength=val.round()),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      await DatabaseService(uid: user.uid).updateUserdata(
                          (_currentName ?? userData.name) as String,
                          (_currentSugars ?? userData.sugars) as String,
                          (_currentStrength ?? userData.strength) as int);
                    }
                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                  style: ElevatedButton.styleFrom(primary: Colors.pink[400]),
                )
              ],
            ),
          );

        }
        else{
          return Loading();
        }

      }
    );
  }
}
