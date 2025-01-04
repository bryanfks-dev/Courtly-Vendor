import 'dart:io';

import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/presentation/blocs/create_new_court_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/states/create_new_court_state.dart';
import 'package:courtly_vendor/presentation/pages/my_court_detail.dart';
import 'package:courtly_vendor/presentation/validators/create_new_court_form_validator.dart';
import 'package:courtly_vendor/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly_vendor/presentation/widgets/loading_screen.dart';
import 'package:courtly_vendor/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';

/// [CreateNewCourtPage] is a StatefulWidget that displays the
///  Create New Court Page.
class CreateNewCourtPage extends StatefulWidget {
  const CreateNewCourtPage({super.key, required this.courtType});

  /// [courtType] is a String that stores the type of the court.
  final String courtType;

  @override
  State<CreateNewCourtPage> createState() => _CreateNewCourtPage();
}

class _CreateNewCourtPage extends State<CreateNewCourtPage> {
  /// [_validator] is a validator instance of [CreateNewCourtFormValidator].
  final CreateNewCourtFormValidator _validator = CreateNewCourtFormValidator();

  /// [_textInputControllers] is a Map of TextEditingControllers that are used to
  final Map<String, TextEditingController> _textInputControllers = {
    "pricePerHour": TextEditingController(),
  };

  /// [_errorTexts] is a Map of error texts that are used to display error messages
  final Map<String, String?> _errorTexts = {
    "pricePerHour": null,
    "courtImage": null,
  };

  /// [_image] is the image xfile.
  XFile? _image;

  /// [_pickImage] is a Future function that picks an image from the device.
  ///
  /// Returns [Future] of [XFile]
  Future<XFile?> _pickImage() async {
    // Create an image picker
    final ImagePicker picker = ImagePicker();

    // Pick an image from gallery
    return await picker.pickImage(source: ImageSource.gallery);
  }

  /// [_validateAddNewCourtForm] is a function that validates the Add New Court Form.
  ///
  /// Returns [bool]
  bool _validateAddNewCourtForm() {
    // Validate the price per hour and courts image
    setState(() {
      _errorTexts["pricePerHour"] = _validator.validatePricePerHour(
          price: _textInputControllers["pricePerHour"]!.text);

      _errorTexts["courtImage"] = _validator.validateCourtImage(image: _image);
    });

    return _errorTexts["pricePerHour"] == null &&
        _errorTexts["courtImage"] == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackableCenteredAppBar(title: "New ${widget.courtType} Court"),
      backgroundColor: ColorSchemes.primaryBackground,
      body: SafeArea(
          child: BlocConsumer<CreateNewCourtBloc, CreateNewCourtState>(
              listener: (BuildContext context, CreateNewCourtState state) {
        // Check for states
        if (state is CreateNewCourtErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }

        if (state is CreateNewCourtSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Court has been added.")));

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MyCourtDetailPage(
                        courtType: widget.courtType,
                      )));
        }
      }, builder: (BuildContext context, CreateNewCourtState state) {
        // Check for states
        if (state is CreateNewCourtLoadingState) {
          return const LoadingScreen();
        }

        return Padding(
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
                            prefixStyle: TextStyle(
                                fontSize: 14, color: ColorSchemes.text),
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
                      Text("Court Image",
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
                              // Pick an image
                              final XFile? tempRes = await _pickImage();

                              // Check if the image is null
                              if (tempRes == null) {
                                return;
                              }

                              setState(() {
                                _image = tempRes;
                              });
                            },
                            overlayColor: const WidgetStatePropertyAll(
                                Colors.transparent),
                            child: Container(
                              width: double.maxFinite,
                              height: 186,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: (_errorTexts["courtImage"] != null)
                                          ? ColorSchemes.error
                                          : ColorSchemes.subtle,
                                      width: 1)),
                              child: (_image != null)
                                  ? Padding(
                                      padding: const EdgeInsets.all(
                                          PAGE_PADDING_MOBILE),
                                      child: Image.file(
                                        File(_image!.path),
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  : Center(
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
                          if (_errorTexts["courtImage"] != null)
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 4, left: 16),
                                child: Text(_errorTexts["courtImage"]!,
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
        );
      })),
    );
  }
}
