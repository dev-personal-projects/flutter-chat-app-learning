import 'package:chatapp/auth/auth_service.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  //on tap function to toggle the page between login and register
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //email and password controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //auth service instance
  final AuthService _authService = AuthService();

  //loading state
  bool _isLoading = false;

  //login method
  void login(BuildContext context) async {
    // Show loading indicator
    setState(() {
      _isLoading = true;
    });

    try {
      // Get email and password from controllers
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      // Validate inputs
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all fields'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Attempt to sign in
      await _authService.signInWithEmailAndPassword(email, password);

      // Success - user is signed in
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );
        // TODO: Navigate to home page or chat page
      }
    } catch (e) {
      // Handle errors
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst('Exception: ', '')),
            backgroundColor: Colors.red,
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
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
            "Welcome back, You've been missed!",
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

          // //forgot password?
          // TextButton(

          //     onPressed: () {},
          //     child: Text(
          //       "Forgot Password?",
          //       style: TextStyle(
          //         color: Theme.of(context).colorScheme.primary,
          //         fontSize: 16,
          //       ),
          //     ))
          const SizedBox(height: 20),
          //sign in button
          _isLoading
              ? const CircularProgressIndicator()
              : MyButton(
                  text: "Sign In",
                  onTap: () => login(context),
                ),
          //o,r continue with
          //google sign in
          //not a member? register now
          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  "Register now",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )

          //register now button
        ],
      ),
    );
  }
}
