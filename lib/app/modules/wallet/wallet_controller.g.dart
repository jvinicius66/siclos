// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $WalletController = BindInject(
  (i) => WalletController(i<WalletRepository>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WalletController on _WalletControllerBase, Store {
  final _$balanceAtom = Atom(name: '_WalletControllerBase.balance');

  @override
  double get balance {
    _$balanceAtom.reportRead();
    return super.balance;
  }

  @override
  set balance(double value) {
    _$balanceAtom.reportWrite(value, super.balance, () {
      super.balance = value;
    });
  }

  final _$fetchBalanceAsyncAction =
      AsyncAction('_WalletControllerBase.fetchBalance');

  @override
  Future<double> fetchBalance() {
    return _$fetchBalanceAsyncAction.run(() => super.fetchBalance());
  }

  final _$purchaseAsyncAction = AsyncAction('_WalletControllerBase.purchase');

  @override
  Future<bool> purchase(double value) {
    return _$purchaseAsyncAction.run(() => super.purchase(value));
  }

  @override
  String toString() {
    return '''
balance: ${balance}
    ''';
  }
}
