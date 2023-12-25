import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_task/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
   _navigatorToHome();
  }

  void _navigatorToHome() async{
    await Future.delayed(const Duration(seconds: 4));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/app_face.png',
              width: MediaQuery.of(context).size.width * 0.7,
              ),
            const SizedBox(height: 30,),
            const Text('Todo Tasks',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            Lottie.asset('anim/loading.json',
              height: 155,
              repeat: true
            )
        
          ],
        ),
      )
    );
  }
}