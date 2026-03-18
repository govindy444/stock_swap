import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/stock_repository.dart';
import 'presentation/bloc/watchlist_bloc.dart';
import 'presentation/screens/watchlist_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF121212),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  final prefs = await SharedPreferences.getInstance();
  
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({
    super.key,
    required this.prefs,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<StockRepository>(
      create: (context) => StockRepositoryImpl(prefs),
      child: BlocProvider<WatchlistBloc>(
        create: (context) => WatchlistBloc(
          stockRepository: context.read<StockRepository>(),
        ),
        child: MaterialApp(
          title: 'TradeWatch',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          home: const WatchlistScreen(),
        ),
      ),
    );
  }
}
