import 'package:crono/widget/game.dart';
import 'package:flutter/material.dart';

class GameContainer extends StatefulWidget {
  GameContainer({Key key, this.color}) : super(key: key);
  int color;
  @override
  _GameContainerState createState() => _GameContainerState();
}

class _GameContainerState extends State<GameContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: color[widget.color],
        ),
      ),
    );
  }
}
