import 'package:ctrl_money/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class SelectInput extends StatefulWidget {
  final String selectedText;
  final Function onChanged;
  final List<DropdownMenuItem> items;

  const SelectInput({Key key, this.selectedText, this.onChanged, this.items}) : super(key: key);
  @override
  _SelectInputState createState() => _SelectInputState();
}

class _SelectInputState extends State<SelectInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: lighter,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black54)),
      child: DropdownButton(
        focusColor: blue,
        itemHeight: 50,
        hint: Padding(
          child: Text(widget.selectedText,style: TextStyle(color: secondaryText),),
          padding: EdgeInsets.only(left: 14),
        ),
        underline: Container(),
        isExpanded: true,
        onChanged:widget.onChanged,
        items: widget.items
      ),
    );
  }
}
