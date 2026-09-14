class AppConstants {
  AppConstants._();

  // App info
  static const String appName = 'LaundryFull';
  static const String appVersion = '1.0.0';

  // Database
  static const String databaseName = 'laundry_full.db';
  static const int databaseVersion = 1;

  // Invoice
  static const String invoicePrefix = 'LNDR';
  static const int invoiceSequenceLength = 4;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Date and time formats
  static const String dateFormat = 'dd MMM yyyy';
  static const String dateTimeFormat = 'dd MMM yyyy, HH:mm';
  static const String databaseDateFormat = 'yyyy-MM-dd';
  static const String databaseDateTimeFormat = 'yyyy-MM-dd HH:mm:ss';

  // Thermal printer
  static const int thermalPaperCharacters = 32;
  static const int bluetoothScanDurationSeconds = 10;

  // Validation limits
  static const int minPasswordLength = 6;
  static const int maxNameLength = 100;
  static const int maxPhoneLength = 15;
  static const int maxNotesLength = 500;

  // Default admin credentials for the first local database seed.
  static const String defaultAdminUsername = 'admin';
  static const String defaultAdminName = 'Administrator';
  static const String defaultAdminRole = 'owner';

  // Settings keys
  static const String settingLaundryName = 'laundry_name';
  static const String settingLaundryAddress = 'laundry_address';
  static const String settingLaundryPhone = 'laundry_phone';
  static const String settingOnboardingCompleted = 'onboarding_completed';

  // Default laundry information
  static const String defaultLaundryName = 'LaundryFull';
  static const String defaultLaundryAddress = '';
  static const String defaultLaundryPhone = '';
}
