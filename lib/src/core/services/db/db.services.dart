import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/category.model.dart';
import 'package:freelance/src/core/models/employee.model.dart';
import 'package:freelance/src/core/models/product.model.dart';
import 'package:freelance/src/core/models/reciept.model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DataBase {
  //* This constructor body for creating singleton widget
  factory DataBase() {
    _dataBase == null ? {_dataBase = DataBase._internel()} : {};
    return _dataBase!;
  }

  //* This named constructor for create object for this class
  DataBase._internel();

  //* This variable for store this class object globally
  static DataBase? _dataBase;

  //* collections
  DbCollection get _products => _db.collection('products');
  DbCollection get _categories => _db.collection('categories');
  DbCollection get _employees => _db.collection('employees');
  DbCollection get _reciepts => _db.collection('reciepts');

  //* Db url
  final _url = 'mongodb+srv://swalahu:salahu37@crocs.2mrp72j.mongodb.net/bamboo_mess?retryWrites=true&w=majority';

  //* This variable for store MongoDB Instance
  late final Db _db;

  //* This methord create DB Instance
  Future<void> connectDb() async {
    _db = await Db.create(_url);
    await _db.open();
  }

  //* Find All
  Future<List<ProductModel>> get getProducts => _products.find().map((e) => ProductModel.fromJson(e)).toList();
  Future<List<CategoryModel>> get getCategories => getProducts.then((v) => _categories.find().map((e) => CategoryModel.fromJson(e, products: v)).toList());

  Future<List<EmployeeModel>> get getEmployees => _employees.find().map((e) => EmployeeModel.fromJson(e)).toList();
  Future<List<RecieptModel>> get getReciepts => _reciepts.find().map((e) => RecieptModel.fromJson(e)).toList();

  //* Find One
  Future<ProductModel?>? get findOneProduct => _products.findOne().then((e) => e == null ? null : ProductModel.fromJson(e));
  Future<CategoryModel?>? get findOneCategorie => _categories.findOne().then((e) => e == null ? null : CategoryModel.fromJson(e));
  Future<EmployeeModel?>? get findOneEmployee => _employees.findOne().then((e) => e == null ? null : EmployeeModel.fromJson(e));
  Future<RecieptModel?>? get findOneReciept => _reciepts.findOne().then((e) => e == null ? null : RecieptModel.fromJson(e));

  //* Insert One
  Future<ProductModel> insertProduct(ProductModel v) async => _categories.insert(v.toJson()).then((e) => ProductModel.fromJson(e));
  Future<CategoryModel> insertCategory(CategoryModel v) async => _categories.insert(v.toJson()).then((e) => CategoryModel.fromJson(e));
  Future<EmployeeModel> insertEmployee(EmployeeModel v) async => _categories.insert(v.toJson()).then((e) => EmployeeModel.fromJson(e));
  Future<RecieptModel> insertReciept(RecieptModel v) async => _categories.insert(v.toJson()).then((e) => RecieptModel.fromJson(e));

  //* Insert All
}
