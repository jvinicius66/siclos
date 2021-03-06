/*
 * wallet_module.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/wallet
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Module of wallet
*/

import 'package:siclos/app/modules/wallet/repositories/wallet_repository.dart';

import 'wallet_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'wallet_page.dart';

class WalletModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $WalletController,
        Bind((i) => WalletRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => WalletPage()),
      ];

  static Inject get to => Inject<WalletModule>.of();
}
