import 'package:flutter/material.dart';

class RoundedDropdown extends StatelessWidget {
  final String? value;
  final String? hint;
  final Function(String?)? onChanged;
  final Map<String, IconData>? items;
  final IconData icon;
  final Color iconColor;

  const RoundedDropdown(
      {Key? key,
      this.value,
      this.hint,
      this.onChanged,
      this.items,
      this.icon = Icons.person,
      required this.iconColor})
      : super(key: key);
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
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          decoration: InputDecoration(
              enabledBorder: InputBorder.none, errorBorder: InputBorder.none),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (dynamic value) => value == null ? 'Seleccione una opción' : null,
          isExpanded: true,
          hint: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              Text(
                hint!,
                style: Theme.of(context).textTheme.bodyText1!.apply(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withAlpha(180)),
              ),
            ],
          ),
          value: value,
          items: items!.entries.map<DropdownMenuItem<String>>((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(
                      entry.value == null ? Icons.person : entry.value,
                      color: iconColor,
                    ),
                  ),
                  Text(entry.key),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
