import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/modules/wallet/wallet_controller.dart';

class CircleDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(color: Theme.of(context).primaryTextTheme.headline6.color, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.power_settings_new,
                        ),
                        onPressed: () {},
                      )),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.green[100],
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    title: Text(
                      'João Borges',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      'joao.borges@lut22.org.br',
                      style: TextStyle(fontSize: 15.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 60.0),
                  ListTile(
                    title: Text(
                      'Resetar arteira',
                      textScaleFactor: 1.3,
                    ),
                    trailing: Icon(Icons.restore),
                    onTap: () {
                      final WalletController _walletController = Modular.get<WalletController>();
                      _walletController.reset();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 40, 0);
    path.quadraticBezierTo(size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4), size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
