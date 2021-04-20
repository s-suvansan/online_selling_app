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
  static String getTime(Timestamp time) {
    String _value = "";
    DateTime _now = DateTime.now();
    try {
      DateTime _time = time.toDate();

      /* DateTime _time = time.toDate();
      if (_time.day == _now.day && _time.month == _now.month && _time.year == _now.year) {
        if (_time.hour == _now.hour && _time.minute == _now.minute && _time.second > _now.second) {
          _value = "just now";
        } else {
          if (_time.hour == _now.hour) {
            _value = "${_now.minute - _time.minute} ${(_now.minute - _time.minute) > 1 ? "mins" : "min"} ago";
          } else {
            _value = "${_now.hour - _time.hour} ${(_now.hour - _time.hour) > 1 ? "hrs" : "hr"} ago";
          }
        }
      } else {
        if (_time.month == _now.month && _time.year == _now.year) {
          _value = "${_now.day - _time.day} ${(_now.day - _time.day) > 1 ? "days" : "day"} ago";
        } else {
          if (_time.year == _now.year) {
            _value = "${_now.month - _time.month} ${(_now.month - _time.month) > 1 ? "months" : "month"} ago";
          }
        }
      } */
    } catch (e) {
      _value = "";
    }
    return _value;
  }
}
