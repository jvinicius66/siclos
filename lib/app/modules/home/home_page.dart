/*
 * home_page.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/home
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Main page of the app with tab bottons
*/

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/modules/cart/cart_controller.dart';
import 'package:siclos/app/modules/cart/cart_module.dart';
import 'package:siclos/app/modules/product_list/product_list_module.dart';
import 'package:siclos/app/modules/wallet/wallet_module.dart';
import 'package:siclos/app/shared/widgets/drawer.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  /*
  * @variable    : _scaffoldKey
  * @description : Manipulation GlobalKey of Scaffold
  */
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  /*
  * @variable    : _cart
  * @description : Cart Controller to show counter in badge
  */
  CartController _cart = Modular.get<CartController>();

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

  /*
  * @method      : _buildAppBar
  * @description : Buil main app bar
  */
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

  /*
  * @method      : _buildBody
  * @description : Build main structure with three pages
  */
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

  /*
  * @method      : _buildBottom
  * @description : Build bottom tabs os navigation
  */
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

  /*
  * @method      : _onBackPressed
  * @description : Capture back button pressed to exit app
  * @result      : True if click twice back button
  * @inspired on : https://stackoverflow.com/questions/53496161/how-to-write-a-double-back-button-pressed-to-exit-app-using-flutter
  */
  DateTime _currentBackPressTime;
  Future<bool> _onBackPressed() {
    if (_scaffoldKey.currentState.isDrawerOpen) {
      Navigator.pop(context);
      return Future.value(false);
    }
    DateTime now = DateTime.now();
    if ((_currentBackPressTime == null) || now.difference(_currentBackPressTime) > Duration(seconds: 3)) {
      _currentBackPressTime = now;
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        content: Text(
          'Pressone novamente para sair',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(_scaffoldKey.currentContext).brightness == Brightness.dark
                ? Theme.of(_scaffoldKey.currentContext).accentColor
                : Theme.of(_scaffoldKey.currentContext).primaryTextTheme.headline6.color,
          ),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Theme.of(_scaffoldKey.currentContext).primaryColor.withOpacity(0.8),
      ));
      return Future.value(false);
    }
    return Future.value(true);
  }
}
