import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siclos/app/shared/models/product_model.dart';

import 'interfaces/cart_repository_interface.dart';

part 'cart_repository.g.dart';

@Injectable()
class CartRepository implements ICartRepository {
  @override
  Future<List<ProductModel>> fetchCart() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final response = _prefs.getString('cart');
    return response?.isNotEmpty != null ? ProductModel.fromJsonList(jsonDecode(response)) : [];
  }

  @override
  void dispose() {}

  @override
  Future<bool> save(List<ProductModel> list) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.setString('cart', jsonEncode(list));
  }
}
