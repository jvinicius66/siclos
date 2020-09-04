/*
 * product_list_module.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/product_list
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Module of product_list
*/

import 'package:dio/dio.dart';
import 'package:siclos/app/modules/product_list/repositories/product_list_repository.dart';

import 'product_list_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'product_list_page.dart';

class ProductListModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $ProductListController,
        Bind((i) => ProductRepository(i.get<Dio>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, __) => ProductListPage()),
      ];

  static Inject get to => Inject<ProductListModule>.of();
}
