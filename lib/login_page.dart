
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:get/get.dart';
import 'package:my_flutter_sample_login_page_with_aws/app_routes.dart';
import 'package:my_flutter_sample_login_page_with_aws/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginPressed() async {
    Amplify.Auth.signOut();
    if (_formKey.currentState!.validate()) {
    
      try {
        final email = _emailController.text.trim();
        final password = _passwordController.text.trim();
        SignInResult signInResult = await Amplify.Auth.signIn(
          username: email,
          password: password,
        );
      
    
        if (signInResult.isSignedIn) {
          // Login successful, navigate to the home screen
          Navigator.pushNamed(context, AppRoute.homePage);
          // Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
          
          
          //print("Login Successful");
        } else {
          // Handle unsuccessful login
          // e.g., show an error message
          Get.showSnackbar(const GetSnackBar(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(16),
            borderRadius: 15,
            title: "Error",
            message: "User Doesn't Exist",
            backgroundColor: Color(0xFF24A4C4),
            icon: Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
            duration: Duration(seconds: 3),
            dismissDirection: DismissDirection.horizontal,
          ));
          // print('Login failed');
          Get.snackbar(
            'Message',
            "Error",
            duration: const Duration(seconds: 3),
          );
          //print('Login successful!');
          // Handle successful login
        }
      }on AuthException catch (e) {
        print('Error during login: $e');
        // Get.showSnackbar(mySnackBar(title: "Error", message: '${e.message}'));
        Get.snackbar(
            'Title',
          ' ${e.message}',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.teal,
          colorText: Colors.white,
          borderRadius: 10.0,
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          animationDuration: const Duration(milliseconds: 300),
          forwardAnimationCurve: Curves.easeOut,
          reverseAnimationCurve: Curves.easeIn,
          isDismissible: true,
          showProgressIndicator: true,
          progressIndicatorBackgroundColor: Colors.black54,
          progressIndicatorValueColor:
              const AlwaysStoppedAnimation<Color>(Colors.white),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          hintText: "",
                          labelText: "Email",
                          labelStyle: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                          suffixIcon: Icon(
                            Icons.star,
                            color: Colors.red,
                            size: 0,
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF24A4C4), width: 2.0))),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: "",
                          labelText: "Password",
                          labelStyle: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isHidden = !_isHidden;
                                });
                              },
                              child: _isHidden
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    )
                                  : const Icon(Icons.visibility,
                                      color: Colors.grey)),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF24A4C4), width: 2.0))),
                      keyboardType: TextInputType.text,
                      obscureText: _isHidden,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed:  _loginPressed,
                      child: const Text(
                        "LOGIN",
                        style:
                            TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ]),
                ))),
      ),
    );
  }
}

