/*
 * product_list_repository.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/product_list/repositories
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Repository of the internet API
*/

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/shared/constants.dart';
import 'package:siclos/app/shared/models/product_model.dart';

import 'interfaces/product_list_repository_interface.dart';

part 'product_repository.g.dart';

@Injectable()
class ProductRepository implements IProductRepository {
  final Dio client;

  /*
  * @method     : constructor
  * @param[Dio] : Package of calls https
  */
  ProductRepository(this.client);

  /*
  * @method      : fetchProducts
  * @description :  Fetch data in storage
  * @result      : List of ProductModel
  */
  Future<List<ProductModel>> fetchProducts() async {
    final response = await client.get(PRODUCT_URL);
    return ProductModel.fromJsonList((response.data as List));
  }

  @override
  void dispose() {}
}
