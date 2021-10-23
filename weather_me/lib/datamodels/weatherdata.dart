class WeatherState{

  String date;
  String state;
  String desc;
  String name;
  double temp;
  double morntemp;
  double eventemp;
  double nightemp;
  int humidity;
  double wind;


  WeatherState(
      {
        required this.desc,
        required this.state,
        required this.temp,
        required this.humidity,
        required this.wind,
        required this.name,
        required this.morntemp,
        required this.eventemp,
        required this.nightemp,
        required this.date,
      });

  String toString(){
    return 'state: $state \n'+
        'desc: $desc \n'+
        'temp: $temp \n'+
        'morntemp: $morntemp \n'+
        'nightemp: $nightemp \n'+
        'eventemp: $eventemp \n'+
        'humidity: $humidity \n'+
        'wind: $wind \n'+
        'date: $date \n';
  }

}