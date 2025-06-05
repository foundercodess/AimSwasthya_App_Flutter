// patient_section/view/p_auth/register/register_screen.dart
import 'package:aim_swasthya/res/back_btn_const.dart';
import 'package:aim_swasthya/res/custom_calendar.dart';
import 'package:aim_swasthya/res/glassmorphism_const.dart'
    show GlassmorphismExample;
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/patient_section/p_view_model/auth_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_role_view_model.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});
  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String selectedGender = '';
  dynamic dateTime;
  DateTime? _selectedDob;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userRegCon =
          Provider.of<UserRoleViewModel>(context, listen: false);
      userRegCon.resetValues();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final patientAuthCon = Provider.of<PatientAuthViewModel>(
      context,
    );
    final userRegCon = Provider.of<UserRoleViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: Sizes.screenHeight,
        width: Sizes.screenWidth,
        decoration: const BoxDecoration(
          gradient: AppColor.primaryBlueRadGradient,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.screenWidth * 0.06,
              vertical: Sizes.screenHeight * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Sizes.spaceHeight10,
              BackBtnConst(
                onTap: () {
                  if (userRegCon.isPersonalInfoSelected > 1) {
                    userRegCon
                        .changeWidget(userRegCon.isPersonalInfoSelected - 1);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              const Spacer(),
              userRegCon.isPersonalInfoSelected == 1
                  ? Center(child: introSection())
                  : userRegCon.isPersonalInfoSelected == 2
                      ? genderSection()
                      : userRegCon.isPersonalInfoSelected == 3
                          ? calendarSection()
                          : userRegCon.isPersonalInfoSelected == 4
                              ? heightSection()
                              : const SizedBox(),
              const Spacer(),
              AppBtn(
                fontSize: Sizes.fontSizeFive,
                borderRadius: 15,
                borderGradient: const [AppColor.lightBlue, AppColor.blue],
                height: Sizes.screenHeight * 0.06,
                width: Sizes.screenWidth,
                fontWidth: FontWeight.w500,
                title: AppLocalizations.of(context)!.next,
                titleColor: AppColor.textFieldBtnColor,
                onTap: () {
                  if (userRegCon.isPersonalInfoSelected == 1) {
                    if (_nameController.text.isEmpty) {
                      Utils.show("Please enter your name to continue", context);
                    } else {
                      userRegCon.changeWidget(2);
                    }
                  } else if (userRegCon.isPersonalInfoSelected == 2) {
                    if (selectedGender == '') {
                      Utils.show(
                          "Please select your gender to continue", context);
                    } else {
                      userRegCon.changeWidget(3);
                    }
                  } else if (userRegCon.isPersonalInfoSelected == 3) {
                    if (patientAuthCon.dateController.text.isEmpty) {
                      Utils.show("Please select you dob to continue", context);
                    } else {
                      userRegCon.changeWidget(4);
                    }
                  } else if (userRegCon.isPersonalInfoSelected == 4) {
                    if (_heightController.text.isEmpty) {
                      Utils.show(
                          'Please enter your height to continue', context);
                    } else if (_weightController.text.isEmpty) {
                      Utils.show(
                          'Please enter your weight to continue', context);
                    } else {
                      patientAuthCon.patientRegisterApi(
                          _nameController.text,
                          selectedGender,
                          patientAuthCon.dateController.text,
                          _heightController.text,
                          _weightController.text,
                          context);
                    }
                  }
                },
                color: AppColor.white,
              ),
              Sizes.spaceHeight10,
            ],
          ),
        ),
      ),
    );
  }

  Widget introSection() {
    return Container(
      height: Sizes.screenHeight * 0.7,
      width: Sizes.screenWidth * 0.9,
      padding: EdgeInsets.only(
        left: Sizes.screenWidth * 0.09,
        right: Sizes.screenWidth * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextConst(
            AppLocalizations.of(context)!.hello_introduction,
            size: Sizes.fontSizeFive,
            fontWeight: FontWeight.w500,
            color: AppColor.darkBlack,
          ),
          Sizes.spaceHeight5,
          TextConst(
            AppLocalizations.of(context)!.tell_name,
            size: Sizes.fontSizeFive,
            fontWeight: FontWeight.w600,
            color: AppColor.white,
          ),
          Sizes.spaceHeight25,
          TextField(
            controller: _nameController,
            // keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.enter_full_name,
              hintStyle: TextStyle(
                  color: AppColor.textFieldBtnColor,
                  fontWeight: FontWeight.w300,
                  fontSize: Sizes.fontSizeFive),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.black.withOpacity(0.75)),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.black.withOpacity(0.75)),
              ),
            ),
            cursorColor: AppColor.textGrayColor,
            cursorHeight: 22,
            style: const TextStyle(
              color: AppColor.blue,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget genderSection() {
    return Container(
      padding: EdgeInsets.only(
        left: Sizes.screenWidth * 0.09,
        right: Sizes.screenWidth * 0.05,
      ),
      // padding: EdgeInsets.symmetric(horizontal: Sizes.screenWidth * 0.06),
      height: Sizes.screenHeight / 2,
      width: Sizes.screenWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextConst(
            AppLocalizations.of(context)!.step_1,
            size: Sizes.fontSizeFive,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
          Sizes.spaceHeight25,
          ListTile(
            title: TextConst(
              "${AppLocalizations.of(context)!.hi_prashant}${_nameController.text}!",
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w500,
              color: AppColor.darkBlack,
            ),
            subtitle: TextConst(
              AppLocalizations.of(context)!.gender_identify,
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w600,
              color: AppColor.white,
            ),
          ),
          Sizes.spaceHeight35,
          AppBtn(
            height: Sizes.screenHeight * 0.05,
            width: Sizes.screenWidth * 0.42,
            title: AppLocalizations.of(context)!.male,
            titleColor: AppColor.black,
            color: selectedGender == "Male"
                ? AppColor.textGrayColor
                : AppColor.grey,
            fontWidth: FontWeight.w400,
            onTap: () {
              setState(() {
                selectedGender = "Male";
              });
            },
          ),
          Sizes.spaceHeight30,
          AppBtn(
            height: Sizes.screenHeight * 0.05,
            width: Sizes.screenWidth * 0.42,
            title: AppLocalizations.of(context)!.female,
            titleColor: AppColor.black,
            color: selectedGender == "Female"
                ? AppColor.textGrayColor
                : AppColor.grey,
            onTap: () {
              setState(() {
                selectedGender = "Female";
              });
            },
          ),
          Sizes.spaceHeight30,
          AppBtn(
            height: Sizes.screenHeight * 0.05,
            width: Sizes.screenWidth * 0.42,
            title: AppLocalizations.of(context)!.others,
            titleColor: AppColor.black,
            color: selectedGender == "Other"
                ? AppColor.textGrayColor
                : AppColor.grey,
            onTap: () {
              setState(() {
                selectedGender = "Other";
              });
            },
          ),
        ],
      ),
    );
  }

  DateTime selectedDate = DateTime.now();
  //
  // void _openCalendarDialog() async {
  //   final patientAuthCon =
  //       Provider.of<PatientAuthViewModel>(context, listen: false);
  //   final result = await showDialog<DateTime>(
  //     context: context,
  //     builder: (context) => CustomCalendarDialog(initialDate: selectedDate),
  //   );
  //   if (result != null) {
  //     setState(() => selectedDate = result);
  //     patientAuthCon.setDob(DateFormat('yyyy-MM-dd').format(result));
  //   }
  // }

  Widget calendarSection() {
    final patientAuthCon = Provider.of<PatientAuthViewModel>(
      context,
    );
    return Column(
      children: [
        TextConst(
          AppLocalizations.of(context)!.step_2,
          color: Colors.black54,
          size: Sizes.fontSizeFive,
          fontWeight: FontWeight.w500,
        ),
        Sizes.spaceHeight25,
        SizedBox(
          width: Sizes.screenWidth * 0.55,
          child: ListTile(
            title: TextConst(
              AppLocalizations.of(context)!.great,
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w500,
              color: AppColor.darkBlack,
            ),
            subtitle: TextConst(
              AppLocalizations.of(context)!.birthday,
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w600,
              color: AppColor.white,
            ),
          ),
        ),
        Sizes.spaceHeight20,
        // CustomCalendar(
        //   onDateSelected: (v) {
        //     setState(() {
        //       dateTime = v;
        //     });
        //   }, onCancel: () {  }, onSelect: () {  },
        // ),

        SizedBox(
          height: Sizes.screenHeight / 1.8,
          child: CustomCalendarDialog(
            initialDate: selectedDate,
            onSelect: (date) {
              setState(() {
                selectedDate = date;
              });
            },
          ),
        ),
        Sizes.spaceHeight10,
        if (patientAuthCon.dateController.text.isNotEmpty)
          ConstText(
            title: "Selected birthday: ${patientAuthCon.dateController.text}",
            color: AppColor.naviBlue,
            size: Sizes.fontSizeFivePFive,
          ),
      ],
    );
  }

  Widget heightSection() {
    return Container(
      padding: EdgeInsets.only(
        left: Sizes.screenWidth * 0.09,
        right: Sizes.screenWidth * 0.05,
      ),
      height: Sizes.screenHeight / 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextConst(
            AppLocalizations.of(context)!.step_3,
            color: Colors.black54,
            size: Sizes.fontSizeFive,
            fontWeight: FontWeight.w500,
          ),
          Sizes.spaceHeight25,
          ListTile(
            title: TextConst(
              AppLocalizations.of(context)!.awesome,
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w500,
              color: AppColor.darkBlack,
            ),
            subtitle: TextConst(
              AppLocalizations.of(context)!.height_weight,
              size: Sizes.fontSizeFive,
              fontWeight: FontWeight.w600,
              color: AppColor.white,
            ),
          ),
          SizedBox(height: Sizes.screenHeight * 0.08),
          SizedBox(
            width: Sizes.screenWidth / 2.6,
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextConst(
                      AppLocalizations.of(context)!.height,
                      size: Sizes.fontSizeFive,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
                    ),
                    Container(
                      width: 50,
                      margin:
                          const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                      child: TextField(
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: Sizes.fontSizeFivePFive,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blue,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.only(bottom: 0, left: 0, right: 0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.white),
                          ),
                          counterText: "",
                        ),
                        cursorColor: AppColor.textGrayColor,
                        cursorHeight: 20,
                      ),
                    ),
                    TextConst(
                      AppLocalizations.of(context)!.cm,
                      size: Sizes.fontSizeFive,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
                    ),
                  ],
                ),
                Sizes.spaceHeight25,
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextConst(
                      AppLocalizations.of(context)!.weight,
                      size: Sizes.fontSizeFive,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                      width: 50.0,
                      child: TextField(
                        controller: _heightController,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: Sizes.fontSizeFivePFive,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blue,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 8.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.white),
                          ),
                          counterText: "",
                        ),
                        cursorColor: AppColor.textGrayColor,
                        cursorHeight: 20,
                      ),
                    ),
                    TextConst(
                      AppLocalizations.of(context)!.kg,
                      size: Sizes.fontSizeFive,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCalendarDialog extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onSelect;

  const CustomCalendarDialog(
      {super.key, required this.initialDate, required this.onSelect});

  @override
  State<CustomCalendarDialog> createState() => _CustomCalendarDialogState();
}

class _CustomCalendarDialogState extends State<CustomCalendarDialog> {
  late int selectedYear;
  late int selectedMonth;
  DateTime? selectedDate;

  List<int> years =
      List.generate(100, (index) => DateTime.now().year - 50 + index);
  List<String> months = List.generate(
      12, (index) => DateFormat.MMMM().format(DateTime(0, index + 1)));

  @override
  void initState() {
    super.initState();
    selectedYear = widget.initialDate.year;
    selectedMonth = widget.initialDate.month;
    selectedDate = widget.initialDate;
  }

  void _changeMonth(int delta) {
    setState(() {
      selectedMonth += delta;
      if (selectedMonth < 1) {
        selectedMonth = 12;
        selectedYear--;
      } else if (selectedMonth > 12) {
        selectedMonth = 1;
        selectedYear++;
      }
    });
  }

  void _changeYear(int delta) {
    setState(() {
      selectedYear += delta;
    });
  }

  List<Widget> _buildDateGrid() {
    final firstDay = DateTime(selectedYear, selectedMonth, 1);
    final totalDays = DateTime(selectedYear, selectedMonth + 1, 0).day;
    final startingWeekday = firstDay.weekday % 7;

    List<Widget> dayWidgets = [];

    for (int i = 0; i < startingWeekday; i++) {
      dayWidgets.add(Container());
    }

    for (int day = 1; day <= totalDays; day++) {
      final date = DateTime(selectedYear, selectedMonth, day);
      final isSelected = selectedDate?.day == day &&
          selectedDate?.month == selectedMonth &&
          selectedDate?.year == selectedYear;

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            print("hjvhjv");
            setState(() {
              selectedDate = date;
            });
          },
          child: Container(
            decoration: isSelected
                ? BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  )
                : null,
            alignment: Alignment.center,
            child: Text('$day'),
          ),
        ),
      );
    }

    return dayWidgets;
  }

  @override
  Widget build(BuildContext context) {
    final patientAuthCon = Provider.of<PatientAuthViewModel>(
      context,
    );
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: const SizedBox(
                      width: 30, height: 25, child: Icon(Icons.chevron_left)),
                  onTap: () => _changeMonth(-1),
                ),
                DropdownButton<String>(
                  value: months[selectedMonth - 1],
                  underline: const SizedBox(),
                  items: months
                      .map((month) => DropdownMenuItem(
                          value: month,
                          child: SizedBox(width: 50, child: Text(month.length>5?month.substring(0,3):month))))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = months.indexOf(value!) + 1;
                    });
                  },
                ),
                GestureDetector(
                  child: const SizedBox(
                      width: 30, height: 25, child: Icon(Icons.chevron_right)),
                  onTap: () => _changeMonth(1),
                ),
                const Spacer(),
                GestureDetector(
                  child: const SizedBox(
                      width: 30, height: 25, child: Icon(Icons.chevron_left)),
                  onTap: () => _changeYear(-1),
                ),
                DropdownButton<int>(
                  value: selectedYear,
                  underline: const SizedBox(),
                  items: years
                      .map((year) => DropdownMenuItem(
                          value: year,
                          child: SizedBox(width: 40, child: Text('$year'))))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value!;
                    });
                  },
                ),
                GestureDetector(
                  child: const SizedBox(
                      width: 30, height: 25, child: Icon(Icons.chevron_right)),
                  onTap: () => _changeYear(1),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                  .map((e) => Expanded(
                        child: Center(
                            child: Text(e,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              children: _buildDateGrid(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child:
                      const Text("Cancel", style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    selectedDate = DateTime.now();
                    patientAuthCon.removeDob();
                    // Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text("Select",
                      style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    patientAuthCon
                        // .setDob(DateFormat('dd-MM-yyyy').format(selectedDate!));
                        .setDob(DateFormat('yyyy-MM-dd').format(selectedDate!));
                    widget.onSelect(selectedDate!);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
