import 'package:app_flutter/dao/OpenDatabase.dart';
import 'package:sqflite/sqflite.dart';

class TokenDao{
  saveToken(String token) async{
    final Database db = await getDatabase();
    db.update("token", {"token":token}, where: "codigo = 1");
  }

  Future<String> getToken() async{
    final Database db = await getDatabase();
    List<Map<String, dynamic>> maps = await db.query("token");
    return maps[0]['token'];
  }
}