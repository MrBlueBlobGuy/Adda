// login_screen.dart
import 'package:Adda/pages/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'signup_page.dart';
// Add this import statement for jsonEncode

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // Call backend API to login
        final response = await http.post(
          Uri.parse(  'http://covertocover.tech/users/login'), // Add API endpoint
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'email': _email,
            'password': _password,
          }),
        );

        if (response.statusCode == 200) {
          // Login successful, navigate to contact screen
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ContactScreen(
                    getContacts:
                        _getContacts)), // Pass a function that retrieves contacts
          );
        } else {
          // Login failed, show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid email or password')),
          );
        }
      } catch (e) {
        // Handle any exceptions that occur during the login process
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred during login')),
        );
      }
    }
  }

  // Define the _getContacts function
  Future<List<Contact>> _getContacts() async {
    // Implement your logic to retrieve contacts from the backend API or local database
    // Return a list of contacts
    // For demonstration purposes, return an empty list
    return Future.value([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Login'),
                  onPressed: () async {
                    await _login();
                  },
                ),
                TextButton(
                  child: Text('Dont have an account? Sign up'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}