/// Build-time configuration. Override with `--dart-define=API_BASE_URL=...`.
/// The Android emulator reaches a server on the host machine at http://10.0.2.2:3000.
const apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:3000');
