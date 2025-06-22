import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final String Function(T) itemToString;

  const CustomDropdown({
    Key? key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    required this.itemToString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(labelText: label),
        value: value,
        items: items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Text(itemToString(item)),
              ),
            )
            .toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
