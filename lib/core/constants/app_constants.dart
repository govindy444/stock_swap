class AppConstants {
  AppConstants._();

  static const String appName = 'TradeWatch';
  static const String appVersion = '1.0.0';
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration shimmerDuration = Duration(milliseconds: 1500);
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultRadius = 12.0;
  static const double cardElevation = 2.0;
  static const int minStockCount = 1;
  static const int maxStockCount = 50;
  static const int priceUpdateIntervalSeconds = 5;
  static const double maxPriceChangePercent = 2.0;
  static const String genericErrorMessage = 'Something went wrong. Please try again.';
  static const String networkErrorMessage = 'Network error. Please check your connection.';
  static const String emptyWatchlistMessage = 'Your watchlist is empty.';
}
