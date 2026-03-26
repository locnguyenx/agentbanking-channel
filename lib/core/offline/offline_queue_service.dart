import 'dart:convert';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart';

class OfflineQueueService {
  Database? _db;
  final String _passphrase;

  OfflineQueueService(this._passphrase);

  Future<void> init() async {
    if (_db != null) return;
    
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'offline_queue.db');

    _db = await openDatabase(
      path,
      password: _passphrase,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE queue (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            payload TEXT NOT NULL,
            idempotency_key TEXT NOT NULL,
            created_at INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> enqueue(Map<String, dynamic> payload, String idempotencyKey) async {
    await init();
    await _db!.insert('queue', {
      'payload': jsonEncode(payload),
      'idempotency_key': idempotencyKey,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<Map<String, dynamic>>> getPending() async {
    await init();
    final results = await _db!.query('queue', orderBy: 'created_at ASC');
    return results.map((r) => {
      'id': r['id'],
      'payload': jsonDecode(r['payload'] as String),
      'idempotencyKey': r['idempotency_key'],
    }).toList();
  }

  Future<void> remove(int id) async {
    await init();
    await _db!.delete('queue', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> getCount() async {
    await init();
    final result = await _db!.rawQuery('SELECT COUNT(*) as count FROM queue');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
