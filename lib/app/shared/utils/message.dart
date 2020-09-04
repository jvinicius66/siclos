import 'package:flutter/material.dart';

class Message {
  static void snak(GlobalKey<ScaffoldState> keyScaffold, String message) {
    keyScaffold.currentState.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: Theme.of(keyScaffold.currentContext).brightness == Brightness.dark
              ? Theme.of(keyScaffold.currentContext).accentColor
              : Theme.of(keyScaffold.currentContext).primaryTextTheme.headline6.color,
        ),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Theme.of(keyScaffold.currentContext).primaryColor.withOpacity(0.8),
    ));
  }

  static void dialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(text),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
