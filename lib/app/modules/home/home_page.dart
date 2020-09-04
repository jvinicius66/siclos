import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/modules/cart/cart_controller.dart';
import 'package:siclos/app/modules/cart/cart_module.dart';
import 'package:siclos/app/modules/product_list/product_list_module.dart';
import 'package:siclos/app/modules/wallet/wallet_module.dart';
import 'package:siclos/app/shared/utils/message.dart';
import 'package:siclos/app/shared/widgets/drawer.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  CartController _cart = Modular.get<CartController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(),
        body: _buildBody(),
        bottomNavigationBar: _buildBottom(),
        drawer: CircleDrawer(),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/icon.png',
            width: 30,
            height: 30,
          ),
          SizedBox(width: 5),
          Text(
            'Siclos',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.green,
        ),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
      actions: [
        IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.green,
            ),
            onPressed: () {}),
        IconButton(icon: Icon(Icons.shopping_cart_outlined, color: Colors.green), onPressed: () {}),
      ],
    );
  }

  Widget _buildBody() {
    return PageView(
      controller: controller.pageViewConroller,
      children: [
        RouterOutlet(module: ProductListModule()),
        RouterOutlet(module: WalletModule()),
        RouterOutlet(module: CartModule()),
      ],
    );
  }

  Widget _buildBottom() {
    return AnimatedBuilder(
      animation: controller.pageViewConroller,
      builder: (context, snapshot) {
        return BottomNavigationBar(
          onTap: (index) => controller.pageViewConroller.animateToPage(
            index,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          ),
          currentIndex: controller.pageViewConroller?.page?.round() ?? 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_outlined),
              label: 'Carteira',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Icon(Icons.shopping_cart_outlined),
                  Observer(builder: (_) {
                    int _totalCart = _cart.cart?.length ?? 0;
                    return Positioned(
                      right: 0,
                      child: Visibility(
                        visible: _totalCart != 0,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            _totalCart.toString() ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              label: 'Carrinho',
            ),
          ],
        );
      },
    );
  }

  DateTime _currentBackPressTime;
  Future<bool> _onBackPressed() {
    if (_scaffoldKey.currentState.isDrawerOpen) {
      Navigator.pop(context);
      return Future.value(false);
    }
    DateTime now = DateTime.now();
    if ((_currentBackPressTime == null) || now.difference(_currentBackPressTime) > Duration(seconds: 3)) {
      _currentBackPressTime = now;
      Message.snak(_scaffoldKey, 'Pressone novamente para sair');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
