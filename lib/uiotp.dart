import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  String? _verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Authentication')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            ElevatedButton(
              onPressed: () => _verifyPhoneNumber(),
              child: Text('Verify'),
            ),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'Verification Code'),
            ),
            ElevatedButton(
              onPressed: () => _signInWithPhoneNumber(),
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }

  void _verifyPhoneNumber() async {
    await _authService.verifyPhoneNumber(
      _phoneController.text,
          (PhoneAuthCredential credential) async {
        // Automatic verification completed
        await _authService.signInWithPhoneNumber(
          credential.verificationId!,
          credential.smsCode!,
        );
      },
          (FirebaseAuthException e) {
        print('Failed to verify phone number: ${e.message}');
      },
          (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
        });
      },
          (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  void _signInWithPhoneNumber() async {
    await _authService.signInWithPhoneNumber(
      _verificationId!,
      _codeController.text,
    );
  }
}
