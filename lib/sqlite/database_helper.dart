import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final String databaseName = "yemek_soyle.sqlite";

  static Future<Database> accesToDatabase() async {
    String databasePath = join(await getDatabasesPath(), databaseName);

    if (await databaseExists(databasePath)) {
      print("Veritabanı var. Kopyalamaya gerek yok.");
    } else {
      ByteData data = await rootBundle.load("database/$databaseName");
      List<int> bytes = data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);
      await File(databasePath).writeAsBytes(bytes, flush: true);
      print("Veritabanı kopyalandı.");
    }
    return openDatabase(databasePath);
  }
}
