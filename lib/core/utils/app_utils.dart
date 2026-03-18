import 'package:intl/intl.dart';

class AppUtils {
  AppUtils._();

  static final NumberFormat _currencyFormatter = NumberFormat.currency(
    symbol: '₹',
    decimalDigits: 2,
  );
  
  static final NumberFormat _compactFormatter = NumberFormat.compact();
  
  static final NumberFormat _percentageFormatter = NumberFormat.percentPattern()
    ..maximumFractionDigits = 2;

  static String formatPrice(double price) {
    return _currencyFormatter.format(price);
  }

  static String formatPriceChange(double change) {
    final sign = change >= 0 ? '+' : '';
    return '$sign${_currencyFormatter.format(change)}';
  }

  static String formatPercentage(double percentage) {
    final sign = percentage >= 0 ? '+' : '';
    return '$sign${percentage.toStringAsFixed(2)}%';
  }

  static String formatCompact(double value) {
    return _compactFormatter.format(value);
  }

  static String formatTime(DateTime time) {
    return DateFormat('HH:mm:ss').format(time);
  }

  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static bool isPositive(double value) {
    return value >= 0;
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}
