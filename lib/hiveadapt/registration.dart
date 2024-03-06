import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiveadapterproj/hiveadapt/login.dart';

import '../database/database.dart';
import '../model/usermodel.dart';

class Register extends StatelessWidget{

  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController cpassword=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left: 50,right: 50),
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                  hintText: 'email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
              ),),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 50,right: 50),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
              ),),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 50,right: 50),
              child: TextField(
                controller: cpassword,
                decoration: InputDecoration(
                  hintText: 'confirm password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
              ),),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: () {
              validateSignUp();
              Get.offAll(Login());
            }, child: Text("SignUp")),
            TextButton(onPressed: () {
              Get.offAll(Login());
            }, child: Text("Already register! login here"))
          ],
        ),
      ),
    );
  }

  void validateSignUp() async {
    final email = username.text.trim(); //email from controller
    final pass = password.text.trim();
    final cpass = cpassword.text.trim();

    final emailValidationResult = EmailValidator.validate(email);

    if (email!= "" && pass != "" && cpass != "") {
      if (emailValidationResult == true) {
        final passValidationResult = checkPassword(pass, cpass);
        if (passValidationResult == true){
          final user = User(email: email, password: pass);
          await DBFunction.instance.userSignUp(user);
          Get.back();
          Get.snackbar("Success", "Account created");
        }
      }
      else{
        Get.snackbar("Error", "Provide valid Email");
      }
    }
    else{
      Get.snackbar("Error", "Fields cannot be empty");
    }
  }

  bool checkPassword(String pass, String cpass) {
    if (pass == cpass) {
      if (pass.length < 6) {
        Get.snackbar("Error", "Password length should be > 6");
        return false;
      }
      else{
        return true;
      }
    }
    else{
      Get.snackbar("Error", "Password mismatch");
      return false;
    }
  }

}