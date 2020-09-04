/*
 * cart_repository.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/cart/repositories
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Repository of Cart with data source in SharedPreferences
*/

import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siclos/app/shared/models/product_model.dart';

import 'interfaces/cart_repository_interface.dart';

part 'cart_repository.g.dart';

@Injectable()
class CartRepository implements ICartRepository {
  /*
  * @method      : fetchCart
  * @description : Fetch all products in data persistence with json format
  * @result      : List of ProductModel
  */
  @override
  Future<List<ProductModel>> fetchCart() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final response = _prefs.getString('cart');
    return response?.isNotEmpty != null ? ProductModel.fromJsonList(jsonDecode(response)) : [];
  }

  @override
  void dispose() {}

  /*
  * @method      : save
  * @description : Save list og ProductModel in data persistence with json format
  * @param[list] : List of ProductModel
  * @result      : bool if success
  */
  @override
  Future<bool> save(List<ProductModel> list) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.setString('cart', jsonEncode(list));
  }
}
