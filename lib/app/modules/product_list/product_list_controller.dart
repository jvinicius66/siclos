/*
 * product_list_controller.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/modules/product_list
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Controller of product_list
*/

import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/shared/models/product_model.dart';

import 'repositories/interfaces/product_list_repository_interface.dart';

part 'product_list_controller.g.dart';

@Injectable()
class ProductListController = _ProductListControllerBase with _$ProductListController;

abstract class _ProductListControllerBase with Store {
  /*
  * @variable    : repository
  * @description : repository of fetch data
  */
  final IProductRepository repository;

  /*
  * @method            : constructor
  * @description       : Initial fetching data
  * @param[repository] : repository of fetch data
  */
  _ProductListControllerBase(this.repository) {
    fetchProducts();
  }

  /*
  * @variable    : products
  * @description : Instance of list of Product Model 
  * @result      : Lsit of products
  */
  @observable
  ObservableFuture<List<ProductModel>> products;

  /*
  * @method      : fetchProducts
  * @description : Fetch data in storage
  * @result      : Lsit of products
  */
  @action
  fetchProducts() => products = repository.fetchProducts().asObservable();
}
