import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/home_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/scan/scan_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/otp_screen.dart';
import '../../features/auth/auth_provider.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/results/results_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authStatus = ref.watch(authProvider).status;

  return GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/scan',
        builder: (context, state) {
          final category = state.extra as String? ?? 'General';
          return ScanScreen(category: category);
        },
      ),
      GoRoute(
        path: '/results',
        builder: (context, state) {
          final category = state.extra as String? ?? 'General';
          return ResultsScreen(category: category);
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
    redirect: (context, state) {
      final loggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/otp';
      final inOnboarding = state.matchedLocation == '/onboarding';

      if (authStatus == AuthStatus.unauthenticated) {
        if (loggingIn || inOnboarding) return null;
        return '/login';
      }

      if (authStatus == AuthStatus.otpPending) {
        if (state.matchedLocation == '/otp') return null;
        return '/otp';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (loggingIn || inOnboarding) return '/';
      }

      return null;
    },
  );
});
