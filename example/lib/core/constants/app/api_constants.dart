/// API-related constants
/// These are necessary for JSON parsing and API communication
class ApiConstants {
  // JSON field names
  static const String success = 'success';
  static const String status = 'status';
  static const String message = 'message';
  static const String statusCode = 'status_code';
  static const String data = 'data';
  static const String error = 'error';

  // API status values
  static const String statusSuccess = 'success';
  static const String statusError = 'error';
  static const String statusFailed = 'failed';

  // Common API field names
  static const String id = 'id';
  static const String name = 'name';
  static const String phone = 'phone';
  static const String avatar = 'avatar';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';

  // Scan-related API fields
  static const String scanType = 'scan_type';
  static const String scanData = 'scan_data';
  static const String scanResult = 'scan_result';
  static const String timestamp = 'timestamp';

  // Scan types
  static const String thermal = 'thermal';
  static const String ultrasonic = 'ultrasonic';
  static const String magnetic = 'magnetic';
  static const String optical = 'optical';
  static const String pressure = 'pressure';

  // Scan status
  static const String scanSuccess = 'success';
  static const String scanWarning = 'warning';

  // Scan data fields
  static const String temperature = 'temperature';
  static const String humidity = 'humidity';
  static const String pressureValue = 'pressure';
  static const String vibration = 'vibration';
  static const String frequency = 'frequency';
  static const String amplitude = 'amplitude';
  static const String coordinates = 'coordinates';
  static const String x = 'x';
  static const String y = 'y';
  static const String z = 'z';
  static const String quality = 'quality';
  static const String confidence = 'confidence';

  // Metadata fields
  static const String deviceModel = 'deviceModel';
  static const String firmwareVersion = 'firmwareVersion';
  static const String batteryLevel = 'batteryLevel';
  static const String signalStrength = 'signalStrength';
  static const String calibrationStatus = 'calibrationStatus';
  static const String scanDuration = 'scanDuration';

  // Calibration status values
  static const String calibrated = 'calibrated';
  static const String needsCalibration = 'needs_calibration';

  // Error messages for API responses
  static const String unknownError = 'Unknown error occurred';
  static const String parseError = 'Failed to parse response';
  static const String networkError = 'Network error occurred';
  static const String serverError = 'Server error occurred';

  // HTTP headers
  static const String contentType = 'Content-Type';
  static const String accept = 'Accept';
  static const String applicationJson = 'application/json';
  static const String bearerPrefix = 'Bearer ';
}
