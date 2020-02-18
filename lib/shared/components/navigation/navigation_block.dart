import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class NavigationBlock extends StatefulWidget {
  final Icon icon;
  final String title;
  final Function action;
  const NavigationBlock({Key key, this.icon, this.title, this.action})
      : super(key: key);
  @override
  _NavigationBlockState createState() => _NavigationBlockState();
}

class _NavigationBlockState extends State<NavigationBlock> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.action,
      child: Container(
        margin: EdgeInsets.all(8),
        width: 80,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Padding(padding: EdgeInsets.only(right: 2), child: widget.icon),
            SizedBox(height: 5),
             Text(widget.title ?? 'Title', style: TextStyle(color: primaryText))
          ],
        ),
        decoration: BoxDecoration(
            color: secondaryBlue, borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
