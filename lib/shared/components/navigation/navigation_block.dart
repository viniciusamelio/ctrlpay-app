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
    return InkWell(
      onTap: widget.action ?? (){},
      highlightColor: blue,
      splashColor: blue,
      radius: 4,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: EdgeInsets.all(8),
        width: 80,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              widget.icon,
              SizedBox(height: 4),
              Text(widget.title ?? 'Title',
                  style: TextStyle(color: primaryText))
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: secondaryBlue, borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
