import 'package:flutter/material.dart';

/// [DeleteChip] is a widget that displays a chip that can be deleted.
class DeleteChip extends StatelessWidget {
  const DeleteChip({super.key, required this.label, required this.onTap});

  /// [label] is the text that is displayed on the chip.
  final String label;

  /// [onTap] is the callback that is called when the user tap the chip.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: () {
        onTap();
      },
      child: Chip(
        label: Text(label),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(999))),
        deleteIcon: const Icon(Icons.close),
      ),
    );
  }
}
