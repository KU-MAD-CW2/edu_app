import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String category;
  final bool selected;
  final GestureTapCallback onCategoryChanged;

  const CategoryChip(
    this.category,
    this.selected,
    this.onCategoryChanged, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCategoryChanged,
      child: !selected
          ? Chip(label: Text(category))
          : Chip(
              label: Text(category),
              backgroundColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              shape: StadiumBorder(
                side: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
    );
  }
}
