/*
 * wallet_repository_interface.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/wallet/repository/interface
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Contract of fetch data
*/

import 'package:flutter_modular/flutter_modular.dart';

abstract class IWalletRepository implements Disposable {
  /*
  * @method      : fetchWallet
  * @description : Load wallet data in storage
  * @result      : balance value
  */
  Future<double> fetchWallet();
  /*
  * @method         : save
  * @description    : Save wallet data in storage
  * @param[balance] : Value for persistence
  * @result         : bool success
  */
  Future<bool> save(double balance);
}
