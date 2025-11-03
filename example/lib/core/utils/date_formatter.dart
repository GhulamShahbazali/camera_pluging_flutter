import 'package:intl/intl.dart';

import '../constants/app/utils_constants.dart';

class DateFormatter {
  /// Formats date to readable string
  static String formatDate(DateTime date) {
    return DateFormat(UtilsConstants.dateFormat).format(date);
  }

  /// Formats time to readable string
  static String formatTime(DateTime time) {
    return DateFormat(UtilsConstants.timeFormat).format(time);
  }

  /// Formats date and time together
  static String formatDateTime(DateTime dateTime) {
    return DateFormat(UtilsConstants.dateTimeFormat).format(dateTime);
  }

  /// Formats date for API (ISO format)
  static String formatDateForApi(DateTime date) {
    return DateFormat(UtilsConstants.apiDateFormat).format(date);
  }

  /// Formats time for API (ISO format)
  static String formatTimeForApi(DateTime time) {
    return DateFormat(UtilsConstants.apiTimeFormat).format(time);
  }

  /// Gets relative time (e.g., "2 hours ago")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays > 1 ? UtilsConstants.daysAgo : UtilsConstants.dayAgo}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours > 1 ? UtilsConstants.hoursAgo : UtilsConstants.hourAgo}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes > 1 ? UtilsConstants.minutesAgo : UtilsConstants.minuteAgo}';
    } else {
      return UtilsConstants.justNow;
    }
  }
}
