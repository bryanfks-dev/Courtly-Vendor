import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/core/utils/money_formatter.dart';
import 'package:courtly_vendor/domain/entities/booking.dart';
import 'package:courtly_vendor/presentation/blocs/my_court_detail_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/states/my_court_detail_state.dart';
import 'package:courtly_vendor/presentation/pages/add_new_court.dart';
import 'package:courtly_vendor/presentation/widgets/backable_centered_app_bar.dart';
import 'package:courtly_vendor/presentation/widgets/bottom_modal_sheet.dart';
import 'package:courtly_vendor/presentation/widgets/loading_screen.dart';
import 'package:courtly_vendor/presentation/widgets/my_court_detail/delete_chip.dart';
import 'package:courtly_vendor/presentation/widgets/primary_button.dart';
import 'package:courtly_vendor/presentation/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';

/// [MyCourtDetail] is a [StatefulWidget] that displays the detail of a court.
/// This widget is used to display the detail of a court, including the schedule
class MyCourtDetail extends StatefulWidget {
  const MyCourtDetail({super.key, required this.courtType});

  /// [courtType] is the type of the court.
  final String courtType;

  @override
  State<MyCourtDetail> createState() => _CourtDetailState();
}

class _CourtDetailState extends State<MyCourtDetail> {
  /// [_bookedBoxes] is a list of booked boxes.
  /// This list is used to store the booked boxes.
  final List<int> _bookedBoxes = [];

  /// [_courtsName] is the list of courts name.
  late List<String> _courtsName;

  /// [_moreMenus] is the list of more menus that can be accessed from the app bar.
  late List<Widget> _moreMenus;

  /// [_gridBoxWidth] is the width of the grid box.
  final double _gridBoxWidth = 90;

  /// [_gridBoxHeight] is the height of the grid box.
  final double _gridBoxHeight = 56;

  /// [_timeColumnWidth] is the width of the time column.
  final double _timeColumnWidth = 70;

  /// [_selectedDate] is the selected date.
  DateTime _selectedDate = DateTime.now();

  /// [weekDays] is the list of week days.
  final List<DateTime> weekDays =
      List.generate(7, (index) => DateTime.now().add(Duration(days: index)));

  /// [_timeSlots] is the list of time slots.
  late List<String> _timeSlots;

  /// [_generateTimeSlots] is a function that generates the time slots between the start and end time.
  ///
  /// Parameters:
  ///   - [start] is the start time.
  ///   - [end] is the end time.
  ///
  /// Returns a [List] of [String]
  List<String> _generateTimeSlots(DateTime start, DateTime end) {
    final int hourDiff = end.difference(start).inHours;

    return List.generate(hourDiff, (index) {
      final DateTime time = start.add(Duration(hours: index));

      return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    });
  }

  /// [_formatWeekday] is a function that formats the weekday.
  ///
  /// Parameters:
  ///   - [date] is the date to be formatted.
  ///
  /// Returns a [String] that represents the formatted weekday.
  String _formatWeekday(DateTime date) {
    return DateFormat("E").format(date);
  }

  /// [_formatMonth] is a function that formats the month.
  ///
  /// Parameters:
  ///   - [date] is the date to be formatted.
  ///
  /// Returns a [String] that represents the formatted month.
  String _formatMonth(DateTime date) {
    return DateFormat("MMM").format(date);
  }

  // Schedule for each date (key = date, value = grid data)
  Map<String, List<List<bool>>> schedules = {};

  /// [_initializeSchedule] is a function that initializes the schedule for the selected date.
  ///
  /// Returns [void]
  void _initializeSchedule() {
    String dateKey = _formatDateKey(_selectedDate);

    schedules[dateKey] = List.generate(
      _timeSlots.length,
      (_) => List.generate(_courtsName.length, (_) => false),
    );
  }

  /// [_encodeBookingValue] is a function that encodes the booking value.
  ///
  /// Parameters:
  ///   - [timeIndex] is the index of the time.
  ///   - [courtIndex] is the index of the court.
  ///
  /// Returns an [int] that represents the encoded booking value.
  int _encodeBookingValue(int timeIndex, int courtIndex) {
    return courtIndex + timeIndex * _courtsName.length;
  }

  /// [_initBookedBoxes] is a function that initializes the booked boxes.
  ///
  /// Parameters:
  ///   - [bookings] is the list of bookings.
  ///
  /// Returns [void]
  void _initBookedBoxes(List<Booking> bookings) {
    // Clear the booked boxes
    _bookedBoxes.clear();

    // Encode the booking value
    for (Booking booking in bookings) {
      _bookedBoxes.add(_encodeBookingValue(
          _timeSlots.indexOf(DateFormat("HH:mm").format(booking.startTime)),
          _courtsName.indexOf(booking.court.name)));
    }
  }

  /// [_openDeleteModal] is a function that opens the delete modal.
  /// This function will open a modal that allows the user to select the courts to delete.
  ///
  /// Parameters:
  ///   - [context]: The build context.
  ///
  /// Returns [void]
  void _openDeleteModal(BuildContext context) {
    showBottomModalSheet(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Court(s)",
                style: TextStyle(
                    fontSize: 16,
                    color: ColorSchemes.text,
                    fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 14,
            ),
            SizedBox(
              height: 100,
              child: SingleChildScrollView(
                  child: Wrap(
                      spacing: 6,
                      children: _courtsName
                          .map((item) => DeleteChip(label: item, onTap: () {}))
                          .toList())),
            ),
            const SizedBox(
              height: 15,
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
                      "Cancel",
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
                    child: const Text("Delete",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)))
              ],
            )
          ],
        ));
  }

  /// [_initializeMoreMenus] is a function that initializes the more menus.
  ///
  /// Returns [void]
  void _initializeMoreMenus() {
    _moreMenus = [
      InkWell(
        onTap: () {},
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        child: Row(
          children: [
            HeroIcon(
              HeroIcons.plus,
              color: ColorSchemes.primary,
            ),
            const SizedBox(
              width: 16,
            ),
            const Text(
              "Add New Court",
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
      InkWell(
        onTap: () {
          _openDeleteModal(context);
        },
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        child: Row(
          children: [
            HeroIcon(
              HeroIcons.trash,
              color: ColorSchemes.primary,
            ),
            const SizedBox(
              width: 16,
            ),
            const Text(
              "Delete Courts",
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
      )
    ];
  }

  /// [_isBooked] is a function that checks if a box is booked.
  ///
  /// Parameters:
  ///   - [courtIndex] is the index of the court.
  ///   - [timeIndex] is the index of the time.
  ///
  /// Returns a [bool] that indicates if the box is booked.
  bool _isBooked(int courtIndex, int timeIndex) {
    return _bookedBoxes.contains(_encodeBookingValue(timeIndex, courtIndex));
  }

  @override
  void initState() {
    super.initState();

    _initializeMoreMenus();

    // Fetch the list of courts
    context
        .read<MyCourtDetailBloc>()
        .getCourtsData(courtType: widget.courtType, date: _selectedDate);
  }

  /// [_formatDateKey] is a function that formats the date key.
  ///
  /// Parameters:
  ///   - [date] is the date to be formatted.
  ///
  /// Returns a [String] that represents the formatted date key.
  String _formatDateKey(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }

  /// [_onDateChanged] is a function that is called when the date is changed.
  /// This function will update the selected date and the schedule.
  ///
  /// Parameters:
  /// - [newDate]: The new date that is selected.
  ///
  /// Returns [void]
  void _onDateChanged(DateTime newDate) {
    setState(() {
      // Update the selected date
      _selectedDate = newDate;
    });
  }

  /// [_getTitleWidget] is a function that generates the title widget for the table.
  ///
  /// Returns: [List<Widget>]
  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget(label: 'Time', width: _timeColumnWidth),
      ..._courtsName.map(
          (court) => _getTitleItemWidget(label: court, width: _gridBoxWidth)),
    ];
  }

  /// [_getTitleItemWidget] is a function that generates the title item widget for the table.
  ///
  /// Parameters:
  ///   - [label]: The label of the title item.
  ///   - [width]: The width of the title item.
  ///
  /// Returns: [Widget]
  Widget _getTitleItemWidget({required String label, required double width}) {
    return Container(
      width: width,
      height: 56,
      alignment: Alignment.center,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  /// [_generateFirstColumnRow] is a function that generates the first column row for the table.
  ///
  /// Parameters:
  ///   - [context]: The build context.
  ///   - [index]: The index of the row.
  ///
  /// Returns: [Widget]
  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: _gridBoxWidth,
      height: _gridBoxHeight,
      alignment: Alignment.center,
      child: Text(_timeSlots[index]),
    );
  }

  /// [_generateRightHandSideColumnRow] is a function that generates the right hand side column row for the table.
  /// This function generates the grid box for each court.
  ///
  /// Parameters:
  ///   - [context]: The build context.
  ///   - [index]: The index of the row.
  ///
  /// Returns: [Widget]
  Widget _generateRightHandSideColumnRow(BuildContext context, int timeIndex) {
    return Row(
      children: List.generate(_courtsName.length, (courtIndex) {
        // Check if the box is booked
        final bool isBooked = _isBooked(courtIndex, timeIndex);

        return Container(
            width: _gridBoxWidth,
            height: _gridBoxHeight,
            decoration: BoxDecoration(
              color: isBooked ? ColorSchemes.subtle : Colors.transparent,
              border: Border.all(color: ColorSchemes.subtle),
            ),
            child: isBooked
                ? Center(
                    child: Text(
                    "Booked",
                    style:
                        TextStyle(fontSize: 12, color: ColorSchemes.highlight),
                  ))
                : const SizedBox.shrink());
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchemes.primaryBackground,
      appBar: BackableCenteredAppBar(title: "My Court", moreMenus: _moreMenus),
      body: SafeArea(
          child: BlocConsumer<MyCourtDetailBloc, MyCourtDetailState>(
              listener: (BuildContext context, MyCourtDetailState state) {
        // Check for states
        if (state is MyCourtDetailErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
          ));
        }

        if (state is MyCourtDetailLoadedState) {
          // Initialize time slot
          _timeSlots =
              _generateTimeSlots(state.vendor.openTime, state.vendor.closeTime);

          // Initialize courts name
          _courtsName = state.courts.map((e) => e.name).toList();

          _initializeSchedule();

          _initBookedBoxes(state.bookings);

          // Check if there are no courts
          if (state.courts.isEmpty) {
            // Navigate to add new court page
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AddNewCourtPage(
                          courtType: widget.courtType,
                        )));
          }
        }
      }, builder: (BuildContext context, MyCourtDetailState state) {
        // Check for states
        if (state is! MyCourtDetailLoadedState || state.courts.isEmpty) {
          return const LoadingScreen();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.courtType} Courts",
                      style: TextStyle(
                        color: ColorSchemes.text,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Price: Rp ${moneyFormatter(amount: state.courts[0].price)}/hour",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  overlayColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  child: HeroIcon(HeroIcons.pencilSquare,
                      size: 20, color: ColorSchemes.highlight),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 78,
              width: double.maxFinite,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  /// [date] is the date of the current index.
                  DateTime date = weekDays[index];

                  /// [isSelected] is a boolean that indicates whether the date is selected or not.
                  bool isSelected = _selectedDate.day == date.day &&
                      _selectedDate.month == date.month;

                  return InkWell(
                    onTap: () {
                      _onDateChanged(date);
                    },
                    overlayColor:
                        const WidgetStatePropertyAll(Colors.transparent),
                    child: Column(
                      children: [
                        Text(
                          _formatWeekday(date),
                          style: TextStyle(
                            color: isSelected
                                ? ColorSchemes.primary
                                : ColorSchemes.highlight,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 50,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                              color: isSelected
                                  ? ColorSchemes.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: isSelected
                                    ? ColorSchemes.primary
                                    : ColorSchemes.subtle,
                              )),
                          child: Text(
                            "${date.day} ${_formatMonth(date)}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected
                                  ? ColorSchemes.primaryBackground
                                  : ColorSchemes.highlight,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, _) =>
                    const SizedBox(width: 6),
                itemCount: weekDays.length,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
                child: HorizontalDataTable(
              leftHandSideColumnWidth: _timeColumnWidth,
              rightHandSideColumnWidth: _courtsName.length * _gridBoxWidth,
              isFixedHeader: true,
              headerWidgets: _getTitleWidget(),
              leftSideItemBuilder: _generateFirstColumnRow,
              rightSideItemBuilder: _generateRightHandSideColumnRow,
              itemCount: _timeSlots.length,
              leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
              rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
            ))
          ]),
        );
      })),
    );
  }
}
