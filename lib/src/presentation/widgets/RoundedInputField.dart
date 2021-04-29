import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final Color iconColor;
  final bool obscureText;
  final String Function(String) validator;
  final TextInputType textInputType;
  const RoundedInputField(
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      @required this.iconColor,
        this.textInputType=TextInputType.text,
      this.validator = defaultValidator,
      this.obscureText = false})
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
            hintStyle: Theme.of(context).textTheme.bodyText1.apply(),
            // errorStyle: Theme.of(context).textTheme.bodyText1.apply(),
            border: InputBorder.none,
          ),
          obscureText: obscureText,
          onEditingComplete: () {
            node.nextFocus();
          }),
    );
  }
}