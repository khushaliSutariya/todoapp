import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todoapp/Screens/AddDataScreen.dart';
import 'package:todoapp/Screens/Homepage.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void resetNewLaunch() async {
    Timer(Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>  Homepage()));
    });
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resetNewLaunch();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Notes",style: TextStyle(fontFamily: "Roboto",fontSize: 35.0),)),
        ],
      ),
    );
  }
}
