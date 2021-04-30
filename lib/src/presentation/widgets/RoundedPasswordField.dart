import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final Color iconColor;
  final String Function(String) validator;

  RoundedPasswordField({
    Key key,
    this.hintText,
    this.onChanged,
    @required this.iconColor,
    this.validator = defaultValidator,
  }) : super(key: key);

  static String defaultValidator(value) =>
      value == null || value.isEmpty ? 'Este campo es obligatorio' : null;

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool obscureText = true;
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
          keyboardType: TextInputType.visiblePassword,
          onChanged: widget.onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: widget.iconColor,
          validator: widget.validator,
          decoration: InputDecoration(
              icon: Icon(
                Icons.lock,
                color: widget.iconColor,
              ),
              hintText: "Contraseña",
              hintStyle: Theme.of(context).textTheme.bodyText1.apply(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withAlpha(180)),
              errorStyle: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .apply(color: Theme.of(context).colorScheme.error),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: widget.iconColor.withAlpha(125),
                ),
                onPressed: () => setState(() => obscureText = !obscureText),
              )),
          obscureText: obscureText,
          onEditingComplete: () {
            node.nextFocus();
          }),
    );
  }
}
