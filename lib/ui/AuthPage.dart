import 'package:flutter/material.dart';
import 'package:tf1/ui/DashboardPage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showSignIn = false;

  final _signInFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();

  final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+\$');
  final _passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}\$');

  void _navigateToDashboard() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardPage()),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sign In Section
          Expanded(flex: 2,
            child: Container( color: Colors.green.shade900,
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Welcome Back!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,color: Colors.white),),
                  SizedBox(height: 20,),
                  const Text('To keep connect with us please login with your personal info', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal,
                      color: Colors.white,),textAlign: TextAlign.center,),
                  const SizedBox(height: 20),
                  SizedBox(height: 45,width: 180,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side:
                      BorderSide(color: Colors.white)),),
                      onPressed: () {
                          setState(() {
                            showSignIn = showSignIn ? false : true;
                          });
                      },
                      child: Text(showSignIn ?'Sign Up' : 'Sign In',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sign Up Section
          Expanded(flex: 3,
            child: Container( color: Colors.white,
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: showSignIn ? _signInFormKey : _signUpFormKey,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text( showSignIn ? 'Sign In' : 'Sign Up', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 20),
                    SizedBox(width: 280,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Username', border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green.shade900))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(width: 280,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green.shade900))),
                        keyboardType: TextInputType.emailAddress,validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // else if (!_emailRegex.hasMatch(value)) {
                        //   return 'Enter a valid email';
                        // }
                        return null;
                      },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(width: 280,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder(),focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green.shade900))),
                        obscureText: true,validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        // else if (!_passwordRegex.hasMatch(value)) {
                        //   return 'Password must be at least 8 characters \ncontain letters and numbers \n and special character';
                        // }
                        return null;
                      },
                      ),
                    ),
                    const SizedBox(height: 20),
                    showSignIn ? SizedBox(height: 0,) :
                    SizedBox(width: 280,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Confirm Password', border: OutlineInputBorder(),focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green.shade900))),
                        obscureText: true,validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        // else()
                        return null;
                      },
                      ),
                    ),
                    showSignIn ? SizedBox(height: 0,) : const SizedBox(height: 20),
                    SizedBox(height: 45,width: 180,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900,shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),side: BorderSide(color: Colors.green.shade900)),),
                        onPressed: () {
                            if(showSignIn){
                              if (_signInFormKey.currentState!.validate()) {
                                _navigateToDashboard();
                              }
                            }else{
                              if (_signUpFormKey.currentState!.validate()) {
                                _navigateToDashboard();
                              }
                            }
                        },
                        child:  Text(showSignIn ? 'Sign In' : 'Sign Up',style: TextStyle(color: Colors.white),)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
