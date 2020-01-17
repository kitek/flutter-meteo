import 'package:meteo/repository/datasource/weather_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  DbProvider._();

  static final String _dbFileName = 'meteo.db';
  static final DbProvider db = DbProvider._();
  Database _database;

  Future<Database> get database async {
    if (null == _database) _database = await _init();

    return _database;
  }

  Future<Database> _init() async {
    return await openDatabase(
      join(await getDatabasesPath(), _dbFileName),
      onCreate: (db, version) {
        return db.execute(WeatherDao.TABLE_CREATE_SQL.trim());
      },
      version: 1,
    );
  }
}
