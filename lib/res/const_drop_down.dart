import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String hintText;
  final ValueChanged<T?> onChanged;
  final bool isRequired;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.hintText,
    required this.onChanged,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButtonFormField<T>(
        value: selectedItem,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        isExpanded: true,
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
        onChanged: onChanged,
        validator: isRequired
            ? (value) => value == null ? 'Please select $hintText' : null
            : null,
      ),
    );
  }
}
