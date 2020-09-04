import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/modules/wallet/repositories/wallet_repository.dart';

part 'wallet_controller.g.dart';

@Injectable()
class WalletController = _WalletControllerBase with _$WalletController;

abstract class _WalletControllerBase with Store {
  static const INITIAL_BALANCE = 200.0;
  final WalletRepository repository;

  _WalletControllerBase(this.repository) {
    fetchBalance();
  }

  @observable
  double balance = 0;

  @action
  Future<double> fetchBalance() async => balance = await repository.fetchWallet() ?? INITIAL_BALANCE;

  @action
  Future<bool> purchase(double value) async {
    balance -= value;
    return await repository.save(balance);
  }

  @action
  Future<bool> reset() async {
    balance = INITIAL_BALANCE;
    return await repository.save(balance);
  }
}
