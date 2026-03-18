import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/stock.dart';


@immutable
abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object?> get props => [];
}

class WatchlistInitial extends WatchlistState {
  const WatchlistInitial();
}

class WatchlistLoading extends WatchlistState {
  const WatchlistLoading();
}

class WatchlistLoaded extends WatchlistState {
  final List<Stock> stocks;
  final DateTime lastUpdated;

  const WatchlistLoaded({
    required this.stocks,
    required this.lastUpdated,
  });

  WatchlistLoaded copyWith({
    List<Stock>? stocks,
    DateTime? lastUpdated,
  }) {
    return WatchlistLoaded(
      stocks: stocks ?? this.stocks,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props => [stocks, lastUpdated];
}

class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object?> get props => [message];
}
