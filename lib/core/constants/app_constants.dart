class AppConstants {
  AppConstants._();

  // App info
  static const String appName = 'LaundryFull';
  static const String appVersion = '1.0.0';

  // Database
  static const String databaseName = 'laundry_full.db';
  static const int databaseVersion = 1;

  // Invoice
  static const String defaultInvoicePrefix = 'LNDR';
  static const int invoiceNumberLength = 4;

  // Default Values
  static const int defaultServiceDuration = 3; // days
  static const String defaultPaymentMethod = 'cash';

  // Pagination
  static const int defaultPageSize = 20;
  static const int recentOrdersLimit = 5;

  // Date and time formats
  static const String dateFormat = 'dd MMM yyyy';
  static const String dateTimeFormat = 'dd MMM yyyy HH:mm';
  static const String dateFormatShort = 'dd/MM/yy';
  static const String timeFormat = 'HH:mm';
  static const String invoiceDateFormat = 'yyMMdd';

  // Printer
  static const int printerPaperWidth = 58; // mm
  static const int printerCharPerLine = 32;

  // Validation limits
  static const int minPasswordLength = 6;
  static const int maxNameLength = 100;
  static const int maxPhoneLength = 15;
  static const int maxNotesLength = 500;

  // Default admin credentials for the first local database seed.
  static const String defaultOwnerUsername = 'Owner';
  static const String defaultOwnerName = 'Ownerlaundry';
  static const String defaultOwnerPassword = 'owner123';
  static const String defaultAdminRole = '';

  // Settings keys
  // static const String settingLaundryName = 'laundry_name';
  // static const String settingLaundryAddress = 'laundry_address';
  // static const String settingLaundryPhone = 'laundry_phone';
  // static const String settingOnboardingCompleted = 'onboarding_completed';

  static const String keyLaundryName = 'laundry_name';
  static const String keyLaundryAddress = 'laundry_address';
  static const String keyLaundryPhone = 'laundry_phone';
  static const String keyInvoicePrefix = 'invoice_prefix';
  static const String keyPrinterAddress = 'printer_address';
  static const String keyLastInvoiceDate = 'last_invoice_date';
  static const String keyLastInvoiceNumber = 'last_invoice_number';

  // Default laundry information
  static const String defaultLaundryName = 'LaundryFull';
  static const String defaultLaundryAddress =
      'Jalan Agung Timur, Mojosongo, Jateng';
  static const String defaultLaundryPhone = '0812345642285';
}
