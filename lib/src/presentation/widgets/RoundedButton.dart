import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  const RoundedButton({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.subtitle1,
        textAlign: TextAlign.center,
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
        backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.primaryVariant),
        elevation: MaterialStateProperty.all<double>(5.0),
        padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 60, vertical: 5)),
      ),
    );
  }
}
