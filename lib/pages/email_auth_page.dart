import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chatapp/components/auth_text_field.dart';
import 'package:chatapp/constant/app_colors.dart';
import 'package:chatapp/constant/app_typography.dart';
import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/services/auth/auth_provider.dart';

class EmailAuthPage extends StatefulWidget {
  const EmailAuthPage({super.key});

  @override
  State<EmailAuthPage> createState() => _EmailAuthPageState();
}

class _EmailAuthPageState extends State<EmailAuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isRegisterMode = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.clearError();

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (_isRegisterMode) {
      await authProvider.registerWithEmail(email: email, password: password);
    } else {
      await authProvider.signInWithEmail(email: email, password: password);
    }

    if (!mounted) return;

    if (authProvider.isAuthenticated) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;

    final authProvider = Provider.of<AuthProvider>(context);
    final isLoading = authProvider.isLoading;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          _isRegisterMode ? 'Create account' : 'Sign in',
          style: AppTypography.titleLarge(
            color: textColor,
            fontWeight: AppTypography.fontWeightBold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isRegisterMode
                      ? 'Create an account using your email and password.'
                      : 'Sign in using your email and password.',
                  style: AppTypography.bodyMedium(
                    color: textColor.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 24),
                AuthTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'name@example.com',
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  enabled: !isLoading,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'Email is required';
                    if (!v.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  autofillHints: _isRegisterMode
                      ? const [AutofillHints.newPassword]
                      : const [AutofillHints.password],
                  enabled: !isLoading,
                  obscureText: _obscurePassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: isLoading
                        ? null
                        : () => setState(() {
                              _obscurePassword = !_obscurePassword;
                            }),
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                  validator: (value) {
                    final v = value ?? '';
                    if (v.isEmpty) return 'Password is required';
                    if (_isRegisterMode && v.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => _submit(),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: isLoading ? null : _submit,
                    child: Text(_isRegisterMode ? 'Create account' : 'Sign in'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: isLoading
                        ? null
                        : () => setState(() {
                              _isRegisterMode = !_isRegisterMode;
                            }),
                    child: Text(
                      _isRegisterMode
                          ? 'Already have an account? Sign in'
                          : 'New here? Create an account',
                      style: AppTypography.bodyMedium(
                        color: colorScheme.primary,
                        fontWeight: AppTypography.fontWeightMedium,
                      ),
                    ),
                  ),
                ),
                if (isLoading) ...[
                  const SizedBox(height: 16),
                  const Center(child: CircularProgressIndicator()),
                ],
                if (authProvider.error != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: colorScheme.error,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            authProvider.error!.message,
                            style: AppTypography.bodySmall(
                              color: colorScheme.onErrorContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
