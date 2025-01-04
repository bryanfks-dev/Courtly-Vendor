import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/core/enums/sports.dart';
import 'package:courtly_vendor/presentation/blocs/my_courts_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/states/my_courts_state.dart';
import 'package:courtly_vendor/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly_vendor/presentation/widgets/loading_screen.dart';
import 'package:courtly_vendor/presentation/widgets/my_courts/court_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

/// [MyCourtsPage] is widget that represent my courts page.
/// It shows the list of courts.
class MyCourtsPage extends StatefulWidget {
  const MyCourtsPage({super.key});

  @override
  State<MyCourtsPage> createState() => _MyCourtsPage();
}

class _MyCourtsPage extends State<MyCourtsPage> {
  @override
  void initState() {
    super.initState();

    // Get the courts stats
    context.read<MyCourtsBloc>().getCourtsStats();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyCourtsBloc, MyCourtsState>(
      listener: (BuildContext context, MyCourtsState state) {
        // Check for states
        if (state is MyCourtsErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (BuildContext context, MyCourtsState state) {
        return Scaffold(
          backgroundColor: ColorSchemes.primaryBackground,
          appBar: const BackableCenteredAppBar(title: "My Courts"),
          body: SafeArea(
            child: BlocBuilder<MyCourtsBloc, MyCourtsState>(
                builder: (BuildContext context, MyCourtsState state) {
              // Check if the state is not loaded
              if (state is! MyCourtsLoadedState) {
                return const LoadingScreen();
              }

              /// [courtsCount] is a map of court type and its count
              final Map<String, int> courtsCount = {
                Sports.football.label: state.courtsStats.footballCourtCount,
                Sports.basketball.label: state.courtsStats.basketballCourtCount,
                Sports.badminton.label: state.courtsStats.badmintonCourtCount,
                Sports.volleyball.label: state.courtsStats.volleyballCourtCount,
                Sports.tennis.label: state.courtsStats.tennisCourtCount,
              };

              return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: PAGE_PADDING_MOBILE),
                  child: SingleChildScrollView(
                    physics: const PageScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            decoration: BoxDecoration(
                              color: ColorSchemes.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: ColorSchemes.primaryBackground,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: HeroIcon(
                                    HeroIcons.listBullet,
                                    size: 20,
                                    color: ColorSchemes.primary,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.courtsStats.totalCourts.toString(),
                                  style: TextStyle(
                                      color: ColorSchemes.primaryBackground,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 28),
                                ),
                                Text(
                                  "Total Courts",
                                  style: TextStyle(
                                      color: ColorSchemes.primaryBackground,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text("Courts",
                              style: TextStyle(
                                  color: ColorSchemes.text,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
                          const SizedBox(height: 20),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                // [entry] is the map entry
                                final MapEntry<String, int> entry =
                                    courtsCount.entries.elementAt(index);

                                return CourtCard(
                                    courtType: entry.key,
                                    courtCount: entry.value);
                              },
                              separatorBuilder: (BuildContext context, _) =>
                                  const SizedBox(height: 10),
                              itemCount: courtsCount.length),
                          const SizedBox(height: 20),
                        ]),
                  ));
            }),
          ),
        );
      },
    );
  }
}
