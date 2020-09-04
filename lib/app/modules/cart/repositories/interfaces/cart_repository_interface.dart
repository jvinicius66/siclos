/*
 * cart_repository_interface.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/cart/repositories/interfaces
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Contract of fetch data
*/

import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/shared/models/product_model.dart';

abstract class ICartRepository implements Disposable {
  /*
  * @method      : fetchCart
  * @description : Fetch all products in data persistence
  * @result      : List of ProductModel
  */
  Future<List<ProductModel>> fetchCart();
  /*
  * @method      : save
  * @description : Save list og ProductModel in data persistence
  * @param[list] : List of ProductModel
  * @result      : bool if success
  */
  Future<bool> save(List<ProductModel> list);
}
