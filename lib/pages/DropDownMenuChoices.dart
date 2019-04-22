
import 'package:flutter/material.dart';


class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Dashboard', icon: Icons.dashboard),
  const Choice(title: 'Manage Business', icon: Icons.business),

];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle _dropDownMenuTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
    );

    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: _dropDownMenuTextStyle.color),
            Text(choice.title, style: _dropDownMenuTextStyle),
          ],
        ),
      ),
    );
  }
}


