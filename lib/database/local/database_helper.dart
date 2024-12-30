import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DatabaseHelper {
  static Database? _database;

  // Open the database
  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    // Get the path to the database
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDirectory.path, 'networking.db');

    // Open the database
    _database = await databaseFactoryIo.openDatabase(dbPath);
    return _database!;
  }

  // Close the database
  static Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
    }
  }
}