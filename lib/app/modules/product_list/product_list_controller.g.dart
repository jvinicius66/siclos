// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ProductListController = BindInject(
  (i) => ProductListController(i<ProductRepository>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductListController on _ProductListControllerBase, Store {
  final _$productsAtom = Atom(name: '_ProductListControllerBase.products');

  @override
  ObservableFuture<List<ProductModel>> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableFuture<List<ProductModel>> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  final _$_ProductListControllerBaseActionController =
      ActionController(name: '_ProductListControllerBase');

  @override
  dynamic fetchProducts() {
    final _$actionInfo = _$_ProductListControllerBaseActionController
        .startAction(name: '_ProductListControllerBase.fetchProducts');
    try {
      return super.fetchProducts();
    } finally {
      _$_ProductListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products}
    ''';
  }
}
