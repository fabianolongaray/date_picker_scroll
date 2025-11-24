import 'package:flutter/material.dart';
import 'package:date_picker_scroll/date_picker_scroll.dart';

void main() {
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final textTheme = Theme.of(context).textTheme;
    final unselectedStyle = (textTheme.headlineSmall ??
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
        .copyWith(color: const Color(0xFFB7B9BB));
    final selectedStyle = (textTheme.headlineMedium ??
            const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
        .copyWith(color: const Color(0xFF0F161E));
    final scrollViewOptions = DatePickerScrollViewOptions(
      day: ScrollViewDetailOptions(
        alignment: Alignment.center,
        textAlign: TextAlign.center,
        textStyle: unselectedStyle,
        selectedTextStyle: selectedStyle,
        horizontalPadding: 16,
      ),
      month: ScrollViewDetailOptions(
        alignment: Alignment.center,
        textAlign: TextAlign.center,
        textStyle: unselectedStyle,
        selectedTextStyle: selectedStyle,
        horizontalPadding: 20,
      ),
      year: ScrollViewDetailOptions(
        alignment: Alignment.center,
        textAlign: TextAlign.center,
        textStyle: unselectedStyle,
        selectedTextStyle: selectedStyle,
        horizontalPadding: 18,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Date Picker Example"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 100.0,
            alignment: Alignment.center,
            child: Text(
              "$_selectedDate",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 48),
            child: TextButton(
              onPressed: () {
                setState(() {
                  _selectedDate = DateTime.now();
                });
              },
              child: Text(
                "TODAY",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: ScrollDatePicker(
              selectedDate: _selectedDate,
              locale: const Locale('pt'),
              minimumDate: DateTime(1900, 1, 1),
              maximumDate: now,
              options: const DatePickerOptions(
                backgroundColor: Color(0xFFFAFAFB),
                indicatorColor: Color(0xFFFFFFFF),
                indicatorBorderRadius: BorderRadius.all(Radius.circular(8)),
                isLoop: false,
              ),
              scrollViewOptions: scrollViewOptions,
              onDateTimeChanged: (DateTime value) {
                setState(() {
                  _selectedDate = value;
                });
              },
            ),
          ),
          /// Showcase second image source
      // SizedBox(
          //   height: 250,
          //   child: ScrollDatePicker(
          //     selectedDate: _selectedDate,
          //     locale: Locale('ko'),
          //     scrollViewOptions: DatePickerScrollViewOptions(
          //       year: ScrollViewDetailOptions(
          //         label: '년',
          //         margin: const EdgeInsets.only(right: 8),
          //       ),
          //       month: ScrollViewDetailOptions(
          //         label: '월',
          //         margin: const EdgeInsets.only(right: 8),
          //       ),
          //       day: ScrollViewDetailOptions(
          //         label: '일',
          //       )
          //     ),
          //     onDateTimeChanged: (DateTime value) {
          //       setState(() {
          //         _selectedDate = value;
          //       });
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}