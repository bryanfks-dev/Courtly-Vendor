import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/presentation/widgets/bottom_modal_sheet.dart';
import 'package:courtly_vendor/presentation/widgets/primary_button.dart';
import 'package:courtly_vendor/presentation/widgets/secondary_button.dart';
import 'package:courtly_vendor/presentation/widgets/vendor_profile/profile_menu.dart';
import 'package:courtly_vendor/presentation/widgets/vendor_profile/profile_menu_card.dart';
import 'package:courtly_vendor/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class VendorProfilePage extends StatelessWidget {
  const VendorProfilePage({super.key});

  /// [openLogoutModal] is the function to open the logout modal.
  /// This function will open the modal to confirm the logout action.
  ///
  /// - Parameters:
  ///   - context
  ///
  /// - Returns: void.
  void openLogoutModal(BuildContext context) {
    // Open the logout modal.
    showBottomModalSheet(
        context,
        Column(
          children: [
            Text.rich(
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorSchemes.text),
                TextSpan(text: "You are about to ", children: [
                  TextSpan(
                      text: "log out",
                      style: TextStyle(color: ColorSchemes.error)),
                  const TextSpan(text: ", confirm to proceed.")
                ])),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SecondaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        side: WidgetStatePropertyAll(BorderSide(
                            width: 1, color: ColorSchemes.highlight)),
                        minimumSize:
                            const WidgetStatePropertyAll(Size.fromHeight(0))),
                    child: Text(
                      "I changed my mind",
                      style: TextStyle(
                          color: ColorSchemes.highlight,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    )),
                const SizedBox(
                  height: 4,
                ),
                PrimaryButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(ColorSchemes.error),
                        minimumSize:
                            WidgetStateProperty.all(const Size.fromHeight(0))),
                    child: const Text("Log me out",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)))
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: PAGE_PADDING_MOBILE,
                  right: PAGE_PADDING_MOBILE,
                  bottom: 20),
              decoration: BoxDecoration(color: ColorSchemes.primaryBackground),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Unggul Sport Centre",
                        style: TextStyle(
                            color: ColorSchemes.text,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                              color: ColorSchemes.primary,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorSchemes.primary),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address",
                        style: TextStyle(
                            color: ColorSchemes.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                      const SizedBox(height: 3),
                      Text(
                          "Jl. Belimbing Indah No. 29, Pakis, Tirtomoyo, Kab. Malang, Jawa Timur",
                          style:
                              TextStyle(color: ColorSchemes.text, fontSize: 14))
                    ],
                  ),
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Operational Hours",
                        style: TextStyle(
                            color: ColorSchemes.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                      const SizedBox(height: 3),
                      Text("09:00 - 23:00",
                          style:
                              TextStyle(color: ColorSchemes.text, fontSize: 14))
                    ],
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                      overlayColor:
                          const WidgetStatePropertyAll(Colors.transparent),
                      onTap: () {
                        Navigator.of(context).pushNamed(Routes.myCourts);
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("View Your Courts",
                                style: TextStyle(
                                    color: ColorSchemes.text, fontSize: 14)),
                            HeroIcon(
                              HeroIcons.chevronRight,
                              size: 18,
                              color: ColorSchemes.highlight,
                            )
                          ]))
                ],
              ),
            ),
            const SizedBox(height: 10),
            ProfileMenuCard(title: "Account Settings", menus: [
              ProfileMenu(
                  iconData: HeroIcons.lockClosed,
                  title: "Change Password",
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.changePassword);
                  }),
            ]),
            const SizedBox(height: 10),
            ProfileMenu(
                iconData: HeroIcons.arrowRightOnRectangle,
                title: "Log Out",
                onTap: () {
                  openLogoutModal(context);
                })
          ],
        ),
      ),
    );
  }
}
