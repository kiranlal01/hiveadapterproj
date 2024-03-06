import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hiveadapterproj/database/database.dart';
import 'package:hiveadapterproj/hiveadapt/registration.dart';
import 'package:hiveadapterproj/model/usermodel.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());

  Hive.openBox<User>('user');

  runApp(GetMaterialApp(home: Login(),debugShowCheckedModeBanner: false,));
}

class Login extends StatelessWidget{
  TextEditingController uname=TextEditingController();
  TextEditingController pswd=TextEditingController();
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
                controller: uname,
                decoration: InputDecoration(
                hintText: 'email',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
              ),),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 50,right: 50),
              child: TextField(
                controller: pswd,
                decoration: InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
              ),),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: () async {
              final userList = await DBFunction.instance.getUser();
              findUser(userList);
            }, child: Text("Login")),
            TextButton(onPressed: () {
              Get.offAll(Register());
            }, child: Text("dont have account! register here"))
          ],
        ),
      ),
    );
  }

  Future <void> findUser(List<User> userList) async {
    final email = uname.text.trim();
    final password = pswd.text.trim();
    bool userFound = false;
    final validate = await validateLogin(email, password);

    if(validate == true){
      await Future.forEach(userList, (user) => {
        if(user.email == email && user.password == password){
          userFound = true
        }
        else{
          userFound = false
      }
      });
      if(userFound == true){
        Get.offAll(()=> Home(email : email));
        Get.snackbar("Success", "Login Success",backgroundColor: Colors.green);
      }
      else{
        Get.snackbar("Error", "Incorrect email/password",backgroundColor: Colors.red);
      }
    }
  }

  Future<bool>validateLogin(String email, String password) async {
    if(email != '' && password != ''){
      return true;
    }
    else{
      Get.snackbar("Error","Fields cannot be empty",backgroundColor: Colors.red);
      return false;
    }
  }
  
  

}