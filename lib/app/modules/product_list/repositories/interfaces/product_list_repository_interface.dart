import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/shared/models/product_model.dart';

abstract class IProductRepository implements Disposable {
  Future<List<ProductModel>> fetchProducts();
}
