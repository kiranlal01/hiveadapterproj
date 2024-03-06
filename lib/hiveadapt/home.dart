import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  final String email;
  
  const Home({Key? key,required this.email});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text("Welcome $email",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w600),)),
    );
  }

}