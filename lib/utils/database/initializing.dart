import 'package:sqflite/sqflite.dart';
import 'package:wgnrr/utils/database/models/categories.dart';
import 'package:wgnrr/utils/database/models/feeds.dart';
import 'package:wgnrr/utils/database/models/stats.dart';

class wgnrr {
  static final wgnrr instance = wgnrr._init();
  static Database? _database;
  wgnrr._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('wgnrr.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = [dbPath, filePath].join('');
    // join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final imageType = 'TEXT';
    await db.execute('''
     CREATE TABLE $Feeds(
      ${FeedFields.id} $idType,
      ${FeedFields.title} $textType,
      ${FeedFields.date} $textType,
      ${FeedFields.image} $imageType,
      ${FeedFields.author} $textType,
      ${FeedFields.caption} $textType,
      ${FeedFields.description} $textType
     )
''');
//     await db.execute('''
//      CREATE TABLE $Stats(
//       ${StatsFields.id} $idType,
//       ${StatsFields.title} $textType,
//       ${StatsFields.date} $textType,
//       ${StatsFields.image} $textType,
//       ${StatsFields.author} $textType,
//       ${StatsFields.caption} $textType,
//       ${StatsFields.description} $textType,
//      )
// ''');
//     await db.execute('''
//      CREATE TABLE $Categories(
//       ${CategoriesFields.id} $idType,
//       ${CategoriesFields.title} $textType,
//       ${CategoriesFields.date} $textType,
//       ${CategoriesFields.image} $textType,
//       ${CategoriesFields.author} $textType,
//       ${CategoriesFields.caption} $textType,
//       ${CategoriesFields.description} $textType,
//      )
// ''');
  }

  Future<Feed> create(Feed Feed) async {
    final db = await instance.database;
    final id = await db.insert(Feeds, Feed.toJson());
    return Feed.copy(id: id);
  }

  // Future<Feed> readFeed(int id) async {
  //   final db = await instance.database;
  //   List maps = await db.query(
  //     Feeds,
  //     columns: FeedFields.values,
  //     //  where: '${FeedFields.id} = ?',
  //     //  whereArgs: [id],
  //   );
  //   if (maps.isNotEmpty) {
  //     data = jsonDecode(maps);
  //      return data;
  //   }
  // }

  // get all rows from the table
  Future<List<Map<String, dynamic>>> getRows() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> rows = await db.query('feeds');
    return rows;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
