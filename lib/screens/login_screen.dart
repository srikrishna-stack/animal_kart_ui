import 'package:animal_kart_demo2/routes/routes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  String countryCode = "+91";

  String? errorText;
  bool isButtonEnabled = false; // 🔥 Controls button state

  // ---------------- VALIDATION ----------------
  bool isValidPhone(String value) {
    return RegExp(r'^[0-9]{10}$').hasMatch(value);
  }

  void validatePhone() {
    final phone = phoneController.text.trim();
    setState(() {
      isButtonEnabled = isValidPhone(phone);
      errorText = null; // Remove error when typing
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // ---------------- HEADER ----------------
                const Text(
                  "Back to the Buffalo Cart\nworld!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Enter your mobile number to continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const SizedBox(height: 40),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Mobile number",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // ---------------- PHONE INPUT ----------------
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),

                      // Country Code Selector
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
                              countryCode,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),

                      // Divider
                      Container(
                        height: 40,
                        width: 1,
                        color: Colors.grey.shade300,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),

                      // Phone Input
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          onChanged: (_) => validatePhone(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counterText: "",
                            hintText: "Enter number",
                            errorText: errorText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // ---------------- INFO TEXT ----------------
                Row(
                  children: [
                    Icon(Icons.info_outline,
                        size: 18, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                    Text(
                      "We'll send a 6-digit code.",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // ---------------- SEND OTP BUTTON ----------------
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: isButtonEnabled
                        ? () {
                            final phone = phoneController.text.trim();

                            if (!isValidPhone(phone)) {
                              setState(() {
                                errorText = "Enter a valid 10-digit number";
                              });
                              return;
                            }

                            // Go to OTP screen
                            Navigator.pushNamed(
                              context,
                              AppRoutes.otp,
                              arguments: phone,
                            );
                          }
                        : null, // Disabled when invalid
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isButtonEnabled
                          ? const Color(0xFF57BE82)
                          : Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Text(
                      "Send OTP",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: isButtonEnabled ? Colors.black : Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
