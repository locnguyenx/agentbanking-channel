import 'dart:convert';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final secureStorageManagerProvider = Provider<SecureStorageManager>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return SecureStorageManager(storage);
});

final offlineQueueServiceProvider = Provider<OfflineQueueService>((ref) {
  final manager = ref.watch(secureStorageManagerProvider);
  return OfflineQueueService(manager);
});

final pendingQueueCountProvider = StreamProvider<int>((ref) {
  final service = ref.watch(offlineQueueServiceProvider);
  // Ensure init is called so count is emitted
  service.init();
  return service.queueCountStream;
});

class OfflineQueueService {
  Database? _db;
  final SecureStorageManager _storage;
  final StreamController<int> _countController = StreamController<int>.broadcast();

  OfflineQueueService(this._storage);

  Stream<int> get queueCountStream => _countController.stream;

  Future<void> _notifyCount() async {
    final count = await getCount();
    _countController.add(count);
  }

  Future<void> init() async {
    if (_db != null || kIsWeb) return;
    
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'offline_queue.db');

      final passphrase = await _storage.getSqlCipherPassphrase();

      _db = await openDatabase(
        path,
        password: passphrase,
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
      _notifyCount();
    } catch (e) {
      debugPrint('Failed to initialize offline queue: $e');
    }
  }

  Future<void> enqueue(Map<String, dynamic> payload, String idempotencyKey) async {
    if (kIsWeb) return;
    await init();
    if (_db == null) return;
    await _db!.insert('queue', {
      'payload': jsonEncode(payload),
      'idempotency_key': idempotencyKey,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });
    _notifyCount();
  }

  Future<List<Map<String, dynamic>>> getPending() async {
    if (kIsWeb) return [];
    await init();
    if (_db == null) return [];
    final results = await _db!.query('queue', orderBy: 'created_at ASC');
    return results.map((r) => {
      'id': r['id'],
      'payload': jsonDecode(r['payload'] as String),
      'idempotencyKey': r['idempotency_key'],
    }).toList();
  }

  Future<void> remove(int id) async {
    if (kIsWeb) return;
    await init();
    if (_db == null) return;
    await _db!.delete('queue', where: 'id = ?', whereArgs: [id]);
    _notifyCount();
  }

  Future<int> getCount() async {
    if (kIsWeb) return 0;
    await init();
    if (_db == null) return 0;
    final result = await _db!.rawQuery('SELECT COUNT(*) as count FROM queue');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
