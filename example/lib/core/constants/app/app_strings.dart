/// Centralized strings for the application
/// This prevents hardcoded strings in UI components
class AppStrings {
  // Common strings
  static const String submit = 'Submit';
  static const String cancel = 'Cancel';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String add = 'Add';
  static const String remove = 'Remove';
  static const String search = 'Search';
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String success = 'Success';
  static const String warning = 'Warning';
  static const String info = 'Information';

  // Navigation
  static const String home = 'Home';
  static const String profile = 'Profile';
  static const String settings = 'Settings';
  static const String bookings = 'Bookings';
  static const String history = 'History';

  // Scan related strings
  static const String scan = 'Scan';
  static const String scanControls = 'Scan Controls';
  static const String scanType = 'Scan Type';
  static const String startScan = 'Start Scan';
  static const String scanning = 'Scanning...';
  static const String latestScanResult = 'Latest Scan Result';
  static const String scanHistory = 'Scan History';
  static const String noScanHistory =
      'No scan history available.\nStart a scan to see results here.';
  static const String scanCompletedSuccessfully =
      'Scan completed successfully!';
  static const String scanResultDeletedSuccessfully =
      'Scan result deleted successfully!';
  static const String failedToDeleteScanResult = 'Failed to delete scan result';
  static const String dataPoints = 'Data Points';
  static const String status = 'Status';
  static const String id = 'ID';
  static const String time = 'Time';

  // Error messages
  static const String networkError =
      'Network error. Please check your connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unknownError = 'An unexpected error occurred';
  static const String validationError = 'Please check your input';
  static const String forbiddenError = 'Access denied.';

  // Additional error messages for comprehensive error handling
  static const String timeoutError = 'Request timed out. Please try again.';
  static const String badRequestError =
      'Invalid request. Please check your input.';
  static const String notFoundError = 'Requested resource not found.';
  static const String requestCancelled = 'Request was cancelled.';
  static const String checkConnectionAndRetry =
      'Check your internet connection and try again.';
  static const String tryAgainLater =
      'Server is temporarily unavailable. Please try again later.';
  static const String tryAgainWithBetterConnection =
      'Connection is slow. Please try again with a better connection.';

  // Success messages

  // Validation messages
  static const String nameRequired = 'Name is required';

  // Error handling strings
  static const String retry = 'Retry';
  static const String tryAgain = 'Try Again';
  static const String somethingWentWrong = 'Something went wrong';
  static const String certificateError =
      'Certificate error. Please check your connection.';

  // App specific strings
  static const String appName = 'UltraScan 4D';
  static const String deviceModel = 'UltraScan-4D-Pro';

  // Error messages for services
  static const String failedToPerformScan = 'Failed to perform scan';
  static const String failedToGetScanHistory = 'Failed to get scan history';

  // Debug messages
  static const String scanRequest = 'Scan Request';
  static const String scanResponse = 'Scan Response';

  // Date formats
  static const String dateTimeFormat = 'MMM dd, yyyy - HH:mm:ss';
}
