import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF4FC3F7), Color(0xFF0288D1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter          
          )
        ),
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: size.height),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.school, size: 80, color: Colors.white,),
                SizedBox(height: 10,),
                Text(
                  'Welcome to Class Companion',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 30,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CustomTextFeild(
                          controller: emailController, 
                          lable: 'Email', 
                          icon: Icons.email, 
                          keyboardType: TextInputType.emailAddress, 
                          obscureText: false
                        ),
                        SizedBox(height: 16,),
                        CustomTextFeild(
                          controller: passController, 
                          lable: 'Password', 
                          icon: Icons.lock, 
                          obscureText: true,
                        ),
                        SizedBox(height: 24,),
                        Button(
                          onPressed: (){}, 
                          text: 'Login'
                        ),
                        TextButton(onPressed: (){}, child: Text(
                          'Dont have an account? Register'
                        ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}

class CustomTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final String lable;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;
  const CustomTextFeild({super.key, required this.controller, required this.lable, required this.icon, this.keyboardType = TextInputType.text, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(icon, color: Colors.blue,),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue, width: 2)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue, width: 2)
        )
      ),
    );
  }
}

class Button extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onPressed;
  final bool inloading;
  final String text;
  const Button({
    super.key,
    this.backgroundColor = const Color(0xFF0288D1),
    this.textColor = Colors.white,
    required this.onPressed,
    this.inloading = false,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          )
        ),

        onPressed: inloading ? null : onPressed, 
        child: inloading ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2,) : 
        Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        )
      ),
    );
  }
}