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
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // Editing Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController expertiseController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController registrationController = TextEditingController();

  String selectedRole = 'student';
  String selectedBatch = 'Batch 1';
  bool isLoading = false;

  final List<String> batchOptions = [
    'Batch 1',
    'Batch 2',
    'Batch 3',
    'Batch 4',
    'Batch 5',
  ];

  Widget _buildRoleSpecificFields() {
    switch (selectedRole) {
      case 'mentor':
      return Column(
        children: [
          CustomTextField(
            controller: fullNameController,   // Full name box
            lable: 'Full Name', 
            icon: Icons.person
          ),
          SizedBox(height: 16,),
          CustomTextField(
            controller: expertiseController, 
            lable: 'Area of Expertise',     // Expertise box
            icon: Icons.school
          )
        ],
      );
      case 'student':
      return Column(
        children: [
          CustomTextField(controller: fullNameController, lable: 'Full Name', icon: Icons.person),  // Full name box
          SizedBox(height: 16,),
          DropdownButtonFormField<String>(
            value: selectedBatch,
            items: batchOptions
              .map ((batch) => 
                DropdownMenuItem(value: batch, child: Text(batch))).toList(), 
            onChanged: (value) => setState(() => selectedBatch = value!),
            decoration: InputDecoration(
              labelText: 'Batch',
              prefixIcon: Icon(Icons.group),
              hoverColor: Colors.blue,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              )
            ),
          ),
          SizedBox(height: 16,),
          CustomTextField(controller: studentIdController, lable: 'SrudentID', icon: Icons.perm_identity),
          SizedBox(height: 16,),
          CustomTextField(controller: registrationController, lable: 'Registration Number', icon: Icons.confirmation_number),

        ],
      );
      case 'admin':         
      return Column(
        children: [
          CustomTextField(controller: fullNameController, lable: 'Admin Name', icon: Icons.admin_panel_settings)
        ],
      );
      default:
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4FC3F7), Color(0xFF0288D1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.height),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.app_registration, size: 80, color: Colors.white,),
                    SizedBox(height: 10,),
                    Text(
                      'Create Your Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 30,),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      ),
                      elevation: 6,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: emailController, 
                              lable: 'Email', 
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            CustomTextField(
                              controller: passController, 
                              lable: 'Password', 
                              icon: Icons.lock,
                              obscureText: true,
                            ),
                            SizedBox(height: 16,),
                            DropdownButtonFormField(
                              value: selectedRole,
                              items: [
                                DropdownMenuItem(value: 'student', child: Text('Student'),),
                                DropdownMenuItem(value: 'mentor', child: Text('Mentor'),),
                                DropdownMenuItem(value: 'admin', child: Text('Admin',),),
                              ], 
                              onChanged: (value) => setState(() => selectedRole = value!),
                              decoration: InputDecoration(
                                labelText: 'Select Role',
                                prefixIcon: Icon(Icons.person_outline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )
                              ),
                            ),
                            SizedBox(height: 16,),
                            _buildRoleSpecificFields(),
                            SizedBox(height: 24,),
                            Button(text: 'Register', onPressed: () {}),
                            SizedBox(height: 12,),
                            TextButton(onPressed: () {}, child: Text(
                              'Already have an account? Sign In'
                            ))
                          ],
                        ),  
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String lable;
  final IconData icon;
  const CustomTextField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.lable,
    required this.icon
  });

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
          borderSide: BorderSide(color: Colors.blue, width: 2)
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
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  const Button({super.key, required this.text, required this.onPressed, this.isLoading = false, this.backgroundColor = const Color(0xFF0288D1), this.textColor = Colors.white  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor
        ),
        onPressed: isLoading ? null : onPressed, 
        child: isLoading ? CircularProgressIndicator() : Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}