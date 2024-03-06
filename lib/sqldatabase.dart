import 'package:sqflite/sqflite.dart' as sql;

class Sqlhelper {
  static Future<sql.Database> myData() async {
    return sql.openDatabase('myDetails',version: 1,
        onCreate: (sql.Database database,int version) async {
          await createTables(database);
        });
  }

  ///create table with column name as name,email,password
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE details(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT,
    email TEXT,
    password TEXT
    )""");
  }

  static Future<int>addDatabase(String name,String email,String password) async {
    final db=await Sqlhelper.myData();
    final data = {
      'name': name,
      'email': email,
      'password': password
    };
    final id=db.insert('details',data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }


  static Future<List<Map>>userFound(String Eemail)async{
    final db=await Sqlhelper.myData();
    final data=await db.rawQuery(
        "SELECT * FROM details WHERE email='$Eemail'"
    );
    if(data.isNotEmpty){
      return data;
    }
    return data;
  }


  static Future<List<Map>>CheckLogin(String email,String password) async {
    final db=await Sqlhelper.myData();
    final data=await db.rawQuery("SELECT * FROM details WHERE email='$email' AND password='$password' ");

    if(data.isNotEmpty){
      return data;
    }
    return data;
  }


  static Future<void> Deleteuser(int id) async {
    final db = await Sqlhelper.myData();
    db.delete('details',where:'id = ?',whereArgs: [id]);
  }


  static Future<List<Map>> getAll() async {
    final db =await Sqlhelper.myData();
    final data = db.rawQuery("SELECT * FROM details");
    return data;
  }



  static Future<sql.Database>dataBase2()async{
    return sql.openDatabase('Itemadd',version: 2,
        onCreate:(sql.Database database,int version)async{
          await createTables1(database);
        }
    );
  }

  static Future<void>createTables1(sql.Database database)async{
    await database.execute(""" CREATE TABLE addItem(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      pname TEXT,
      pprice TEXT,
      pdetails TEXT
    )""");
  }

  static Future<int>addItem(String pname,String pprice,String pdetails)async{
    final db=await Sqlhelper.dataBase2();
    final data={'pname':pname,'pprice':pprice,'pdetails':pdetails};
    final id=db.insert('addItem',data,conflictAlgorithm:sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map>>getData()async{
    var db=await Sqlhelper.dataBase2();
    var data=await db.rawQuery(
        "SELECT * FROM addItem"
    );
    return data;
  }

}