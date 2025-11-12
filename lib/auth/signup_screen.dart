import 'package:flutter/material.dart';

// ---------------- SIGNUP SCREEN ----------------
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool? agree = true;
  bool switchValue = false;
  double sliderValue = 20;
  String gender = "male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup Page")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade700,
              Colors.cyanAccent,
              Colors.blue.shade700,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // ---------------- Form ----------------
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Name"),
                      validator: (value) =>
                          value!.isEmpty ? "Enter name" : null,
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      decoration: const InputDecoration(labelText: "Email"),
                      validator: (value) =>
                          value!.isEmpty ? "Enter email" : null,
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(labelText: "Password"),
                      validator: (value) =>
                          value!.length < 6 ? "Min 6 chars" : null,
                    ),

                    const SizedBox(height: 20),

                    // Checkbox
                    CheckboxListTile(
                      title: const Text("I agree to Terms & Conditions"),
                      value: agree,
                      onChanged: (val) => setState(() => agree = val),
                    ),

                    // Switch
                    SwitchListTile(
                      title: const Text("Receive Notifications"),
                      value: switchValue,
                      onChanged: (val) => setState(() => switchValue = val),
                    ),

                    // Slider
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Age: ${sliderValue.toInt()}"),
                          Slider(
                            value: sliderValue,
                            min: 10,
                            max: 60,
                            divisions: 50,
                            label: sliderValue.toInt().toString(),
                            onChanged: (val) =>
                                setState(() => sliderValue = val),
                          ),
                        ],
                      ),
                    ),

                    // Radio Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: "male",
                          groupValue: gender,
                          onChanged: (val) => setState(() => gender = val!),
                        ),
                        const Text("Male"),

                        Radio(
                          value: "female",
                          groupValue: gender,
                          onChanged: (val) => setState(() => gender = val!),
                        ),
                        const Text("Female"),

                        Radio(
                          value: "custom",
                          groupValue: gender,
                          onChanged: (val) => setState(() => gender = val!),
                        ),
                        const Text("Custom"),
                      ],
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() && agree!) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Signup Successful!"),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      child: const Text("Sign Up"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ---------------- GridView Example ----------------
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true, // ✅ Important
                physics: const NeverScrollableScrollPhysics(), // ✅ Important
                children: List.generate(12, (index) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    color: index < 3
                        ? Colors.red
                        : index < 6
                        ? Colors.green
                        : index < 9
                        ? Colors.pinkAccent
                        : Colors.yellow,
                    child: Center(child: Text("Box ${index + 1}")),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
