/*
 * wallet_page.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/wallet
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Wallet Page where it shows the balance and loans
*/

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'wallet_controller.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends ModularState<WalletPage, WalletController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildBalance(),
          _eventTitle(),
          _eventList(),
        ],
      ),
    );
  }

  /*
  * @method      : _buildBalance
  * @description : Build the balance widget
  */
  Container _buildBalance() {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 0, style: BorderStyle.solid),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [BoxShadow(color: Color.fromRGBO(112, 112, 112, 0.19), offset: Offset(0, 3), blurRadius: 6, spreadRadius: 1)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.monetization_on,
                    size: 40,
                    color: Colors.green,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'SALDO',
                    style: TextStyle(color: Colors.black45, fontSize: 24),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '\$',
                        style: TextStyle(fontFamily: "vistolsans", fontSize: 25),
                      ),
                      SizedBox(width: 13),
                      Observer(builder: (_) {
                        return Text(
                          controller.balance >= 0 ? controller.balance.toStringAsFixed(2) : '0.00',
                          style: TextStyle(fontFamily: "sfprotext", fontSize: 45),
                        );
                      }),
                      SizedBox(width: 13),
                    ],
                  ),
                  Text(
                    'Disponível',
                    style: TextStyle(
                      fontFamily: "worksans",
                      color: Color.fromRGBO(157, 157, 157, 1),
                      fontSize: 17,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  /*
  * @method      : _eventTitle
  * @description : Build the event title widget
  */
  Widget _eventTitle() {
    return Observer(builder: (_) {
      if (controller.balance >= 0) return Center();
      return Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Color.fromRGBO(112, 112, 112, 0.19)))),
        margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 5),
        padding: EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Lançamentos',
              style: TextStyle(fontFamily: "worksans", fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'VER TODOS',
                  style: TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w400, fontSize: 10, color: Color.fromRGBO(157, 157, 157, 1)),
                ),
                Icon(Icons.chevron_right, color: Color.fromRGBO(0, 0, 0, 0.5)),
              ],
            ),
          ],
        ),
      );
    });
  }

  /*
  * @method      : _eventList
  * @description : Build the event list widget
  */
  Widget _eventList() {
    return Observer(builder: (_) {
      if (controller.balance >= 0) return Center();
      return ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.all(15),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 15),
            decoration: _tileDecoration(),
            child: ListTile(
              leading: Icon(Icons.payment_outlined),
              title: Text(
                'Empréstimo',
                style: TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w500, color: Colors.black),
              ),
              subtitle: Text(
                '4 de setembro de 2020',
                style: TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w300),
              ),
              trailing: Text(
                '\$ ${(controller.balance * -1).toStringAsFixed(2)}',
                style: TextStyle(fontFamily: "worksans"),
              ),
            ),
          ),
        ],
      );
    });
  }

  /*
  * @method      : _tileDecoration
  * @description : Build the tile decoration used in _eventList
  */
  BoxDecoration _tileDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.white, width: 0, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
      boxShadow: [BoxShadow(color: Color.fromRGBO(112, 112, 112, 0.19), offset: Offset(0, 0), blurRadius: 3, spreadRadius: 1)],
    );
  }
}
