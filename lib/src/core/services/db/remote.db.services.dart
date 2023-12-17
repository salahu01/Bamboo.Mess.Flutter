import 'package:freelance/src/core/models/category.model.dart';
import 'package:freelance/src/core/models/employee.model.dart';
import 'package:freelance/src/core/models/product.model.dart';
import 'package:freelance/src/core/models/reciept.model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDataBase {
  //* This constructor body for creating singleton widget
  factory MongoDataBase() {
    _dataBase == null ? {_dataBase = MongoDataBase._internel()} : {};
    return _dataBase!;
  }

  //* This named constructor for create object for this class
  MongoDataBase._internel();

  //* This variable for store this class object globally
  static MongoDataBase? _dataBase;

  //* collections
  DbCollection get _products => _db.collection('products');
  DbCollection get _categories => _db.collection('categories');
  DbCollection get _employees => _db.collection('employees');
  DbCollection get _reciepts => _db.collection('reciepts');

  //* Db url
  final _url = 'mongodb+srv://bamboomess:salahu37@cluster0.t4xnhwn.mongodb.net/bamboo_mess?retryWrites=true&w=majority';

  //* This variable for store MongoDB Instance
  late final Db _db;

  //* This methord create DB Instance
  Future<void> connectDb() async {
    _db = await Db.create(_url);
    await _db.open();
  }

  //* Find All
  Future<List<ProductModel>> get getProducts async {
    final products = await _products.find().map((e) => ProductModel.fromJson(e)).toList();
    final subProducts = products.where((_) => _.categaryName == null).toList();
    for (var i = 0; i < products.length; i++) {
      products[i] = products[i].update(subProducts);
    }
    return products;
  }

  Future<List<CategoryModel>> get getCategories => getProducts.then((v) => _categories.find().map((e) => CategoryModel.fromJson(e, products: v)).toList());
  Future<List<EmployeeModel>> get getEmployees => _employees.find().map((e) => EmployeeModel.fromJson(e)).toList();
  Future<List<RecieptModel>> get getReciepts => _reciepts.find().map((e) => RecieptModel.fromJson(e)).toList();

  //* Find One
  Future<ProductModel?>? get findOneProduct => _products.findOne().then((e) => e == null ? null : ProductModel.fromJson(e));
  Future<CategoryModel?>? get findOneCategorie => _categories.findOne().then((e) => e == null ? null : CategoryModel.fromJson(e));
  Future<EmployeeModel?>? get findOneEmployee => _employees.findOne().then((e) => e == null ? null : EmployeeModel.fromJson(e));
  Future<RecieptModel?>? get findOneReciept => _reciepts.findOne().then((e) => e == null ? null : RecieptModel.fromJson(e));

  //* Insert One
  Future<ProductModel> insertProduct(ProductModel v, List<String?>? ids) =>
      _products.insertOne(v.toJson()).then((e) => ProductModel.fromJson(e.document ?? {})).then((_) => updateCategory(_, ids).then((c) => _));
  Future<ProductModel> insertSubProduct(ProductModel v, String selectedId, List<String?>? ids) =>
      _products.insertOne(v.toJson()).then((e) => ProductModel.fromJson(e.document ?? {})).then((_) => updateProduct(_, selectedId, ids).then((c) => _));
  Future<CategoryModel> insertCategory(CategoryModel v) => _categories.insertOne(v.toJson()).then((e) => CategoryModel.fromJson(e.document ?? {}));
  Future<EmployeeModel> insertEmployee(EmployeeModel v) => _employees.insertOne(v.toJson()).then((e) => EmployeeModel.fromJson(e.document ?? {}));
  Future<RecieptModel> insertReciept(RecieptModel v) => _reciepts.insertOne(v.toJson()).then((e) => RecieptModel.fromJson(e.document ?? {}));

  //* Update One
  Future<bool> updateCategory(ProductModel productModel, List<String?>? ids) =>
      _categories.updateOne(where.eq('categary_name', productModel.categaryName), modify.set('products', [...(ids ?? []), productModel.id])).then((e) => e.isSuccess);
  Future<bool> updateProduct(ProductModel productModel, String? selectedId, List<String?>? ids) =>
      _products.updateOne(where.eq('_id', ObjectId.fromHexString(selectedId ?? '')), modify.set('products', [...(ids ?? []), productModel.id])).then((e) => e.isSuccess);

  //* Delete All
  Future<bool> deleteProducts(List<String> ids, String categaryName, List<String?> allIds) {
    return _products.deleteMany({
      '_id': {'\$in': ids.map((e) => ObjectId.fromHexString(e)).toList()},
    }).then((e) {
      if (e.isSuccess) {
        for (var e in ids) {
          allIds.remove(e);
        }
        return _categories.updateOne(where.eq('categary_name', categaryName), modify.set('products', [...allIds])).then((e) => e.isSuccess);
      }
      return false;
    });
  }

  Future<bool> deleteSubCategoryProducts(List<String> ids, String? subCategoryId, List<String?> allIds) {
    return _products.deleteMany({
      '_id': {'\$in': ids.map((e) => ObjectId.fromHexString(e)).toList()},
    }).then((e) {
      if (e.isSuccess) {
        for (var e in ids) {
          allIds.remove(e);
        }
        return _products.updateOne(where.eq('_id', ObjectId.fromHexString(subCategoryId ?? '')), modify.set('products', [...allIds])).then((e) => e.isSuccess);
      }
      return false;
    });
  }

  //* Delete One
  Future<bool> deleteOneCategory(CategoryModel model) {
    return _products.deleteMany({
      '_id': {'\$in': model.productIds?.map((e) => ObjectId.fromHexString(e ?? '')).toList()}
    }).then((e) {
      if (e.isSuccess) return _categories.deleteMany({'_id': ObjectId.fromHexString(model.id ?? '')}).then((e) => e.isSuccess);
      return false;
    });
  }

  Future<bool> deleteOneSubCategory(ProductModel model, CategoryModel v) {
    return _products.deleteMany({
      '_id': {'\$in': model.productIds?.map((e) => ObjectId.fromHexString(e ?? '')).toList()}
    }).then((e) {
      if (e.isSuccess) {
        return _products.deleteMany({'_id': ObjectId.fromHexString(model.id ?? '')}).then((e) {
          if (e.isSuccess) {
            v.productIds?.remove(model.id);
            return _categories.updateOne(where.eq('_id', ObjectId.fromHexString(v.id ?? '')), modify.set('products', [...?v.productIds])).then((e) => e.isSuccess);
          }
          return false;
        });
      }
      return false;
    });
  }

  Future<bool> deleteOneEmployee(EmployeeModel model) {
    return _employees.deleteOne({'_id': ObjectId.fromHexString(model.id ?? '')}).then((e) => e.isSuccess);
  }

  Future<bool> deleteOneReciept(RecieptModel model) {
    return _reciepts.deleteOne({'_id': ObjectId.fromHexString(model.id ?? '')}).then((e) => e.isSuccess);
  }
}
