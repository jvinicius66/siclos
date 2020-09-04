import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interfaces/wallet_repository_interface.dart';

part 'wallet_repository.g.dart';

@Injectable()
class WalletRepository implements IWalletRepository {
  @override
  Future<double> fetchWallet() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final response = _prefs.getDouble('wallet');
    return response;
  }

  @override
  void dispose() {}

  @override
  Future<bool> save(double balance) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.setDouble('wallet', balance);
  }
}
