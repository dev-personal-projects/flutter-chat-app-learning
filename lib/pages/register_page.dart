import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/auth/auth_exceptions.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers should be in State class, not StatefulWidget
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  //auth service instance
  final AuthService _authService = AuthService();

  //loading state
  bool _isLoading = false;

  // Register method should be in State class
  Future<void> register(BuildContext context) async {
    // Show loading indicator
    setState(() {
      _isLoading = true;
    });

    try {
      // Get email and password from controllers
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final confirmPassword = _confirmPasswordController.text.trim();

      // Validate inputs
      if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all fields'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Validate password match
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Attempt to sign up
      await _authService.signUpWithEmailAndPassword(email, password);

      // Success - user account created
      if (context.mounted) {
        // Sign out the user immediately after registration
        // This ensures they need to log in explicitly
        await _authService.signOut();

        // Check if context is still valid after async operation
        if (!context.mounted) return;

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully! Please log in.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        // Clear form fields
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();

        // Navigate to login page by calling onTap (which toggles to login)
        // Wait a moment for the snackbar to show
        await Future.delayed(const Duration(milliseconds: 500));
        if (context.mounted && widget.onTap != null) {
          widget.onTap!();
        }
      }
    } catch (e) {
      // Handle errors with user-friendly messages
      if (context.mounted) {
        final errorMessage = e is AuthException
            ? e.message
            : 'An unexpected error occurred. Please try again.';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    } finally {
      // Hide loading indicator
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 30),

              Text(
                "Let's create an account for you!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 20),
              //email textfield
              MyTextfield(
                hintText: "Email",
                obscureText: false,
                controller: _emailController,
              ),
              const SizedBox(height: 8),
              //password textfield
              MyTextfield(
                hintText: "Password",
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 8),
              //confirm password textfield
              MyTextfield(
                hintText: "Confirm Password",
                obscureText: true,
                controller: _confirmPasswordController,
              ),

              const SizedBox(height: 20),
              //sign in button
              _isLoading
                  ? const CircularProgressIndicator()
                  : MyButton(
                      text: "Register",
                      onTap: () => register(context),
                    ),
              //o,r continue with
              //google sign in
              //not a member? register now
              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Login now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              //register now button
              const SizedBox(height: 30), // Extra space at bottom for scrolling
            ],
          ),
        ),
      ),
    );
  }
}
