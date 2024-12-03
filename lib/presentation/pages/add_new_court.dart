import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/presentation/validators/add_new_court_form_validator.dart';
import 'package:courtly_vendor/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly_vendor/presentation/widgets/primary_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// [AddNewCourtPage] is a StatefulWidget that displays the Add New Court Page.
/// This page is used to add a new court to the vendor's list of courts.
/// This page will be dispalyed only once for every court type.
class AddNewCourtPage extends StatefulWidget {
  const AddNewCourtPage({super.key});

  @override
  State<AddNewCourtPage> createState() => _AddNewCourtPage();
}

class _AddNewCourtPage extends State<AddNewCourtPage> {
  /// [_addNewCourtFormValidator] is an instance of [AddNewCourtFormValidator].
  final AddNewCourtFormValidator _addNewCourtFormValidator =
      AddNewCourtFormValidator();

  /// [_textInputControllers] is a Map of TextEditingControllers that are used to
  final Map<String, TextEditingController> _textInputControllers = {
    "pricePerHour": TextEditingController(),
  };

  /// [_errorTexts] is a Map of error texts that are used to display error messages
  final Map<String, String?> _errorTexts = {
    "pricePerHour": null,
    "courtsImage": null,
  };

  /// [_courtsImage] is a FilePickerResult that stores the image of the court.
  FilePickerResult? _courtsImage;

  /// [_pickImage] is a Future function that picks an image from the device.
  ///
  /// Returns [Future] of [FilePickerResult]
  Future<FilePickerResult?> _pickImage() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
  }

  /// [_validateAddNewCourtForm] is a function that validates the Add New Court Form.
  ///
  /// Returns [bool]
  bool _validateAddNewCourtForm() {
    // Validate the price per hour and courts image
    setState(() {
      _errorTexts["pricePerHour"] =
          _addNewCourtFormValidator.validatePricePerHour(
              price: _textInputControllers["pricePerHour"]!.text);

      _errorTexts["courtsImage"] =
          _addNewCourtFormValidator.validateCourtsImage(image: _courtsImage);
    });

    return _errorTexts["pricePerHour"] == null &&
        _errorTexts["courtsImage"] == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackableCenteredAppBar(title: "New Court"),
      backgroundColor: ColorSchemes.primaryBackground,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(
            left: PAGE_PADDING_MOBILE,
            right: PAGE_PADDING_MOBILE,
            top: PAGE_PADDING_MOBILE * 2),
        child: Column(
          children: [
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Price / Hour",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorSchemes.text)),
                    const SizedBox(height: 8),
                    TextFormField(
                        controller: _textInputControllers["pricePerHour"],
                        style: const TextStyle(fontSize: 14),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          label: const Text("Rp 20000"),
                          prefixText: "Rp ",
                          prefixStyle:
                              TextStyle(fontSize: 14, color: ColorSchemes.text),
                          errorText: _errorTexts["pricePerHour"],
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Courts Image",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorSchemes.text)),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            _courtsImage = await _pickImage();
                          },
                          overlayColor:
                              const WidgetStatePropertyAll(Colors.transparent),
                          child: Container(
                            width: double.maxFinite,
                            height: 186,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: (_errorTexts["courtsImage"] != null)
                                        ? ColorSchemes.error
                                        : ColorSchemes.subtle,
                                    width: 1)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  HeroIcon(
                                    HeroIcons.photo,
                                    color: ColorSchemes.highlight,
                                    size: 32,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Tap to Upload Image",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: ColorSchemes.highlight),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (_errorTexts["courtsImage"] != null)
                          Padding(
                              padding: const EdgeInsets.only(top: 4, left: 16),
                              child: Text(_errorTexts["courtsImage"]!,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: ColorSchemes.error))),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 60),
                PrimaryButton(
                    onPressed: () {
                      // Validate the form
                      if (!_validateAddNewCourtForm()) {
                        return;
                      }

                      // Back to the previous page
                      Navigator.pop(context);
                    },
                    style: const ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(Size.fromHeight(0)),
                    ),
                    child: Text("Create",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorSchemes.primaryBackground))),
              ],
            ))
          ],
        ),
      )),
    );
  }
}
