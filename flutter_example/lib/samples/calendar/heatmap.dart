///Package imports
import 'package:flutter/material.dart';

///calendar import
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../sample_view.dart';

///Local import

/// Colors used as background color for various month cells in this sample
const Color _kLightGrey = Color.fromRGBO(238, 238, 238, 1);
const Color _kLightGreen = Color.fromRGBO(198, 228, 139, 1);
const Color _kMidGreen = Color.fromRGBO(123, 201, 111, 1);
const Color _kDarkGreen = Color.fromRGBO(35, 154, 59, 1);
const Color _kDarkerGreen = Color.fromRGBO(25, 97, 39, 1);

/// Widget of heat map calendar
class HeatMapCalendar extends SampleView {
  /// Creates default heat map calendar
  const HeatMapCalendar({Key key}) : super(key: key);

  @override
  _HeatMapCalendarCalendarState createState() =>
      _HeatMapCalendarCalendarState();
}

class _HeatMapCalendarCalendarState extends SampleViewState {
  _HeatMapCalendarCalendarState();

  ScrollController controller;

  /// Global key used to maintain the state, when we change the parent of the
  /// widget
  GlobalKey _globalKey;

  @override
  void initState() {
    _globalKey = GlobalKey();
    controller = ScrollController();
    super.initState();
  }

  @override
  Widget build([BuildContext context]) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final Widget _calendar = Theme(

      /// The key set here to maintain the state,
      ///  when we change the parent of the widget
        key: _globalKey,
        data: model.themeData.copyWith(accentColor: model.backgroundColor),
        child: _getHeatMapCalendar());

    return Scaffold(
      backgroundColor: model.cardThemeColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child:
                      Container(color: model.cardThemeColor, child: _calendar),
                    )
                  ])),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: 70,
            width: screenWidth,
            color: model.cardThemeColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Less'),
                      Text('More'),
                    ],
                  ),
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          _kLightGrey,
                          _kLightGreen,
                          _kMidGreen,
                          _kDarkGreen,
                          _kDarkerGreen,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Returns the calendar widget based on the properties passed.
  SfCalendar _getHeatMapCalendar() {
    return SfCalendar(
        showNavigationArrow: model.isWeb,
        view: CalendarView.month,
        monthCellBuilder: _monthCellBuilder,
        showDatePickerButton: true,
        monthViewSettings: MonthViewSettings(
          showTrailingAndLeadingDates: false,
        ));
  }

  /// Returns the cell  text color based on the cell background color
  Color _getCellTextColor(Color backgroundColor) {
    if (backgroundColor == _kDarkGreen || backgroundColor == _kDarkerGreen) {
      return Colors.white;
    }

    return Colors.black;
  }

  /// Returns the builder for month cell.
  Widget _monthCellBuilder(
      BuildContext buildContext, MonthCellDetails details) {
    final Color backgroundColor = _getMonthCellBackgroundColor(details.date);
    final Color defaultColor =
    model.themeData != null && model.themeData.brightness == Brightness.dark
        ? Colors.black54
        : Colors.white;
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: defaultColor, width: 0.5)),
      child: Center(
        child: Text(
          details.date.day.toString(),
          style: TextStyle(color: _getCellTextColor(backgroundColor)),
        ),
      ),
    );
  }

  Color _getMonthCellBackgroundColor(DateTime date) {
    if (date.month % 2 == 0) {
      if (date.day % 6 == 0) {
        // 6, 12, 18, 24, 30
        return _kDarkerGreen;
      } else if (date.day % 5 == 0) {
        // 5, 10, 15, 20, 25
        return _kMidGreen;
      } else if (date.day % 8 == 0 || date.day % 4 == 0) {
        //  4, 8, 16, 24, 28
        return _kDarkGreen;
      } else if (date.day % 9 == 0 || date.day % 3 == 0) {
        // 3, 9, 18, 21, 27
        return _kLightGrey;
      } else {
        // 1, 2, 7, 11, 13, 19, 22, 23, 26, 29
        return _kLightGreen;
      }
    } else {
      if (date.day % 6 == 0) {
        // 6, 12, 18, 24, 30
        return _kLightGreen;
      } else if (date.day % 5 == 0) {
        // 5, 10, 15, 20, 25
        return _kLightGrey;
      } else if (date.day % 8 == 0 || date.day % 4 == 0) {
        //  4, 8, 16, 24, 28
        return _kMidGreen;
      } else if (date.day % 9 == 0 || date.day % 3 == 0) {
        // 3, 9, 18, 21, 27
        return _kDarkerGreen;
      } else {
        // 1, 2, 7, 11, 13, 19, 22, 23, 26, 29
        return _kDarkGreen;
      }
    }
  }
}