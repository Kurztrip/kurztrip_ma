import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final Color iconColor;
  final Color textColor;
  final String Function(String) validator;
  final TextInputType textInputType;
  final String initialValue;
  const RoundedInputField(
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      @required this.iconColor,
      this.textInputType = TextInputType.text,
      this.validator = defaultValidator,
      this.textColor,
      this.initialValue})
      : super(key: key);
  static String defaultValidator(value) =>
      value == null || value.isEmpty ? 'Este campo es obligatorio' : null;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final node = FocusScope.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground.withAlpha(30),
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(
          keyboardType: textInputType,
          initialValue: initialValue,
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: iconColor,
          validator: validator,
          decoration: InputDecoration(
            icon: Icon(
              icon,
              color: iconColor,
            ),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyText1.apply(
                color:
                    Theme.of(context).colorScheme.onBackground.withAlpha(180)),
            errorStyle: Theme.of(context)
                .textTheme
                .bodyText2
                .apply(color: Theme.of(context).colorScheme.error),
            border: InputBorder.none,
          ),
          onEditingComplete: () {
            node.nextFocus();
          }),
    );
  }
}
