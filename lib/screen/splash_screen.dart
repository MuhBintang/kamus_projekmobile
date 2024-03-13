import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kamus_trpl3b/screen/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
with SingleTickerProviderStateMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => OnBoarding()
      ));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, 
    overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade600, Colors.lightBlue.shade200], 
            begin: Alignment.topRight,
            end: Alignment.bottomLeft, 
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book,
              size: 80,
              color: Colors.white,  
            ),
            SizedBox(height: 20),
            // Text(
            //   "Kamus", 
            //   style: TextStyle(
            //     fontStyle: FontStyle.normal,
            //     fontWeight: FontWeight.bold, 
            //     color: Colors.white, 
            //     fontSize: 32
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}