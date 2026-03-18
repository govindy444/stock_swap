import 'package:equatable/equatable.dart';


class Stock extends Equatable {
  final String symbol;
  final String name;
  final double currentPrice;
  final double priceChange;
  final double priceChangePercentage;
  final bool isPositive;
  final DateTime lastUpdated;

  const Stock({
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.priceChange,
    required this.priceChangePercentage,
    required this.isPositive,
    required this.lastUpdated,
  });

  Stock copyWith({
    double? currentPrice,
    double? priceChange,
    double? priceChangePercentage,
    bool? isPositive,
    DateTime? lastUpdated,
  }) {
    return Stock(
      symbol: symbol,
      name: name,
      currentPrice: currentPrice ?? this.currentPrice,
      priceChange: priceChange ?? this.priceChange,
      priceChangePercentage: priceChangePercentage ?? this.priceChangePercentage,
      isPositive: isPositive ?? this.isPositive,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props => [
        symbol,
        name,
        currentPrice,
        priceChange,
        priceChangePercentage,
        isPositive,
        lastUpdated,
      ];

  @override
  String toString() {
    return 'Stock(symbol: $symbol, name: $name, price: $currentPrice, change: $priceChangePercentage%)';
  }
}
