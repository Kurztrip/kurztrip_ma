import 'package:flutter/material.dart';

class RoundedDropdown extends StatelessWidget {
  final String value;
  final String hint;
  final Function(String) onChanged;
  final List<String> items;
  final IconData icon;
  final Color iconColor;

  const RoundedDropdown({Key key, this.value, this.hint, this.onChanged, this.items, this.icon=Icons.person, @required this.iconColor}) : super(key: key);
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
      child: DropdownButton(
        isExpanded: true,
        hint: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(icon,color: iconColor,),
            ),
            Text(
              hint,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        value:value,
        items: items
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(icon,color: iconColor,),
                ),
                Text(value),
              ],
            ),
          );
        }).toList(),
        underline: Container(),
        onChanged: onChanged,
      ),
    );
  }
}
