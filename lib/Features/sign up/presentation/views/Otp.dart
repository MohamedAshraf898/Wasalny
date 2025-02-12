import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wasalny/constant.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              "تأكيد رقم الهاتف",
              style: GoogleFonts.cairo(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              "أدخل رمز التحقق (OTP)",
              style: GoogleFonts.cairo(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Directionality(
              textDirection:
                  TextDirection.ltr, // Ensures OTP input is left-to-right
              child: PinCodeTextField(
                appContext: context,
                length: 5,
                keyboardType: TextInputType.number,
                textStyle: GoogleFonts.cairo(fontSize: 20),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeColor: kPrimaryColor,
                  inactiveColor: Colors.grey,
                  selectedColor: kPrimaryColor,
                ),
                controller: otpController,
                onChanged: (value) {},
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "أعد الإرسال مرة أخرى",
                    style:
                        GoogleFonts.cairo(fontSize: 16, color: kPrimaryColor),
                  ),
                ),
                Text(
                  " لم يصلك الرمز؟",
                  style: GoogleFonts.cairo(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: OTP verification logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "تحقق",
                  style: GoogleFonts.cairo(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
