

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zedd/ChatMessage.dart';
import 'package:zedd/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) {
    await Firebase.initializeApp(options: const FirebaseOptions(
       apiKey: "AIzaSyDAmn_jagAcTyunkq8TZRprv6livdcbIEo",
    authDomain: "zedd-81fa1.firebaseapp.com",
    projectId: "zedd-81fa1",
    storageBucket: "zedd-81fa1.appspot.com",
    messagingSenderId: "1050597014178",
    appId: "1:1050597014178:web:9f447836359bbc9c9335fb",
    measurementId: "G-GJ5CS8LKPZ"));

  }else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (BuildContext context,AsyncSnapshot snapshot){
        if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }
        if(snapshot.connectionState==ConnectionState.active){
          if(snapshot.data==null){
            return Latelogin();
          }else{
            return Chatmessage();
          }
        }
        return Center(child: CircularProgressIndicator(),);
      })
    );
  }
}

