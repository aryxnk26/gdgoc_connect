import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/main_navigation_shell.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GDGoCConnectRoot());
}

class GDGoCConnectRoot extends StatefulWidget {
  const GDGoCConnectRoot({super.key});

  @override
  State<GDGoCConnectRoot> createState() => _GDGoCConnectRootState();
}

class _GDGoCConnectRootState extends State<GDGoCConnectRoot> {
  late final AppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = AppState();
  }

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      notifier: _appState,
      child: MaterialApp(
        title: 'GDGoC Connect',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const AuthGate(),
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return state.isAuthenticated ? const MainNavigationShell() : const LoginScreen();
  }
}