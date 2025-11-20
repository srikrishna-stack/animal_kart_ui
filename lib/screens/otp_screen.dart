import 'dart:io';
import 'package:animal_kart_demo2/routes/routes.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  

  const OtpScreen({super.key,});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();

  String deviceId = "";
  String deviceModel = "";
  bool isOtpValid = false; // 🔥 Controls button enable

  @override
  void initState() {
    super.initState();
    getDeviceInfo();
  }

  Future<void> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;
      setState(() {
        deviceId = android.id ?? "";
        deviceModel = android.model ?? "";
      });
    } else if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;
      setState(() {
        deviceId = ios.identifierForVendor ?? "";
        deviceModel = ios.utsname.machine ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----- BACK BUTTON -----
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(height: 10),

              // ---- TITLE ----
              Text(
                "Please enter the code we just sent to",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                "(+91) 123456789",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // ---- OTP INPUT ----
              Center(
                child: Pinput(
                  controller: otpController,
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  onChanged: (value) {
                    setState(() {
                      isOtpValid = value.length == 6;
                    });
                  },
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Resend OTP",
                    style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: Colors.black),
                  ),
                ),
              ),

              const Spacer(),

              // ---- CONTINUE BUTTON ----
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: isOtpValid
                      ? () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.profileForm);
                        }
                      : null, // Disabled when invalid
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isOtpValid
                        ? const Color(0xFF57BE82)
                        : Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
