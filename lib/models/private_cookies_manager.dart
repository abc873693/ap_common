import 'dart:io';

// import 'package:cookie_jar/cookie_jar.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

/// Don't use this class in Browser environment
class PrivateCookieManager extends CookieManager {
  PrivateCookieManager(CookieJar cookieJar) : super(cookieJar);

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _saveCookies(response)
        .then((_) => handler.next(response))
        .catchError((dynamic e, dynamic stackTrace) {
      final DioError err = DioError(
        requestOptions: response.requestOptions,
        error: e,
        stackTrace: stackTrace as StackTrace,
      );
      handler.reject(err, true);
    });
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      _saveCookies(err.response!)
          .then((_) => handler.next(err))
          .catchError((dynamic e, dynamic stackTrace) {
        final DioError err0 = DioError(
          requestOptions: err.response!.requestOptions,
          error: e,
          stackTrace: stackTrace as StackTrace,
        );
        handler.next(err0);
      });
    } else {
      handler.next(err);
    }
  }

  Future<void> _saveCookies(Response<dynamic> response) async {
    final List<String>? cookies = response.headers[HttpHeaders.setCookieHeader];

    if (cookies != null) {
      await cookieJar.saveFromResponse(
        response.requestOptions.uri,
        cookies.map((String str) => _Cookie.fromSetCookieValue(str)).toList(),
      );
    }
  }
}

class _Cookie implements Cookie {
  _Cookie(String name, String value)
      : _name = _validateName(name),
        _value = _validateValue(value),
        httpOnly = true;

  _Cookie.fromSetCookieValue(String value)
      : _name = '',
        _value = '' {
    // Parse the 'set-cookie' header value.
    _parseSetCookieValue(value);
  }

  String _name;
  String _value;
  @override
  DateTime? expires;
  @override
  int? maxAge;
  @override
  String? domain;
  String? _path;
  @override
  bool httpOnly = false;
  @override
  bool secure = false;

  @override
  SameSite? sameSite;

  @override
  String get name => _name;

  @override
  String get value => _value;

  @override
  String? get path => _path;

  @override
  set path(String? newPath) {
    _validatePath(newPath);
    _path = newPath;
  }

  @override
  set name(String newName) {
    _validateName(newName);
    _name = newName;
  }

  @override
  set value(String newValue) {
    _validateValue(newValue);
    _value = newValue;
  }

  // Parse a 'set-cookie' header value according to the rules in RFC 6265.
  void _parseSetCookieValue(String s) {
    int index = 0;

    bool done() => index == s.length;

    String parseName() {
      final int start = index;
      while (!done()) {
        if (s[index] == '=') break;
        index++;
      }
      return s.substring(start, index).trim();
    }

    String parseValue() {
      final int start = index;
      while (!done()) {
        if (s[index] == ';') break;
        index++;
      }
      return s.substring(start, index).trim();
    }

    void parseAttributes() {
      String parseAttributeName() {
        final int start = index;
        while (!done()) {
          if (s[index] == '=' || s[index] == ';') break;
          index++;
        }
        return s.substring(start, index).trim().toLowerCase();
      }

      String parseAttributeValue() {
        final int start = index;
        while (!done()) {
          if (s[index] == ';') break;
          index++;
        }
        return s.substring(start, index).trim().toLowerCase();
      }

      while (!done()) {
        final String name = parseAttributeName();
        String value = '';
        if (!done() && s[index] == '=') {
          index++; // Skip the = character.
          value = parseAttributeValue();
        }
        if (name == 'expires') {
          expires = _parseCookieDate(value);
        } else if (name == 'max-age') {
          maxAge = int.parse(value);
        } else if (name == 'domain') {
          domain = value;
        } else if (name == 'path') {
          path = value;
        } else if (name == 'httponly') {
          httpOnly = true;
        } else if (name == 'secure') {
          secure = true;
        }
        if (!done()) index++; // Skip the ; character
      }
    }

    _name = _validateName(parseName());
    if (done() || _name.isEmpty) {
      throw HttpException('Failed to parse header value [$s]');
    }
    index++; // Skip the = character.
    _value = _validateValue(parseValue());
    if (done()) return;
    index++; // Skip the ; character.
    parseAttributes();
  }

  @override
  String toString() {
    final StringBuffer sb = StringBuffer();
    sb
      ..write(_name)
      ..write('=')
      ..write(_value);
    final DateTime? expires = this.expires;
    if (expires != null) {
      sb
        ..write('; Expires=')
        ..write(HttpDate.format(expires));
    }
    if (maxAge != null) {
      sb
        ..write('; Max-Age=')
        ..write(maxAge);
    }
    if (domain != null) {
      sb
        ..write('; Domain=')
        ..write(domain);
    }
    if (path != null) {
      sb
        ..write('; Path=')
        ..write(path);
    }
    if (secure) sb.write('; Secure');
    if (httpOnly) sb.write('; HttpOnly');
    return sb.toString();
  }

  static String _validateName(String newName) {
    const List<String> separators = <String>[
      '(',
      ')',
      '<',
      '>',
      '@',
      ',',
      ';',
      ':',
      '\\',
      '"',
      // "/",
      '[',
      ']',
      '?',
      '=',
      '{',
      '}',
    ];
    for (int i = 0; i < newName.length; i++) {
      final int codeUnit = newName.codeUnitAt(i);
      if (codeUnit <= 32 ||
          codeUnit >= 127 ||
          separators.contains(newName[i])) {
        throw FormatException(
          "Invalid character in cookie name, code unit: '$codeUnit'",
          newName,
          i,
        );
      }
    }
    return newName;
  }

  static String _validateValue(String newValue) {
    // Per RFC 6265, consider surrounding "" as part of the value, but otherwise
    // double quotes are not allowed.
    int start = 0;
    int end = newValue.length;
    if (2 <= newValue.length &&
        newValue.codeUnits[start] == 0x22 &&
        newValue.codeUnits[end - 1] == 0x22) {
      start++;
      end--;
    }

    for (int i = start; i < end; i++) {
      final int codeUnit = newValue.codeUnits[i];
      if (!(codeUnit == 0x21 ||
          (codeUnit >= 0x23 && codeUnit <= 0x2B) ||
          (codeUnit >= 0x2D && codeUnit <= 0x3A) ||
          (codeUnit >= 0x3C && codeUnit <= 0x5B) ||
          (codeUnit >= 0x5D && codeUnit <= 0x7E))) {
        throw FormatException(
          "Invalid character in cookie value, code unit: '$codeUnit'",
          newValue,
          i,
        );
      }
    }
    return newValue;
  }

  static void _validatePath(String? path) {
    if (path == null) return;
    for (int i = 0; i < path.length; i++) {
      final int codeUnit = path.codeUnitAt(i);
      // According to RFC 6265, semicolon and controls should not occur in the
      // path.
      // path-value = <any CHAR except CTLs or ";">
      // CTLs = %x00-1F / %x7F
      if (codeUnit < 0x20 || codeUnit >= 0x7f || codeUnit == 0x3b /*;*/) {
        throw FormatException(
          "Invalid character in cookie path, code unit: '$codeUnit'",
        );
      }
    }
  }

  static DateTime _parseCookieDate(String date) {
    const List<String> monthsLowerCase = <String>[
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec',
    ];

    int position = 0;

    Never error() {
      throw HttpException('Invalid cookie date $date');
    }

    bool isEnd() => position == date.length;

    bool isDelimiter(String s) {
      final int char = s.codeUnitAt(0);
      if (char == 0x09) return true;
      if (char >= 0x20 && char <= 0x2F) return true;
      if (char >= 0x3B && char <= 0x40) return true;
      if (char >= 0x5B && char <= 0x60) return true;
      if (char >= 0x7B && char <= 0x7E) return true;
      return false;
    }

    bool isNonDelimiter(String s) {
      final int char = s.codeUnitAt(0);
      if (char >= 0x00 && char <= 0x08) return true;
      if (char >= 0x0A && char <= 0x1F) return true;
      if (char >= 0x30 && char <= 0x39) return true; // Digit
      if (char == 0x3A) return true; // ':'
      if (char >= 0x41 && char <= 0x5A) return true; // Alpha
      if (char >= 0x61 && char <= 0x7A) return true; // Alpha
      if (char >= 0x7F && char <= 0xFF) return true; // Alpha
      return false;
    }

    bool isDigit(String s) {
      final int char = s.codeUnitAt(0);
      if (char > 0x2F && char < 0x3A) return true;
      return false;
    }

    int getMonth(String month) {
      if (month.length < 3) return -1;
      return monthsLowerCase.indexOf(month.substring(0, 3));
    }

    int toInt(String s) {
      int index = 0;
      for (; index < s.length && isDigit(s[index]); index++) {}
      return int.parse(s.substring(0, index));
    }

    final List<String> tokens = <String>[];
    while (!isEnd()) {
      while (!isEnd() && isDelimiter(date[position])) {
        position++;
      }
      final int start = position;
      while (!isEnd() && isNonDelimiter(date[position])) {
        position++;
      }
      tokens.add(date.substring(start, position).toLowerCase());
      while (!isEnd() && isDelimiter(date[position])) {
        position++;
      }
    }

    String? timeStr;
    String? dayOfMonthStr;
    String? monthStr;
    String? yearStr;

    for (final String token in tokens) {
      if (token.isEmpty) continue;
      if (timeStr == null &&
          token.length >= 5 &&
          isDigit(token[0]) &&
          (token[1] == ':' || (isDigit(token[1]) && token[2] == ':'))) {
        timeStr = token;
      } else if (dayOfMonthStr == null && isDigit(token[0])) {
        dayOfMonthStr = token;
      } else if (monthStr == null && getMonth(token) >= 0) {
        monthStr = token;
      } else if (yearStr == null &&
          token.length >= 2 &&
          isDigit(token[0]) &&
          isDigit(token[1])) {
        yearStr = token;
      }
    }

    if (timeStr == null ||
        dayOfMonthStr == null ||
        monthStr == null ||
        yearStr == null) {
      error();
    }

    int year = toInt(yearStr);
    if (year >= 70 && year <= 99) {
      year += 1900;
    } else if (year >= 0 && year <= 69) {
      year += 2000;
    }
    if (year < 1601) error();

    final int dayOfMonth = toInt(dayOfMonthStr);
    if (dayOfMonth < 1 || dayOfMonth > 31) error();

    final int month = getMonth(monthStr) + 1;

    final List<String> timeList = timeStr.split(':');
    if (timeList.length != 3) error();
    final int hour = toInt(timeList[0]);
    final int minute = toInt(timeList[1]);
    final int second = toInt(timeList[2]);
    if (hour > 23) error();
    if (minute > 59) error();
    if (second > 59) error();

    return DateTime.utc(year, month, dayOfMonth, hour, minute, second);
  }
}
