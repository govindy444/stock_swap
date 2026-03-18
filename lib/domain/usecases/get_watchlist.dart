import '../../data/repositories/stock_repository.dart';
import '../entities/stock.dart';


class GetWatchlistUseCase {
  final StockRepository _repository;

  const GetWatchlistUseCase(this._repository);

  Future<List<Stock>> call() async {
    return await _repository.getWatchlist();
  }
}
