import 'package:equatable/equatable.dart';
import '../../domain/entities/stock.dart';


class StockModel extends Equatable {
  final String symbol;
  final String name;
  final double currentPrice;
  final double priceChange;
  final double priceChangePercentage;
  final bool isPositive;
  final DateTime lastUpdated;

  const StockModel({
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.priceChange,
    required this.priceChangePercentage,
    required this.isPositive,
    required this.lastUpdated,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      currentPrice: (json['currentPrice'] as num).toDouble(),
      priceChange: (json['priceChange'] as num).toDouble(),
      priceChangePercentage: (json['priceChangePercentage'] as num).toDouble(),
      isPositive: json['isPositive'] as bool,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'currentPrice': currentPrice,
      'priceChange': priceChange,
      'priceChangePercentage': priceChangePercentage,
      'isPositive': isPositive,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  Stock toEntity() {
    return Stock(
      symbol: symbol,
      name: name,
      currentPrice: currentPrice,
      priceChange: priceChange,
      priceChangePercentage: priceChangePercentage,
      isPositive: isPositive,
      lastUpdated: lastUpdated,
    );
  }

  factory StockModel.fromEntity(Stock stock) {
    return StockModel(
      symbol: stock.symbol,
      name: stock.name,
      currentPrice: stock.currentPrice,
      priceChange: stock.priceChange,
      priceChangePercentage: stock.priceChangePercentage,
      isPositive: stock.isPositive,
      lastUpdated: stock.lastUpdated,
    );
  }

  StockModel copyWith({
    String? symbol,
    String? name,
    double? currentPrice,
    double? priceChange,
    double? priceChangePercentage,
    bool? isPositive,
    DateTime? lastUpdated,
  }) {
    return StockModel(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
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
}
