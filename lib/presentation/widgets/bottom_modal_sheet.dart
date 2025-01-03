import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:flutter/material.dart';

/// [showBottomModalSheet] is a function that shows a bottom modal sheet.
/// This function is used to show a modal sheet at the bottom of the screen.
///
/// - Parameters:
///  - [context]: The [BuildContext] of the widget.
///  - [content]: The [Widget] content of the modal sheet.
///
/// Returns a [void].
void showBottomModalSheet(BuildContext context, Widget content) {
  showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.maxFinite,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: PAGE_PADDING_MOBILE,
                    right: PAGE_PADDING_MOBILE,
                    top: PAGE_PADDING_MOBILE,
                    bottom: PAGE_PADDING_MOBILE * 2),
                child: content,
              )
            ],
          ),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      useSafeArea: true);
}
