import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/app_utils.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_event.dart';
import '../bloc/watchlist_state.dart';
import '../widgets/stock_list_item.dart';


class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistBloc>().add(const LoadWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<WatchlistBloc>().add(const RefreshWatchlist());
            },
          ),
        ],
      ),
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: AppConstants.animationDuration,
            child: _buildContent(state),
          );
        },
      ),
    );
  }

  Widget _buildContent(WatchlistState state) {
    if (state is WatchlistInitial || state is WatchlistLoading) {
      return _buildLoadingState();
    } else if (state is WatchlistLoaded) {
      return _buildLoadedState(state);
    } else if (state is WatchlistError) {
      return _buildErrorState(state.message);
    }
    return const SizedBox.shrink();
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 8,
      itemBuilder: (context, index) {
        return const StockListItemShimmer();
      },
    );
  }

  Widget _buildLoadedState(WatchlistLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<WatchlistBloc>().add(const RefreshWatchlist());
        await Future.delayed(const Duration(milliseconds: 500));
      },
      color: AppTheme.primaryColor,
      backgroundColor: AppTheme.darkCard,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment: Alignment.centerRight,
            child: Text(
              'Last updated: ${AppUtils.formatTime(state.lastUpdated)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textMuted,
              ),
            ),
          ),
          
          Expanded(
            child: ReorderableListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: state.stocks.length,
              onReorder: (oldIndex, newIndex) {
                context.read<WatchlistBloc>().add(
                  ReorderStock(oldIndex: oldIndex, newIndex: newIndex),
                );
              },
              proxyDecorator: (child, index, animation) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Material(
                      elevation: 8,
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      child: child,
                    );
                  },
                  child: child,
                );
              },
              itemBuilder: (context, index) {
                final stock = state.stocks[index];
                return KeyedSubtree(
                  key: ValueKey(stock.symbol),
                  child: StockListItem(
                    stock: stock,
                    onTap: () {
                      _showStockDetails(context, stock);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppTheme.negativeRed.withOpacity(0.7),
            ),
            const SizedBox(height: 16),
            Text(
              'Oops!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<WatchlistBloc>().add(const LoadWatchlist());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  void _showStockDetails(BuildContext context, stock) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    stock.symbol,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                stock.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              const Divider(height: 32),
              _buildDetailRow('Current Price', AppUtils.formatPrice(stock.currentPrice)),
              _buildDetailRow('Price Change', AppUtils.formatPriceChange(stock.priceChange)),
              _buildDetailRow('Change %', AppUtils.formatPercentage(stock.priceChangePercentage)),
              _buildDetailRow('Last Updated', AppUtils.formatTime(stock.lastUpdated)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
