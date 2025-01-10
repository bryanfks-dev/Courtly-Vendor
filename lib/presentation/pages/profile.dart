import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/domain/entities/vendor.dart';
import 'package:courtly_vendor/presentation/blocs/auth_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/events/auth_event.dart';
import 'package:courtly_vendor/presentation/blocs/events/profile_event.dart';
import 'package:courtly_vendor/presentation/blocs/logout_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/states/auth_state.dart';
import 'package:courtly_vendor/presentation/blocs/states/logout_state.dart';
import 'package:courtly_vendor/presentation/blocs/states/profile_state.dart';
import 'package:courtly_vendor/presentation/blocs/profile_bloc.dart';
import 'package:courtly_vendor/presentation/widgets/bottom_modal_sheet.dart';
import 'package:courtly_vendor/presentation/widgets/loading_screen.dart';
import 'package:courtly_vendor/presentation/widgets/primary_button.dart';
import 'package:courtly_vendor/presentation/widgets/secondary_button.dart';
import 'package:courtly_vendor/presentation/widgets/try_again_screen.dart';
import 'package:courtly_vendor/presentation/widgets/profile/profile_menu.dart';
import 'package:courtly_vendor/presentation/widgets/profile/profile_menu_card.dart';
import 'package:courtly_vendor/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';

/// [ProfilePage] is the page to display the vendor profile.
/// This page will display the vendor profile data and the menu to navigate to other pages.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  /// [_openLogoutModal] is the function to open the logout modal.
  /// This function will open the modal to confirm the logout action.
  ///
  /// Parameters:
  ///   - [context] is the build context.
  ///
  /// Returns [void].
  void _openLogoutModal(BuildContext context) {
    /// [logoutController] is the logout controller.
    final LogoutBloc logoutController = context.read<LogoutBloc>();

    // Open the logout modal.
    showBottomModalSheet(context, BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState authState) {
      return BlocConsumer<LogoutBloc, LogoutState>(
          listener: (BuildContext context, LogoutState logoutState) {
        // Handle the state
        if (logoutState is LogoutSuccessState) {
          // Close the modal
          Navigator.pop(context);

          context.read<AuthBloc>().add(CheckAuthEvent());
        }

        if (logoutState is LogoutErrorState) {
          // Close the modal
          Navigator.pop(context);

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(logoutState.errorMessage)));
        }
      }, builder: (BuildContext context, LogoutState state) {
        // Check the state
        if (state is LogoutLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
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
                    onPressed: () {
                      logoutController.logout();
                    },
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
        );
      });
    }));
  }

  @override
  void initState() {
    super.initState();

    // Check if the vendor data is not loaded
    if (context.read<ProfileBloc>().state is! ProfileLoadedState) {
      // Fetch the vendor data
      context.read<ProfileBloc>().add(FetchProfileEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (BuildContext context, ProfileState state) {
        // Handle the states
        if (state is ProfileErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (BuildContext context, ProfileState state) {
        // Check the states
        if (state is ProfileErrorState) {
          return TryAgainScreen(
              onTryAgain: () =>
                  context.read<ProfileBloc>().add(FetchProfileEvent()));
        }

        if (state is! ProfileLoadedState) {
          return const LoadingScreen();
        }

        // Get the vendor data
        /// [vendor] is the vendor data.
        final Vendor vendor = state.vendor;

        /// [dateFormatter] is the date formatter to format the date.
        DateFormat dateFormatter = DateFormat("HH:mm");

        return SafeArea(
          child: RefreshIndicator(
              onRefresh: () async {
                context.read<ProfileBloc>().add(FetchProfileEvent());
              },
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
                          Text(
                            vendor.name,
                            style: TextStyle(
                                color: ColorSchemes.text,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
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
                              overlayColor: const WidgetStatePropertyAll(
                                  Colors.transparent),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(Routes.myCourts);
                              },
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                            Navigator.of(context)
                                .pushNamed(Routes.changePassword);
                          }),
                    ]),
                    const SizedBox(height: 10),
                    ProfileMenu(
                        iconData: HeroIcons.arrowRightOnRectangle,
                        title: "Log Out",
                        onTap: () {
                          _openLogoutModal(context);
                        })
                  ],
                ),
              )),
        );
      },
    );
  }
}
