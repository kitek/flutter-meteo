import 'package:meteo/model/weather.dart';
import 'package:meteo/repository/datasource/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class WeatherDao {
  static const _TABLE_NAME = 'weathers';
  static const TABLE_CREATE_SQL = '''
        CREATE TABLE IF NOT EXISTS `$_TABLE_NAME` (
        `id` INTEGER NOT NULL, 
        `name` TEXT NOT NULL, 
        `geohash` TEXT NOT NULL, 
        `voivodeship` TEXT NOT NULL, 
        `latitude` REAL NOT NULL, 
        `longitude` REAL NOT NULL, 
        `position` INTEGER NOT NULL, 
        `um` TEXT NOT NULL, 
        `coamps` TEXT NOT NULL, 
        PRIMARY KEY(`id`)
        )''';

  Future<List<Weather>> list() async {
    final db = await DbProvider.db.database;
    final rows = await db.query(_TABLE_NAME, orderBy: 'position DESC');

    return rows.map((row) => Weather.fromMap(row)).toList();
  }

  Future<Weather> save(Weather model) async {
    final db = await DbProvider.db.database;

    await db.insert(
      _TABLE_NAME,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return model;
  }

  Future<void> remove(Weather model) async {
    final db = await DbProvider.db.database;

    return await db.delete(
      _TABLE_NAME,
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

//
//  Future<void> update(List<MyWeather> models) async {
//    final db = await DbProvider.db.database;
//    final rows = models.map((model) => model.toMap()).toList();
//
//    for (var row in rows) {
//      await db.update(
//        _TABLE_NAME,
//        row,
//        where: 'id = ?',
//        whereArgs: [row['id']],
//      );
//    }
//  }
}
