import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final Color iconColor;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    @required this.iconColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground.withAlpha(30),
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
      onChanged: onChanged,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: iconColor,
        ),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyText1,
        border: InputBorder.none,
      ),
    ),
    );

  }
}

