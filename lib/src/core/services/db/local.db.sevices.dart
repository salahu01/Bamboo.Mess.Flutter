import 'package:freelance/src/core/models/reciept.model.dart';
import 'package:hive_flutter/hive_flutter.dart';

final class LocalDataBase {
  //* This constructor body for creating singleton widget
  factory LocalDataBase() {
    _dataBase == null ? {_dataBase = LocalDataBase._internel()} : {};
    return _dataBase!;
  }

  //* This named constructor for create object for this class
  LocalDataBase._internel();

  //* This variable for store this class object globally
  static LocalDataBase? _dataBase;

  late final Box<List> _storedBills;
  late final Box<int> _storedTheme;

  //* open box
  Future<void> openBox() async {
    _storedBills = await Hive.openBox<List>('bills');
    _storedTheme = await Hive.openBox('color');
  }

  //*retrive from db
  Future<List<List>> retriveProducts() async {
    return _storedBills.values.toList();
  }

  Future<int> retriveColor() async {
    try {
      return _storedTheme.values.first;
    } catch (e) {
      await _storedTheme.add(0);
      return 0;
    }
  }

  //*store to db
  Future<bool> storeProducts(List<RecieptProduct> products) async {
    try {
      await _storedBills.add(products);
      return true;
    } catch (e) {
      return false;
    }
  }

  //*update to db
  Future<bool> updateProducts(List<RecieptProduct> products, int index) async {
    try {
      await _storedBills.putAt(index, products);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateColor(int color) async {
    try {
      await _storedTheme.putAt(0, color);
      return true;
    } catch (e) {
      return false;
    }
  }

  //*remove products from db
  Future<bool> removeProducts(int index) async {
    try {
      await _storedBills.deleteAt(index);
      return true;
    } catch (e) {
      return false;
    }
  }
}
