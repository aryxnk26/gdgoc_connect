import 'package:flutter/material.dart';
import '../../state/app_state.dart';
import '../../theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController(text: 'Alex Rivera');
  String _selectedRole = 'Campus Member';

  final List<String> _demoRoles = [
    'Campus Member',
    'Core Team - Tech',
    'Core Team - Design',
    'Core Team - Operations',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    final state = AppStateScope.of(context);
    state.loginAsDemoUser(
      name: _nameController.text,
      role: _selectedRole,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Brand Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 12, height: 12, decoration: const BoxDecoration(color: AppTheme.googleBlue, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Container(width: 12, height: 12, decoration: const BoxDecoration(color: AppTheme.googleRed, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Container(width: 12, height: 12, decoration: const BoxDecoration(color: AppTheme.googleYellow, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Container(width: 12, height: 12, decoration: const BoxDecoration(color: AppTheme.googleGreen, shape: BoxShape.circle)),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'GDGoC Connect',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -0.5),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Google Developer Groups on Campus Hub',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 28),

                // Notice Banner
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.googleBlue.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.googleBlue.withValues(alpha: 0.2)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: AppTheme.googleBlue, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Demo Mode: Simulated sign-in with local state. No real backend or Google Account required.',
                          style: TextStyle(fontSize: 12, color: Color(0xFF1F2937)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  initialValue: _selectedRole,
                  decoration: InputDecoration(
                    labelText: 'Community Role',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.badge_outlined),
                  ),
                  items: _demoRoles.map((role) {
                    return DropdownMenuItem(value: role, child: Text(role));
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedRole = val);
                  },
                ),
                const SizedBox(height: 24),

                FilledButton(
                  onPressed: _handleSignIn,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Enter Workspace', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    _nameController.text = 'Guest Developer';
                    _selectedRole = 'Campus Member';
                    _handleSignIn();
                  },
                  child: const Text('Skip & Continue as Guest'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}