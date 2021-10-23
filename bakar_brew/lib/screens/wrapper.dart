import 'package:bakar_brew/models/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return home/authenticate
    final user= Provider.of<MyUser?>(context);

    if(user==null)return Authenticate();
    else return Home();
  }
}
