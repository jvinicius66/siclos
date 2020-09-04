/*
 * wellet_controller.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/wallet
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Controller of Wallet
*/

import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'repositories/interfaces/wallet_repository_interface.dart';

part 'wallet_controller.g.dart';

@Injectable()
class WalletController = _WalletControllerBase with _$WalletController;

abstract class _WalletControllerBase with Store {
  /*
  * @constant    : INITIAL_BALANCE
  * @description : Initial value of wallet
  */
  static const INITIAL_BALANCE = 200.0;
  /*
  * @variable    : repository
  * @description : Repository of fetch data
  */
  final IWalletRepository repository;

  /*
  * @method            : constructor
  * @param[repository] : Initial fetch data
  */
  _WalletControllerBase(this.repository) {
    fetchBalance();
  }

  /*
  * @variable    : balance
  * @description : Data of balance
  */
  @observable
  double balance = 0;

  /*
  * @method      : fetchBalance
  * @description : Load data from repository of set initial value if not exists
  * @result      : balance value
  */
  @action
  Future<double> fetchBalance() async => balance = await repository.fetchWallet() ?? INITIAL_BALANCE;

  /*
  * @method      : purchase
  * @description : Reduce value and Write balance in storage
  * @param[value]: Purchase amount to write off the balance
  * @result      : bool success
  */
  @action
  Future<bool> purchase(double value) async {
    balance -= value;
    return await repository.save(balance);
  }

  /*
  * @method      : reset
  * @description : Reset valou of balance to initial
  * @result      : bool success
  */
  @action
  Future<bool> reset() async {
    balance = INITIAL_BALANCE;
    return await repository.save(balance);
  }
}
