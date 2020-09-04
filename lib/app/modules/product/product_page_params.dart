/*
 * product_page_params.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/wallet
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Class of parameters following the standards: https://pub.dev/packages/flutter_modular
*/

import 'package:siclos/app/shared/models/product_model.dart';

class ProductPageParams {
  final ProductModel productModel;
  final bool isCart;

  /*
  * @method              : constructor
  * @param[productModel] : model of Product to show detail page
  * @param[isCart]       : if the navigation came from the cart
 */
  ProductPageParams({this.productModel, this.isCart});
}
