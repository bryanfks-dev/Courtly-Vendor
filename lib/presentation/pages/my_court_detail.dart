import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/presentation/widgets/backable_centered_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

/// [MyCourtDetail] is a [StatefulWidget] that displays the detail of a court.
/// This widget is used to display the detail of a court, including the schedule
class MyCourtDetail extends StatefulWidget {
  const MyCourtDetail({super.key});

  @override
  State<MyCourtDetail> createState() => _CourtDetailState();
}

class _CourtDetailState extends State<MyCourtDetail> {
  /// [_moreMenus] is the list of more menus that can be accessed from the app bar.
  final List<Widget> _moreMenus = [
    InkWell(
      onTap: () {},
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
      onTap: () {},
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

  /// [_gridBoxWidth] is the width of the grid box.
  final double _gridBoxWidth = 90;

  /// [_gridBoxHeight] is the height of the grid box.
  final double _gridBoxHeight = 56;

  /// [_timeColumnWidth] is the width of the time column.
  final double _timeColumnWidth = 70;

  DateTime selectedDate = DateTime.now();

  final List<String> courts = ['Court 1', 'Court 2', 'Court 3', 'Court 4'];

  final List<DateTime> weekDays =
      List.generate(7, (index) => DateTime.now().add(Duration(days: index)));

  final List<String> timeSlots = [
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00",
  ];

  // Schedule for each date (key = date, value = grid data)
  Map<String, List<List<bool>>> schedules = {};

  /// _initializeSchedule is a function that initializes the schedule for the selected date.
  void _initializeSchedule() {
    String dateKey = _formatDateKey(selectedDate);

    schedules[dateKey] = List.generate(
      timeSlots.length,
      (_) => List.generate(courts.length, (_) => false),
    );
  }

  @override
  void initState() {
    super.initState();

    _initializeSchedule();
  }

  String _formatDateKey(DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
  }

  /// [_onDateChanged] is a function that is called when the date is changed.
  /// This function will update the selected date and the schedule.
  ///
  /// Parameters:
  /// - [newDate]: The new date that is selected.
  ///
  /// Returns: [void]
  void _onDateChanged(DateTime newDate) {
    setState(() {
      // Update the selected date
      selectedDate = newDate;
    });
  }

  /// [_getTitleWidget] is a function that generates the title widget for the table.
  ///
  /// Returns: [List<Widget>]
  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget(label: 'Time', width: _timeColumnWidth),
      ...courts.map(
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
      child: Text(timeSlots[index]),
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
  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: List.generate(courts.length, (colIndex) {
        return GestureDetector(
          child: Container(
            width: _gridBoxWidth,
            height: _gridBoxHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: ColorSchemes.subtle),
            ),
            child: const Center(
              child: Text(
                "Booked",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchemes.primaryBackground,
      appBar: BackableCenteredAppBar(title: "My Court", moreMenus: _moreMenus),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Basketball Courts",
                    style: TextStyle(
                      color: ColorSchemes.text,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Price: Rp20,000/hour",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
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
                bool isSelected = selectedDate.day == date.day &&
                    selectedDate.month == date.month;

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
            rightHandSideColumnWidth: courts.length * _gridBoxWidth,
            isFixedHeader: true,
            headerWidgets: _getTitleWidget(),
            leftSideItemBuilder: _generateFirstColumnRow,
            rightSideItemBuilder: _generateRightHandSideColumnRow,
            itemCount: timeSlots.length,
            leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
            rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
          ))
        ]),
      )),
    );
  }

  String _formatWeekday(DateTime date) {
    const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

    return days[date.weekday % 7];
  }

  String _formatMonth(DateTime date) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[date.month - 1];
  }
}
