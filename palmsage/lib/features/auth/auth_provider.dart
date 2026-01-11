import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus {
  unauthenticated,
  otpPending,
  authenticated,
}

class AuthState {
  final AuthStatus status;
  final String? phoneNumber;
  final String? userId;

  AuthState({
    required this.status,
    this.phoneNumber,
    this.userId,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? phoneNumber,
    String? userId,
  }) {
    return AuthState(
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userId: userId ?? this.userId,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState(status: AuthStatus.unauthenticated);
  }

  void sendOtp(String phoneNumber) {
    state = state.copyWith(
      status: AuthStatus.otpPending,
      phoneNumber: phoneNumber,
    );
  }

  bool verifyOtp(String code) {
    if (code == '123456') {
      state = state.copyWith(
        status: AuthStatus.authenticated,
        userId: 'user_mock_123',
      );
      return true;
    }
    return false;
  }

  void logout() {
    state = AuthState(status: AuthStatus.unauthenticated);
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
