import 'package:boookie/pages/admin_page.dart';
import 'package:boookie/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("Google Sign-in was cancelled by the user");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Google Sign-in was cancelled by the user"),
          backgroundColor: Colors.black,
        ));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print("Firebase credential has been created and is available");
      await _auth.signInWithCredential(credential);
      print("User has been signed in with firebase");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Login Successful"),
        backgroundColor: Colors.black,
      ));

      // Handle successful login, navigate to another screen
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      print("User navigated to the home screen");
    } on FirebaseAuthException catch (e) {
      print("Firebase Authentication Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Firebase Auth Error : ${e.message}",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ));
    } catch (e) {
      print("Error signing in with Google: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Error signing in with Google: $e",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E251A),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/bookworm_logo.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 10),
            const Text(
              "BookNest",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: _signInWithGoogle,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('images/google.png', width: 30, height: 30),
                      const SizedBox(width: 10),
                      const Text(
                        "Sign in with Google",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminPage()));
                },
                child: const Text(
                  "Admin Login",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
