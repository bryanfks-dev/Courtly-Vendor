import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/data/repository/api/logout_repository.dart';
import 'package:courtly_vendor/data/repository/storage/token_repository.dart';
import 'package:courtly_vendor/domain/entities/vendor.dart';
import 'package:courtly_vendor/domain/usercases/logout_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/logout_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/states/logout_state.dart';
import 'package:courtly_vendor/presentation/blocs/states/vendor_state.dart';
import 'package:courtly_vendor/presentation/blocs/vendor_bloc.dart';
import 'package:courtly_vendor/presentation/widgets/bottom_modal_sheet.dart';
import 'package:courtly_vendor/presentation/widgets/loading_screen.dart';
import 'package:courtly_vendor/presentation/widgets/primary_button.dart';
import 'package:courtly_vendor/presentation/widgets/secondary_button.dart';
import 'package:courtly_vendor/presentation/widgets/vendor_profile/profile_menu.dart';
import 'package:courtly_vendor/presentation/widgets/vendor_profile/profile_menu_card.dart';
import 'package:courtly_vendor/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';

/// [VendorProfilePage] is the page to display the vendor profile.
/// This page will display the vendor profile data and the menu to navigate to other pages.
class VendorProfilePage extends StatefulWidget {
  const VendorProfilePage({super.key});

  @override
  State<VendorProfilePage> createState() => _VendorProfilePage();
}

class _VendorProfilePage extends State<VendorProfilePage> {
  /// [openLogoutModal] is the function to open the logout modal.
  /// This function will open the modal to confirm the logout action.
  ///
  /// - Parameters:
  ///   - context
  ///
  /// - Returns: void.
  void openLogoutModal(BuildContext context) {
    /// [logoutController] is the logout controller.
    final LogoutBloc logoutController = context.read<LogoutBloc>();

    // Open the logout modal.
    showBottomModalSheet(
        context,
        BlocProvider(
            create: (BuildContext context) => LogoutBloc(
                logoutUsecase: LogoutUsecase(
                    logoutRepository: LogoutRepository(),
                    tokenRepository: TokenRepository())),
            child: BlocConsumer<LogoutBloc, LogoutState>(
                listener: (BuildContext context, LogoutState state) {
              // Handle the state
              if (state is LogoutSuccessState) {
                // Clear the token
                logoutController.clearToken();

                // Navigate to the login page
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.login, (Route<dynamic> route) => false);
              }

              if (state is LogoutErrorState) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            }, builder: (BuildContext context, LogoutState state) {
              // Check the state
              if (state is LogoutLoadingState) {
                return const CircularProgressIndicator();
              }

              return Column(
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
                              minimumSize: const WidgetStatePropertyAll(
                                  Size.fromHeight(0))),
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
                          onPressed: () {
                            logoutController.logout();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(ColorSchemes.error),
                              minimumSize: WidgetStateProperty.all(
                                  const Size.fromHeight(0))),
                          child: const Text("Log me out",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)))
                    ],
                  )
                ],
              );
            })));
  }

  @override
  void initState() {
    super.initState();

    // Fetch the vendor data
    context.read<VendorBloc>().fetchVendorData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VendorBloc, VendorState>(
      listener: (BuildContext context, VendorState state) {
        // Handle the states
        if (state is VendorErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (BuildContext context, VendorState state) {
        // Check the states
        if (state is! VendorLoadedState) {
          return const LoadingScreen();
        }

        // Get the vendor data
        /// [vendor] is the vendor data.
        final Vendor vendor = state.vendor;

        /// [dateFormatter] is the date formatter to format the date.
        DateFormat dateFormatter = DateFormat("HH:mm");

        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: PAGE_PADDING_MOBILE,
                      right: PAGE_PADDING_MOBILE,
                      bottom: 20),
                  decoration:
                      BoxDecoration(color: ColorSchemes.primaryBackground),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            vendor.name,
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
                          Text(vendor.address,
                              style: TextStyle(
                                  color: ColorSchemes.text, fontSize: 14))
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
                          Text(
                              "${dateFormatter.format(vendor.openTime)} - ${dateFormatter.format(vendor.closeTime)}",
                              style: TextStyle(
                                  color: ColorSchemes.text, fontSize: 14))
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
                                        color: ColorSchemes.text,
                                        fontSize: 14)),
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
      },
    );
  }
}
