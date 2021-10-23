import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location;//location name for UI
  String time='';    //time at set location
  String flag;    //url to an asset flag icon
  String url;     //location url for api endpoint
  bool isDayTime=true;
  DateTime? now;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async{

    try{
      //make request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data =jsonDecode(response.body);
      //print(data);

      //get properties from the data
      String datetime=data['datetime'];
      String offset=data['utc_offset'].substring(1,3);

      //print(datetime);
      //print(offset);

      now=DateTime.parse(datetime);
      now=now!.add(Duration(hours: int.parse(offset)));

      //set time property
      isDayTime=now!.hour>6&&now!.hour<18? true:false;
      time=DateFormat.jm().format(now!);
    }
    catch(e) {
      time='Could not get Time';
      print('error caught $e');
   }
  }

  String getIncTime(){
   now=now!.add(Duration(seconds: 1));
   isDayTime=now!.hour>6&&now!.hour<18? true:false;
   time=DateFormat.jm().format(now!);
   return time;
  }


}