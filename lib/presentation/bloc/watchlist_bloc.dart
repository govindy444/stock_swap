import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/stock_repository.dart';
import '../../../domain/usecases/get_watchlist.dart';
import '../../domain/entities/stock.dart'; // or correct path
import 'watchlist_event.dart';
import 'watchlist_state.dart';


class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final StockRepository _stockRepository;
  final GetWatchlistUseCase _getWatchlistUseCase;
  
  Timer? _priceUpdateTimer;
  
  static const Duration _priceUpdateInterval = Duration(seconds: 5);

  WatchlistBloc({
    required StockRepository stockRepository,
  })  : _stockRepository = stockRepository,
        _getWatchlistUseCase = GetWatchlistUseCase(stockRepository),
        super(const WatchlistInitial()) {
    on<LoadWatchlist>(_onLoadWatchlist);
    on<ReorderStock>(_onReorderStock);
    on<UpdateStockPrices>(_onUpdateStockPrices);
    on<RefreshWatchlist>(_onRefreshWatchlist);
  }


  Future<void> _onLoadWatchlist(
    LoadWatchlist event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(const WatchlistLoading());
    
    try {
      final stocks = await _getWatchlistUseCase();
      emit(WatchlistLoaded(
        stocks: stocks,
        lastUpdated: DateTime.now(),
      ));
      
      _startPriceUpdates();
    } catch (e) {
      emit(WatchlistError('Failed to load watchlist: ${e.toString()}'));
    }
  }


  Future<void> _onReorderStock(
    ReorderStock event,
    Emitter<WatchlistState> emit,
  ) async {
    final currentState = state;
    
    if (currentState is WatchlistLoaded) {
      try {
        final stocks = List<Stock>.from(currentState.stocks);
        
        if (event.oldIndex < 0 ||
            event.oldIndex >= stocks.length ||
            event.newIndex < 0 || 
            event.newIndex > stocks.length) {
          return;
        }
        
        final stock = stocks.removeAt(event.oldIndex);
        
        final adjustedNewIndex = event.oldIndex < event.newIndex
            ? event.newIndex - 1 
            : event.newIndex;
        
        stocks.insert(adjustedNewIndex, stock);
        
        emit(currentState.copyWith(stocks: stocks));
        
        final symbols = stocks.map((s) => s.symbol).toList();
        await _stockRepository.saveWatchlistOrder(symbols);
      } catch (e) {

        print('Failed to reorder stocks: $e');
      }
    }
  }


  Future<void> _onUpdateStockPrices(
    UpdateStockPrices event,
    Emitter<WatchlistState> emit,
  ) async {
    final currentState = state;
    
    if (currentState is WatchlistLoaded) {
      try {
        final updatedStocks = await _stockRepository.updateStockPrices(
          currentState.stocks,
        );
        
        emit(WatchlistLoaded(
          stocks: updatedStocks,
          lastUpdated: DateTime.now(),
        ));
      } catch (e) {

        print('Failed to update prices: $e');
      }
    }
  }

  Future<void> _onRefreshWatchlist(
    RefreshWatchlist event,
    Emitter<WatchlistState> emit,
  ) async {
    final currentState = state;
    
    if (currentState is WatchlistLoaded) {
      try {
        final stocks = await _getWatchlistUseCase();
        emit(WatchlistLoaded(
          stocks: stocks,
          lastUpdated: DateTime.now(),
        ));
      } catch (e) {
        emit(WatchlistError('Failed to refresh: ${e.toString()}'));
      }
    } else {
      add(const LoadWatchlist());
    }
  }

  void _startPriceUpdates() {
    _priceUpdateTimer?.cancel();
    _priceUpdateTimer = Timer.periodic(
      _priceUpdateInterval,
      (_) => add(const UpdateStockPrices()),
    );
  }

  void _stopPriceUpdates() {
    _priceUpdateTimer?.cancel();
    _priceUpdateTimer = null;
  }

  @override
  Future<void> close() {
    _stopPriceUpdates();
    return super.close();
  }
}
