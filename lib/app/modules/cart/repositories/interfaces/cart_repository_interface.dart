import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/shared/models/product_model.dart';

abstract class ICartRepository implements Disposable {
  Future<List<ProductModel>> fetchCart();
  Future<bool> save(List<ProductModel> list);
}
