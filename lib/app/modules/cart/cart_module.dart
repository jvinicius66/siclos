/*
 * cart_module.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/cart
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Module of Cart
*/

import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/modules/cart/cart_controller.dart';
import 'package:siclos/app/modules/wallet/repositories/wallet_repository.dart';
import 'package:siclos/app/modules/wallet/wallet_controller.dart';

import 'cart_page.dart';

class CartModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $CartController,
        $WalletController,
        Bind((i) => WalletRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => CartPage()),
      ];

  static Inject get to => Inject<CartModule>.of();
}
