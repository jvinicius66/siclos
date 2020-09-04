import 'package:flutter_modular/flutter_modular.dart';

abstract class IWalletRepository implements Disposable {
  Future<double> fetchWallet();
  Future<bool> save(double balance);
}
