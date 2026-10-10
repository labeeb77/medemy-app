import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenPair {
  const TokenPair({required this.accessToken, required this.refreshToken});
  final String accessToken;
  final String refreshToken;

  factory TokenPair.fromJson(Map<String, dynamic> json) =>
      TokenPair(accessToken: json['accessToken'] as String, refreshToken: json['refreshToken'] as String);
}

/// Where the Medemy tokens live between launches.
abstract class TokenStore {
  Future<TokenPair?> read();
  Future<void> write(TokenPair tokens);
  Future<void> clear();
}

class SecureTokenStore implements TokenStore {
  SecureTokenStore([this._storage = const FlutterSecureStorage()]);
  final FlutterSecureStorage _storage;
  static const _access = 'medemy.accessToken';
  static const _refresh = 'medemy.refreshToken';

  @override
  Future<TokenPair?> read() async {
    final access = await _storage.read(key: _access);
    final refresh = await _storage.read(key: _refresh);
    return access == null || refresh == null ? null : TokenPair(accessToken: access, refreshToken: refresh);
  }

  @override
  Future<void> write(TokenPair tokens) async {
    await _storage.write(key: _access, value: tokens.accessToken);
    await _storage.write(key: _refresh, value: tokens.refreshToken);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _access);
    await _storage.delete(key: _refresh);
  }
}

class InMemoryTokenStore implements TokenStore {
  InMemoryTokenStore([this._tokens]);
  TokenPair? _tokens;

  @override
  Future<TokenPair?> read() async => _tokens;
  @override
  Future<void> write(TokenPair tokens) async => _tokens = tokens;
  @override
  Future<void> clear() async => _tokens = null;
}
