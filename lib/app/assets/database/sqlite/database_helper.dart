import 'dart:io';
import 'package:logger/logger.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final String _databaseName = "yemek_soyle.sqlite";

  static Future<Database> accesToDatabase() async {
    final logger = Logger();
    String databasePath = join(await getDatabasesPath(), _databaseName);

    if (await databaseExists(databasePath)) {
      logger.d("Veritabanı var. Kopyalamaya gerek yok.");
    } else {
      ByteData data = await rootBundle.load("database/$_databaseName");
      List<int> bytes = data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);
      await File(databasePath).writeAsBytes(bytes, flush: true);
      logger.d("Veritabanı kopyalandı.");
    }
    return openDatabase(databasePath);
  }
}
