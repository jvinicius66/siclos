/*
 * product_module.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/product
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Module of product
*/

import 'product_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'product_page.dart';

class ProductModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $ProductController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => ProductPage(params: args.data)),
      ];

  static Inject get to => Inject<ProductModule>.of();
}
