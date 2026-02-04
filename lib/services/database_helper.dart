import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  bool _isInitialized = false;

  /// Initialize Hive
  Future<void> init() async {
    if (_isInitialized) return;

    await Hive.initFlutter();
    _isInitialized = true;
  }

  /// Open a box (generic)
  Future<Box<T>> openBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    }
    return Hive.box<T>(boxName);
  }

  /// Write value
  Future<void> put<T>(
    String boxName,
    dynamic key,
    T value,
  ) async {
    final box = await openBox<T>(boxName);
    await box.put(key, value);
  }

  /// Read value
  T? get<T>(
    String boxName,
    dynamic key,
  ) {
    if (!Hive.isBoxOpen(boxName)) return null;
    return Hive.box<T>(boxName).get(key);
  }

  /// Get all values
  List<T> getAll<T>(String boxName) {
    if (!Hive.isBoxOpen(boxName)) return [];
    return Hive.box<T>(boxName).values.toList();
  }

  /// Delete by key
  Future<void> delete(
    String boxName,
    dynamic key,
  ) async {
    if (!Hive.isBoxOpen(boxName)) return;
    await Hive.box(boxName).delete(key);
  }

  /// Clear box
  Future<void> clearBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) return;
    await Hive.box(boxName).clear();
  }

  /// Close specific box
  Future<void> closeBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) return;
    await Hive.box(boxName).close();
  }

  /// Close all boxes
  Future<void> closeAll() async {
    await Hive.close();
  }
}
