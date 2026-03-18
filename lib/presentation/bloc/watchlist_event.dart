import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/stock.dart';


@immutable
abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object?> get props => [];
}

class LoadWatchlist extends WatchlistEvent {
  const LoadWatchlist();
}


class ReorderStock extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  const ReorderStock({
    required this.oldIndex,
    required this.newIndex,
  });

  @override
  List<Object?> get props => [oldIndex, newIndex];
}

class UpdateStockPrices extends WatchlistEvent {
  const UpdateStockPrices();
}

class RefreshWatchlist extends WatchlistEvent {
  const RefreshWatchlist();
}
