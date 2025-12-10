import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_colors.dart';
import 'core/theme/app_text_styles.dart';
import 'core/utils/constants.dart';

// Providers
import 'features/weather/business/providers/weather_provider.dart';
import 'features/forecast/business/providers/forecast_provider.dart';
import 'features/smartalert/alert_provider.dart';
import 'features/regionfilter/bussiness/regionprovider.dart';
import 'features/favorites/favourites_provider.dart';
// Screens
import 'features/weather/presentation/screens/home_screen.dart';

void main() {
  runApp(const ClimaSenseApp());
}

class ClimaSenseApp extends StatelessWidget {
  const ClimaSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => ForecastProvider()),
        ChangeNotifierProvider(create: (_) => AlertProvider()),
        ChangeNotifierProvider(create: (_) => RegionProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.softBlue,
            primary: AppColors.softBlue,
            secondary: AppColors.skyBlue,
          ),
          textTheme: const TextTheme(
            displayLarge: AppTextStyles.heading1,
            displayMedium: AppTextStyles.heading2,
            headlineMedium: AppTextStyles.heading3,
            bodyLarge: AppTextStyles.body1,
            bodyMedium: AppTextStyles.body2,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.deepPurple,
            foregroundColor: Colors.white,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
