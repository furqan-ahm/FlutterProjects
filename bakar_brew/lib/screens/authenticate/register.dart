
import 'package:bakar_brew/models/users.dart';
import 'package:bakar_brew/services/auth.dart';
import 'package:bakar_brew/shared/constants.dart';
import 'package:bakar_brew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function? toggleView;

  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();

}

class _RegisterState extends State<Register> {

  final AuthService _auth=AuthService();
  final _formkey=GlobalKey<FormState>();
  bool loading=false;

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
          title: Text('Sign Up to Bakar Brews'),
          actions: [
            TextButton.icon(
                onPressed: (){
                  widget.toggleView!();
                },
                icon: Icon(Icons.person, color: Colors.black,),
                label: Text('Sign In',style: TextStyle(color: Colors.black),)
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
          child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val)=>val!.isEmpty?'Enter an Email':null,
                    onChanged: (val) {
                      setState(() =>  _email=val);
                      },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val)=>val!.length<6?'Enter 6+ chars long password':null,
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
                        if(_formkey.currentState!.validate()){
                          setState(() =>loading=true);
                          dynamic result=await _auth.registerWithEmail_Password(_email, _password);
                          error='';
                          if(!(result is MyUser)){
                            setState(() {
                              loading=false;
                              error=result is String?result:'Unknown Error';
                            });
                          }
                        }
                      },
                      child: Text('Register',style: TextStyle(color: Colors.white),)
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
