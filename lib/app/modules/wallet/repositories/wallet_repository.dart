/*
 * wallet_repository.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/wallet/repository
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Repository descendent of the interface with access via SharedPreferences
*/

import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interfaces/wallet_repository_interface.dart';

part 'wallet_repository.g.dart';

@Injectable()
class WalletRepository implements IWalletRepository {
  /*
  * @method      : fetchWallet
  * @description : Load wallet data in storage
  * @result      : balance value
  */
  @override
  Future<double> fetchWallet() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final response = _prefs.getDouble('wallet');
    return response;
  }

  @override
  void dispose() {}

  /*
  * @method         : save
  * @description    : Save wallet data in storage
  * @param[balance] : Value for persistence
  * @result         : bool success
  */
  @override
  Future<bool> save(double balance) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.setDouble('wallet', balance);
  }
}
