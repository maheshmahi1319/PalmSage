class Environment {
  // App Info
  static const String appName = 'PalmSage';
  static const String appVersion = '1.0.0';
  
  // API Endpoints
  static const String baseApiUrl = 'https://api.palmsage.app/v1';
  
  // Feature Flags
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');
  static const bool enableAnalytics = true;
  static const bool enableCrashlytics = true;
  
  // In-App Purchase IDs
  static const String monthlySubscriptionId = 'com.palmsage.premium.monthly';
  static const String yearlySubscriptionId = 'com.palmsage.premium.yearly';
  
  // AdMob IDs (if applicable)
  static const String admobAppId = 'ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy';
  static const String bannerAdId = 'ca-app-pub-xxxxxxxxxxxxxxxx/yyyyyyyyyy';
  
  // Other Configurations
  static const int maxFreeScans = 3;
  static const int scanCooldownHours = 24;
}
