import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:flutter/material.dart';

/// [DeleteChips] is a widget that displays chips that can be deleted.
class DeleteChips extends StatelessWidget {
  const DeleteChips(
      {super.key, required this.labels, required this.selectedLabel});

  /// [labels] is a list of text that is displayed on the chip.
  final List<String> labels;

  /// [selectedLabel] is the selected label index.
  final ValueNotifier<List<int>> selectedLabel;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setDeleteChipState) {
      return SizedBox(
          height: 100,
          child: SingleChildScrollView(
              child: Wrap(
            spacing: 6,
            children: [
              for (int i = 0; i < labels.length; i++) ...[
                InkWell(
                    onTap: () {
                      if (selectedLabel.value.contains(i)) {
                        setDeleteChipState(() {
                          selectedLabel.value.remove(i);
                        });

                        return;
                      }

                      setDeleteChipState(() {
                        selectedLabel.value.add(i);
                      });
                    },
                    overlayColor:
                        const WidgetStatePropertyAll(Colors.transparent),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: selectedLabel.value.contains(i)
                                  ? ColorSchemes.error
                                  : ColorSchemes.subtle),
                          color: selectedLabel.value.contains(i)
                              ? ColorSchemes.error.withOpacity(0.1)
                              : null,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(999))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Text(labels[i],
                          style: TextStyle(
                              fontSize: 14,
                              color: selectedLabel.value.contains(i)
                                  ? ColorSchemes.error
                                  : ColorSchemes.highlight)),
                    ))
              ]
            ],
          )));
    });
  }
}
