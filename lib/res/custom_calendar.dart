import 'package:flutter/material.dart';
import 'package:aim_swasthya/res/common_material.dart';

extension DateTimeExt on DateTime {
  DateTime get monthStart => DateTime(year, month);
  DateTime get dayStart => DateTime(year, month, day);

  DateTime addMonth(int count) {
    return DateTime(year, month + count, day);
  }

  bool isSameDate(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  bool get isToday => isSameDate(DateTime.now());
}

class CustomCalendar extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;
  const CustomCalendar({super.key, required this.onDateSelected});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime selectedMonth;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedMonth = DateTime.now().monthStart;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.screenWidth * 0.03,
            vertical: Sizes.screenHeight * 0.02),
        height: Sizes.screenHeight * 0.46,
        width: Sizes.screenWidth * 0.76,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(15),
          // border: Border.all(color: Colors.black),
        ),
        child: Column(
          children: [
            _Header(
              selectedMonth: selectedMonth,
              selectedDate: selectedDate,
              onChange: (value) => setState(() {
                selectedMonth = value;
                print("value");
                print(value);

              }),
            ),
            Sizes.spaceHeight20,
            Expanded(
              child: _Body(
                selectedMonth: selectedMonth,
                selectedDate: selectedDate,
                onDateSelected: (value) => setState(() {
                  selectedDate = value;
                  print("sgfdsgs $value");
                  widget.onDateSelected(value);
                }),
              ),
            ),
            _Bottom(
              selectedDate: selectedDate,
            ),
            // Sizes.spaceHeight5,
          ],
        ),
      ),
    );
  }
}

class _Header extends StatefulWidget {
  final DateTime selectedMonth;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onChange;

  const _Header({
    required this.selectedMonth,
    required this.selectedDate,
    required this.onChange,
  });

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {
  List<Map<String, dynamic>> getSearchYear = [];
  List<String> monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
              height: 20,
              width: 20,
              child: Center(
                child: InkWell(
                    onTap: () =>
                        widget.onChange(widget.selectedMonth.addMonth(-1)),
                    child: const Icon(Icons.arrow_back_ios, size: 13)),
              ),
            ),
            Sizes.spaceWidth20,
            TextConst(
              monthNames[widget.selectedMonth.month - 1],
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w500,

            ),

            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: AppColor.whiteColor,
                      title: Row(
                        children: [
                          TextConst(
                            monthNames[widget.selectedMonth.month - 1],
                            size: Sizes.fontSizeSix,
                            fontWeight: FontWeight.w600,
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 10,
                          ),
                        ],
                      ),
                      content: SizedBox(
                        width: 250,
                        height: 290,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: monthNames.length,
                          itemBuilder: (context, index) {
                            bool isSelected =
                                (widget.selectedMonth.month - 1) == index;
                            return ListTile(
                              title: Text(monthNames[index]),
                              tileColor: isSelected ? Colors.grey[300] : null,
                              onTap: () {
                                Navigator.of(context).pop();
                                widget.onChange(DateTime(
                                    widget.selectedMonth.year,
                                    index + 1,
                                    widget.selectedMonth.day));
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(
                Icons.arrow_drop_down,
              ),
            ),
            Sizes.spaceWidth5,
            SizedBox(
              height: 20,
              width: 20,
              child: Center(
                child: InkWell(
                    onTap: () =>
                        widget.onChange(widget.selectedMonth.addMonth(-1)),
                    child: const Icon(Icons.arrow_forward_ios, size: 13)),
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: Sizes.screenWidth * 0.04),
              height: 20,
              width: 20,
              child: Center(
                child: InkWell(
                    onTap: () =>
                        widget.onChange(widget.selectedMonth.addMonth(-12)),
                    child: const Icon(Icons.arrow_back_ios, size: 13)),
              ),
            ),
            Sizes.spaceWidth20,
            Text(
              '${widget.selectedMonth.year}',
              style:  TextStyle(fontSize: Sizes.fontSizeFive, fontWeight: FontWeight.w500),
            ),
            InkWell(
                onTap: () {
                  getSearchYear.clear();
                  for (int i = 0; i < 51; i++) {
                    final getMonth = 12 * i;
                    final yearAsPerMonths =
                        widget.selectedMonth.addMonth(-getMonth);
                    getSearchYear.add(
                        {'months': getMonth, 'year': yearAsPerMonths.year});
                  }
                  showDialog(
                    context: context,
                    builder: (_) {
                      return Dialog(
                        backgroundColor: AppColor.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SizedBox(
                          width: 250,
                          height: 350,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Sizes.screenWidth * 0.04,
                                    vertical: Sizes.screenHeight * 0.02),
                                child: const Text(
                                  'Last 50 Years',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: getSearchYear.length,
                                  itemBuilder: (context, index) {
                                    final yearData = getSearchYear[index];
                                    final year = yearData['year'];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: ListTile(
                                        title: TextConst(
                                          getSearchYear[index]['year']
                                              .toString(),
                                          size: Sizes.fontSizeSix,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        tileColor: getSearchYear.length == year
                                            ? Colors.grey[300]
                                            : null,
                                        onTap: () {
                                          Navigator.pop(context);
                                          widget.onChange(DateTime(
                                            year,
                                            widget.selectedMonth.month,
                                            widget.selectedMonth.day,
                                          ));
                                        },

                                        // onTap: () {
                                        //
                                        //   // Navigator.pop(context);
                                        // },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Icon(Icons.arrow_drop_down)),
            Sizes.spaceWidth5,
            Container(
              padding: EdgeInsets.only(right: Sizes.screenWidth * 0.04),
              height: 20,
              width: 20,
              child: Center(
                child: InkWell(
                    onTap: () =>
                        widget.onChange(widget.selectedMonth.addMonth(12)),
                    child: const Icon(Icons.arrow_forward_ios, size: 13)),
              ),
            ),
          ],
        ),
        Sizes.spaceHeight10,
      ],
    );
  }

  Widget selectedMonths() {
    return SizedBox(
      // color: Colors.red,
      width: 250,
      height: 290,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: monthNames.length,
        itemBuilder: (context, index) {
          bool isSelected = (widget.selectedMonth.month - 1) == index;
          return ListTile(
            title: Text(monthNames[index]),
            tileColor: isSelected ? Colors.grey[300] : null,
            onTap: () {
              Navigator.of(context).pop();
              widget.onChange(DateTime(widget.selectedMonth.year, index + 1,
                  widget.selectedMonth.day));
            },
          );
        },
      ),
    );
  }

  Widget selectedDates() {
    return SizedBox(
      width: 250,
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.screenWidth * 0.04,
                vertical: Sizes.screenHeight * 0.02),
            child: const Text(
              'Last 50 Years',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: getSearchYear.length,
              itemBuilder: (context, index) {
                final yearData = getSearchYear[index];
                final year = yearData['year'];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ListTile(
                    title: TextConst(
                      getSearchYear[index]['year'].toString(),
                      size: Sizes.fontSizeSix,
                      fontWeight: FontWeight.w500,
                    ),
                    tileColor:
                        getSearchYear.length == year ? Colors.grey[300] : null,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final DateTime selectedMonth;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const _Body({
    required this.selectedMonth,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final calendarData = CalendarMonthData(
      year: selectedMonth.year,
      month: selectedMonth.month,
    );

    return Column(
      children: [
        weekdaysHeader(),
        const SizedBox(height: 10),
        ...calendarData.weeks.map((week) => Row(
              children: week.map((dayData) {
                return Expanded(
                  child: _DayTile(
                    date: dayData.date,
                    isActiveMonth: dayData.isActiveMonth,
                    isSelected: selectedDate?.isSameDate(dayData.date) ?? false,
                    onTap: () => onDateSelected(dayData.date),
                  ),
                );
              }).toList(),
            )),
      ],
    );
  }
}

Widget weekdaysHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: const [
      'S',
      'M',
      'T',
      'W',
      'T',
      'F',
      'S',
    ].map((day) => Text(day)).toList(),
  );
}

class _DayTile extends StatelessWidget {
  final DateTime date;
  final bool isActiveMonth;
  final bool isSelected;
  final VoidCallback onTap;

  const _DayTile({
    required this.date,
    required this.isActiveMonth,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isToday = date.isToday;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        alignment: Alignment.center,
        decoration: isSelected
            ?  BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              )
            : isToday
                ?  BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  )
                : null,
        child: Text(
          date.day.toString(),
          style: TextStyle(
              color: isActiveMonth ? Colors.black : Colors.grey,
              fontSize: isSelected ? 16 : 14,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400),
        ),
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  final DateTime? selectedDate;

  const _Bottom({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            onPressed: () {},
            child: TextConst(
              "Clear",
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w600,
              color: AppColor.textfieldGrayColor,
            )),
        const Spacer(),
        TextButton(
            onPressed: () {},
            child: TextConst(
              "Cancel",
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            )),
        TextButton(
            onPressed: () {},
            child: TextConst(
              "Select",
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w600,
              color: AppColor.blue,
            )),
      ],
    );
  }
}

class CalendarMonthData {
  final int year;
  final int month;

  CalendarMonthData({required this.year, required this.month});

  int get daysInMonth => DateUtils.getDaysInMonth(year, month);

  int get firstDayOffset {
    final weekday = DateTime(year, month, 1).weekday;
    return (weekday - 1) % 7;
  }

  List<List<CalendarDayData>> get weeks {
    final days = List.generate(
      daysInMonth,
      (i) => DateTime(year, month, i + 1),
    );

    final firstDay = days.first.subtract(Duration(days: firstDayOffset));
    final totalDays = days.length + firstDayOffset;

    return List.generate((totalDays / 7).ceil(), (weekIndex) {
      return List.generate(7, (dayIndex) {
        final date = firstDay.add(Duration(days: weekIndex * 7 + dayIndex));
        return CalendarDayData(
          date: date,
          isActiveMonth: date.month == month,
        );
      });
    });
  }
}

class CalendarDayData {
  final DateTime date;
  final bool isActiveMonth;

  CalendarDayData({required this.date, required this.isActiveMonth});
}
