import 'package:courtly_vendor/core/constants/color_schemes.dart';
import 'package:courtly_vendor/core/constants/constants.dart';
import 'package:courtly_vendor/presentation/widgets/backable_centered_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class CourtDetail extends StatefulWidget {
  const CourtDetail({super.key});

  @override
  State<CourtDetail> createState() => _CourtDetailState();
}

class _CourtDetailState extends State<CourtDetail> {
  int selectedCourtIndex = 0;
  final List<Widget> moreMenus = [
    InkWell(
      child: Row(
        children: [
          HeroIcon(
            HeroIcons.plus,
            color: ColorSchemes.primary,
          ),
          SizedBox(
            width: 16,
          ),
          Text("Add New Court")
        ],
      ),
    ),
    InkWell(
      child: Row(
        children: [
          HeroIcon(
            HeroIcons.trash,
            color: ColorSchemes.primary,
          ),
          SizedBox(
            width: 16,
          ),
          Text("Delete Courts")
        ],
      ),
    )
  ];
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

  @override
  void initState() {
    super.initState();
    _initializeSchedule();
  }

  void _initializeSchedule() {
    String dateKey = _formatDateKey(selectedDate);
    schedules[dateKey] = List.generate(
      timeSlots.length,
      (_) => List.generate(courts.length, (_) => false),
    );
  }

  String _formatDateKey(DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
  }

  void _onDateChanged(DateTime newDate) {
    setState(() {
      selectedDate = newDate;

      String newDateKey = _formatDateKey(newDate);
      schedules.putIfAbsent(
        newDateKey,
        () => List.generate(
          timeSlots.length,
          (_) => List.generate(courts.length, (_) => false),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    String dateKey = _formatDateKey(selectedDate);
    List<List<bool>> currentSchedule = schedules.putIfAbsent(
      dateKey,
      () => List.generate(
        timeSlots.length,
        (_) => List.generate(courts.length, (_) => false),
      ),
    );
    return Scaffold(
      backgroundColor: ColorSchemes.primaryBackground,
      appBar: BackableCenteredAppBar(title: "My Courts", moreMenus: moreMenus),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Edit price logic
                    },
                    icon: const HeroIcon(HeroIcons.pencil, size: 20),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Date Selector with Horizontal Scroll
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: weekDays.map((date) {
                bool isSelected = selectedDate.day == date.day &&
                    selectedDate.month == date.month;
                return GestureDetector(
                  onTap: () {
                    _onDateChanged(date);
                  },
                  child: Column(
                    children: [
                      Text(
                        _formatWeekday(date),
                        style: TextStyle(
                          color: isSelected ? Colors.teal : Colors.grey[600],
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.teal : Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "${date.day} ${_formatMonth(date)}",
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
              child: HorizontalDataTable(
            leftHandSideColumnWidth: 80,
            rightHandSideColumnWidth: (courts.length) * 90 + 15,
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

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Time', 80),
      ...courts.map((court) => _getTitleItemWidget(court, 90)).toList(),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: 120,
      height: 56,
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(timeSlots[index]),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: List.generate(courts.length, (colIndex) {
        return GestureDetector(
          child: Container(
            width: 90,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Center(
              child: Text(
                "Booked",
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        );
      }),
    );
  }

  String _formatWeekday(DateTime date) {
    // const days = ["Thu", "Fri", "Sat", "Sun", "Mon", "Tue", "Wed"];
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
