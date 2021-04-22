import 'package:intl/intl.dart';

import '../main_index.dart';

class App {
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static Random _rnd = Random();
  static NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");

  //Get the devie Hight
  static double getDeviceHight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  //Get the device width
  static double getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // pop screen once
  static void popOnce(BuildContext context) {
    Navigator.of(context).pop();
  }

  // get random string for message id
  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  // get price with currency code
  static String getPrice(var price, {bool needSpace = true}) {
    String _value = "";
    double _price = 0.00;

    try {
      if (price != null && price != "") {
        _price = double.parse(price.toString());
      }
      _value = needSpace ? "Rs. ${currencyFormat.format(_price).toString()}" : "Rs.${currencyFormat.format(_price).toString()}";
    } catch (e) {
      _value = needSpace ? "Rs. 0.00" : "Rs.0.00";
    }
    return _value;
  }

  // svg image view
  static SvgPicture svgImage({
    @required svg,
    Color color,
    double width = 50.0,
    double height = 50.0,
  }) {
    return SvgPicture.asset(
      svg,
      color: color ?? BrandColors.shadow,
      width: width,
      height: height,
    );
  }

  // get time
  static String getTime(Timestamp postAt) {
    String _value = "";
    Timestamp _now = Timestamp.now();
    try {
      Timestamp _postAt = postAt;
      int _time = _now.seconds - _postAt.seconds;
      if (_time < 60) {
        //1min - 60 sec
        _value = "just now";
      } else if (_time < 3600) {
        //1hr - 3600 sec
        _value = "${_time ~/ 60} ${(_time ~/ 60) > 1 ? "mins" : "min"} ago";
      } else if (_time < 86400) {
        //1day - 86400 sec
        _value = "${_time ~/ 3600} ${(_time ~/ 3600) > 1 ? "hrs" : "hr"} ago";
      } else if (_time < 2592000) {
        //1 month - 2592000 sec
        _value = "${_time ~/ 86400} ${(_time ~/ 86400) > 1 ? "days" : "day"} ago";
      } else if (_time < 31536000) {
        //1year - 31536000 sec
        _value = "${_time ~/ 2592000} ${(_time ~/ 2592000) > 1 ? "months" : "month"} ago";
      } else {
        _value = "${_time ~/ 31536000} ${(_time ~/ 31536000) > 1 ? "years" : "year"} ago";
      }
    } catch (e) {
      _value = "";
    }
    return _value;
  }

  // get date and time as in formats like 23/10/2020 , 23th Oct 2020
  static String showDateTimeInFormat(
    Timestamp postAt, {
    DateTimeFormat format = DateTimeFormat.Date,
    DateFormat date = DateFormat.TextDate,
    TimeFormat time = TimeFormat.LocalTime,
    bool needReverse = false,
  }) {
    String _value = "";
    try {
      DateTime _postAt = postAt.toDate();
      if (format == DateTimeFormat.Date) {
        if (date == DateFormat.NormalDate) {
          _value = !needReverse
              ? "${_makeTwoDigit(_postAt.day)}/${_makeTwoDigit(_postAt.month)}/${_postAt.year}"
              : "${_postAt.year}/${_makeTwoDigit(_postAt.month)}/${_makeTwoDigit(_postAt.day)}";
        } else if (date == DateFormat.TextDate) {
          _value = "${_makeTwoDigit(_postAt.day, needSupText: true)} ${_getMonthText(_postAt.month)} ${_postAt.year}";
        }
      } else if (format == DateTimeFormat.Time) {
        if (time == TimeFormat.LocalTime) {
          _value =
              "${_makeTwoDigit(_postAt.hour > 12 ? (_postAt.hour - 12) : _postAt.hour)}:${_makeTwoDigit(_postAt.minute)} ${_postAt.hour > 12 ? "PM" : "AM"}";
        } else if (time == TimeFormat.StandardTime) {
          _value = "${_makeTwoDigit(_postAt.hour)}:${_makeTwoDigit(_postAt.minute)}:${_makeTwoDigit(_postAt.second)}";
        }
      } else if (format == DateTimeFormat.DateAndTime) {
        _value =
            "${_makeTwoDigit(_postAt.day, needSupText: true)} ${_getMonthText(_postAt.month)} ${_postAt.year} ${_makeTwoDigit(_postAt.hour > 12 ? (_postAt.hour - 12) : _postAt.hour)}:${_makeTwoDigit(_postAt.minute)} ${_postAt.hour > 12 ? "PM" : "AM"}";
      }
    } catch (e) {
      _value = "";
    }
    return _value;
  }

  // make a digit digit as two digit text Ex:- 1 => 01
  // and make text with supertext and related with above function
  static String _makeTwoDigit(int digit, {bool needSupText = false}) {
    String _value = "";
    try {
      _value = digit.toString().length == 1 ? "0$digit" : digit.toString();
      if (needSupText) {
        if (digit == 1) {
          _value = "$_value\u02e2\u1d57"; //1st
        } else if (digit == 2) {
          _value = "$_value\u207f\u1d48"; //2nd
        } else if (digit == 3) {
          _value = "$_value\u02b3\u1d48"; //3rd
        } else {
          _value = "$_value\u1d57\u02b0"; //nth
        }
      }
    } catch (e) {}
    return _value;
  }

  // get month in text format like Jan,Feb,Oct
  static String _getMonthText(int month) {
    String _value = "";
    try {
      switch (month) {
        case 1:
          _value = "Jan";
          break;
        case 2:
          _value = "Feb";
          break;
        case 3:
          _value = "Mar";
          break;
        case 4:
          _value = "Apr";
          break;
        case 5:
          _value = "May";
          break;
        case 6:
          _value = "Jun";
          break;
        case 7:
          _value = "Jul";
          break;
        case 8:
          _value = "Aug";
          break;
        case 9:
          _value = "Sep";
          break;
        case 10:
          _value = "Oct";
          break;
        case 11:
          _value = "Nov";
          break;
        case 12:
          _value = "Dec";
          break;
        default:
          return "";
      }
    } catch (e) {
      _value = "";
    }
    return _value;
  }

  // show bottom sheet
  static void showBottomPopup(BuildContext context, Widget widget, {double reduceHeightBy = 0.0}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Container(height: getDeviceHight(context) - reduceHeightBy, child: widget);
        });
  }
}

enum DateTimeFormat {
  Date,
  Time,
  DateAndTime,
}

enum DateFormat {
  NormalDate, // 23/10/2020
  TextDate, // 23th Oct 2020
}

enum TimeFormat {
  LocalTime, // 03:24:00 AM or PM
  StandardTime, // 15:24:00
}

/* extension DateTimeFormatExtenstion on DateTimeFormat {
  int get code {
    switch (this) {
      case DateTimeFormat.Date:
        return 1;
      case DateTimeFormat.Time:
        return 2;
      case DateTimeFormat.DateAndTime:
        return 3;
      default:
        return 1;
    }
  }
} */