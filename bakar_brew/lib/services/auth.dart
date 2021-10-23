import 'package:bakar_brew/models/users.dart';
import 'package:bakar_brew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth=FirebaseAuth.instance;

  //creating a MyUser object
  MyUser? _userFromFirebase(User? user) {
    return user!=null?MyUser(uid:user.uid):null;
  }

  //auth change user stream
  Stream<MyUser?> get user{
    return _auth.authStateChanges()
        .map(_userFromFirebase);
  }


  //sign in anon

  Future signInAnon() async {
    try{
     UserCredential credential= await _auth.signInAnonymously();
     User user=credential.user as User;
     return _userFromFirebase(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


  //sign in with email

  Future signInWithEmai_Password(String email,String password) async{

    try{
      UserCredential credential=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user=credential.user as User;

      return _userFromFirebase(user);
    }

    catch(e){
      print('Unable to Sign In' + e.toString());
      if (e is FirebaseAuthException) {
        String code= e.code;
        switch(code){
          case'wrong-password':
            code='Enter a valid password';
            break;
          case'invalid-email':
            code='Please enter valid email';
            break;
          case 'user-not-found':
            code='Invalid Email';
            break;
        }
        return code;
      }
      return null;
    }
  }


  //register

  Future registerWithEmail_Password(String email,String password) async{
    try{
      UserCredential credential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user=credential.user as User;

      //
      await DatabaseService(uid: user.uid).updateUserdata('New Member', '0', 100);

      return _userFromFirebase(user);
    }
    catch(e) {
      print('Unable to Register' + e.toString());
      if (e is FirebaseAuthException) {
        String code= e.code;
        switch(code){
          case'invalid-email':
            code='Please enter valid email';
            break;
          case 'email-already-in-use':
            code='Email is already in use';
            break;
        }
        return code;
      }
      return null;
    }
  }


  //signout

  Future signOut()async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print('couldnt sign out'+e.toString());
      return null;
    }
  }

}