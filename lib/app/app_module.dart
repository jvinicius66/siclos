/*
 * app_module.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Primary app module
*/
import 'package:dio/dio.dart';
import 'package:siclos/app/modules/cart/cart_controller.dart';
import 'package:siclos/app/modules/cart/cart_module.dart';
import 'package:siclos/app/modules/cart/repositories/cart_repository.dart';
import 'package:siclos/app/modules/wallet/wallet_module.dart';
import 'package:siclos/app/shared/constants.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:siclos/app/app_widget.dart';

import 'modules/home/home_module.dart';
import 'modules/product/product_module.dart';
import 'modules/product_list/product_list_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $AppController,
        Bind((i) => Dio(BaseOptions(baseUrl: BASE_URL))),
        Bind((i) => CartRepository()),
        Bind((i) => CartController(i.get<CartRepository>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: HomeModule()),
        ModularRouter('/productList', module: ProductListModule()),
        ModularRouter(
          '/product',
          module: ProductModule(),
          transition: TransitionType.rightToLeft,
        ),
        ModularRouter('/cart', module: CartModule()),
        ModularRouter('/wallet', module: WalletModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
