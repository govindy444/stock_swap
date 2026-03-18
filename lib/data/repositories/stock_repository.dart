import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/stock.dart';
import '../models/stock_model.dart';


abstract class StockRepository {
  Future<List<Stock>> getWatchlist();
  
  Future<void> saveWatchlistOrder(List<String> symbols);
  
  Future<List<Stock>> updateStockPrices(List<Stock> stocks);
  
  Future<List<String>?> getSavedOrder();
}

class StockRepositoryImpl implements StockRepository {
  static const String _watchlistKey = 'watchlist_order';
  static const String _stocksDataKey = 'stocks_data';
  
  final List<StockModel> _sampleStocks = [
    StockModel(
      symbol: 'RELIANCE',
      name: 'Reliance Industries Ltd.',
      currentPrice: 2456.75,
      priceChange: 32.50,
      priceChangePercentage: 1.34,
      isPositive: true,
      lastUpdated: DateTime.now(),
    ),
    StockModel(
      symbol: 'TCS',
      name: 'Tata Consultancy Services',
      currentPrice: 3456.20,
      priceChange: -28.40,
      priceChangePercentage: -0.81,
      isPositive: false,
      lastUpdated: DateTime.now(),
    ),
    StockModel(
      symbol: 'INFY',
      name: 'Infosys Ltd.',
      currentPrice: 1423.65,
      priceChange: 15.30,
      priceChangePercentage: 1.09,
      isPositive: true,
      lastUpdated: DateTime.now(),
    ),
    StockModel(
      symbol: 'HDFCBANK',
      name: 'HDFC Bank Ltd.',
      currentPrice: 1534.90,
      priceChange: -12.75,
      priceChangePercentage: -0.82,
      isPositive: false,
      lastUpdated: DateTime.now(),
    ),
    StockModel(
      symbol: 'ICICIBANK',
      name: 'ICICI Bank Ltd.',
      currentPrice: 945.30,
      priceChange: 18.45,
      priceChangePercentage: 1.99,
      isPositive: true,
      lastUpdated: DateTime.now(),
    ),
    StockModel(
      symbol: 'SBIN',
      name: 'State Bank of India',
      currentPrice: 623.85,
      priceChange: 8.20,
      priceChangePercentage: 1.33,
      isPositive: true,
      lastUpdated: DateTime.now(),
    ),
    StockModel(
      symbol: 'BHARTIARTL',
      name: 'Bharti Airtel Ltd.',
      currentPrice: 876.45,
      priceChange: -5.60,
      priceChangePercentage: -0.63,
      isPositive: false,
      lastUpdated: DateTime.now(),
    ),
    StockModel(
      symbol: 'ITC',
      name: 'ITC Ltd.',
      currentPrice: 423.70,
      priceChange: 6.85,
      priceChangePercentage: 1.64,
      isPositive: true,
      lastUpdated: DateTime.now(),
    ),
    StockModel(
      symbol: 'KOTAKBANK',
      name: 'Kotak Mahindra Bank',
      currentPrice: 1756.25,
      priceChange: -22.15,
      priceChangePercentage: -1.25,
      isPositive: false,
      lastUpdated: DateTime.now(),
    ),
    StockModel(
      symbol: 'LT',
      name: 'Larsen & Toubro Ltd.',
      currentPrice: 2890.50,
      priceChange: 45.30,
      priceChangePercentage: 1.59,
      isPositive: true,
      lastUpdated: DateTime.now(),
    ),
  ];

  final SharedPreferences _prefs;
  final Random _random = Random();

  StockRepositoryImpl(this._prefs);

  @override
  Future<List<Stock>> getWatchlist() async {
    try {
      final savedOrder = await getSavedOrder();
      
      if (savedOrder != null && savedOrder.isNotEmpty) {
        final orderedStocks = <StockModel>[];
        for (final symbol in savedOrder) {
          final stock = _sampleStocks.firstWhere(
            (s) => s.symbol == symbol,
            orElse: () => _sampleStocks.first,
          );
          orderedStocks.add(stock);
        }
        return orderedStocks.map((e) => e.toEntity()).toList();
      }
      
      return _sampleStocks.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to load watchlist: $e');
    }
  }

  @override
  Future<void> saveWatchlistOrder(List<String> symbols) async {
    try {
      await _prefs.setString(_watchlistKey, jsonEncode(symbols));
    } catch (e) {
      throw Exception('Failed to save watchlist order: $e');
    }
  }

  @override
  Future<List<String>?> getSavedOrder() async {
    try {
      final savedData = _prefs.getString(_watchlistKey);
      if (savedData != null) {
        final List<dynamic> decoded = jsonDecode(savedData);
        return decoded.cast<String>();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Stock>> updateStockPrices(List<Stock> stocks) async {
    try {
      return stocks.map((stock) {
        final changePercent = (_random.nextDouble() * 4 - 2);
        final priceChange = stock.currentPrice * (changePercent / 100);
        final newPrice = stock.currentPrice + priceChange;
        
        return stock.copyWith(
          currentPrice: double.parse(newPrice.toStringAsFixed(2)),
          priceChange: double.parse(priceChange.toStringAsFixed(2)),
          priceChangePercentage: double.parse(changePercent.toStringAsFixed(2)),
          isPositive: changePercent >= 0,
          lastUpdated: DateTime.now(),
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to update stock prices: $e');
    }
  }
}
