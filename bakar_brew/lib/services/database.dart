import 'package:bakar_brew/models/brew.dart';
import 'package:bakar_brew/models/users.dart';
import 'package:bakar_brew/screens/home/brew_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService{

  final CollectionReference brewCollection=FirebaseFirestore.instance.collection('Brews');
  final String? uid;


  DatabaseService({this.uid});

  Future updateUserdata(String name,String sugars,int strength) async{
   return await brewCollection.doc(uid).set({
     'sugars':sugars,
     'name':name,
     'strength':strength
   });
  }

  //get brew stream

  Stream<List<Brew>> get brews{
    return brewCollection.snapshots().map(_brewlistFromSnapshot);
  }

  //userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(uid: uid,name: snapshot.get('name'),sugars: snapshot.get('sugars'),strength: snapshot.get('strength'));
  }

  //brew list from snapshot
  List<Brew> _brewlistFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.get('name')??'',
        sugar: doc.get('sugars')??'',
        strength: doc.get('strength')??0
      );
    }).toList();
  }

  //get user specific data
  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}