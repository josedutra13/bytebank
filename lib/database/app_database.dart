import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbpath = await getDatabasesPath();
  final String path = join(dbpath, 'bytebank.db1');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDao.tableSql);
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete,
  );
  // return getDatabasesPath().then((dbPath) {
  //   final String path = join(dbPath, 'bytebank.db1');

  //   return openDatabase(path, onCreate: (db, version) {
  //     db.execute(
  //         'CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT, accountNumber INTEGER)');
  //   }, version: 1, onDowngrade: onDatabaseDowngradeDelete);
  // });
}
