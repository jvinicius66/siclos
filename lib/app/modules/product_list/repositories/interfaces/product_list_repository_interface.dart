/*
 * product_controller.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/product_list/repositories/interfaces
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Contract of fetch data
*/

import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/shared/models/product_model.dart';

abstract class IProductRepository implements Disposable {
  /*
  * @method      : fetchProducts
  * @description : Fetch data in storage
  * @result      : List of ProductModel
  */
  Future<List<ProductModel>> fetchProducts();
}
