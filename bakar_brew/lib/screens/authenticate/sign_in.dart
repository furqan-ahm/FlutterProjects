import 'package:bakar_brew/models/users.dart';
import 'package:bakar_brew/services/auth.dart';
import 'package:bakar_brew/shared/constants.dart';
import 'package:bakar_brew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Sign_In extends StatefulWidget {

  final Function? toggleView;

  Sign_In({this.toggleView});

  @override
  _Sign_InState createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {

  bool loading=false;
  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();
  //for taking from text fields
  String _email='';
  String _password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: Text('Sign in to Bakar Brews'),
        actions: [
          TextButton.icon(
              onPressed: (){
                widget.toggleView!();
              },
              icon: Icon(Icons.person_add, color: Colors.black,),
              label: Text('Register',style: TextStyle(color: Colors.black),)
          )
        ],
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                TextFormField(
                      validator: (val)=>val!.isEmpty?'Enter an Email':null,
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  onChanged: (val) {
                    setState(() =>  _email=val);
                    },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (val)=>val!.length<6?'Enter 6+ char Password':null,
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  onChanged: (val){
                    setState(()=> _password=val);
                    },
                  obscureText: true,
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pinkAccent
                  ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      setState(() => loading=true);
                      dynamic result =await _auth.signInWithEmai_Password(_email, _password);
                      error='';
                      if(!(result is MyUser)){
                        setState(() {
                          error=result is String?result:'Unknown Error';
                          loading=false;
                        });
                      }
                    }
                  },
                  child: Text('Sign In',style: TextStyle(color: Colors.white),)
                ),
                SizedBox(height: 12,),
                Text(
                    error,
                    style: TextStyle(fontSize: 14,color:Colors.red,)
                )
              ],
            )
        ),
      )
    );
  }
}
