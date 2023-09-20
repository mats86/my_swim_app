import 'package:mysql1/mysql1.dart';

class Mysql {
  // static String host = '192.168.2.34',
  //               user = 'root',
  //               password = 'Freimann@2013',
  //               db = 'swim_db';
  static String host = '192.168.2.34',
      user = 'root',
      password = 'Freimann@2013',
      db = 'swim_db';
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var setting = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db
    );
    return await MySqlConnection.connect(setting);
  }
}