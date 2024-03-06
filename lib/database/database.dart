import 'package:hive/hive.dart';

import '../model/usermodel.dart';

class DBFunction{
  DBFunction.internal();


  static DBFunction instance = DBFunction.internal();

  factory DBFunction(){
    return instance;
  }

  Future<void> userSignUp(User user) async {
    final db = await Hive.openBox<User>('users');
    db.put(user.id,user);
  }

  Future<List<User>> getUser() async {
    final db = await Hive.openBox<User>('users');
    return db.values.toList();
  }

}