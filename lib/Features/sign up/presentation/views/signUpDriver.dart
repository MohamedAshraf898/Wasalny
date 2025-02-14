import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_picker/country_picker.dart';
import 'package:wasalny/Features/sign%20up/presentation/views/Otp.dart';
import 'package:wasalny/constant.dart';

class Signupdriver extends StatefulWidget {
  const Signupdriver({super.key});

  @override
  _SignupdriverState createState() => _SignupdriverState();
}

class _SignupdriverState extends State<Signupdriver> {
  final _formKey = GlobalKey<FormState>();
  String countryCode = "+20";
  String countryFlag = "🇪🇬"; // Default flag (Egypt)
  bool termsAccepted = false;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      hintText: "أدخل $label",
      hintStyle: GoogleFonts.cairo(fontSize: 14, color: Colors.grey.shade400),
      labelStyle: GoogleFonts.cairo(fontSize: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: kPrimaryColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "أدخل بياناتك",
                    style: GoogleFonts.cairo(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                // First Name
                TextFormField(
                  controller: _firstNameController,
                  decoration: _inputDecoration("الاسم الأول"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "الاسم الأول مطلوب";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Last Name
                TextFormField(
                  controller: _lastNameController,
                  decoration: _inputDecoration("الاسم الأخير"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "الاسم الأخير مطلوب";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Phone Number
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.right,
                        decoration: _inputDecoration("رقم هاتفك المحمول"),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "رقم الهاتف مطلوب";
                          } else if (!RegExp(r'^[0-9]{10,15}$')
                              .hasMatch(value)) {
                            return "الرجاء إدخال رقم هاتف صحيح";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            setState(() {
                              countryCode = "+${country.phoneCode}";
                              countryFlag = country.flagEmoji;
                            });
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 124, 124, 124)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(countryFlag,
                                style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 5),
                            Text(countryCode,
                                style: const TextStyle(fontSize: 16)),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration("البريد الإلكتروني"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "البريد الإلكتروني مطلوب";
                    } else if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(value)) {
                      return "الرجاء إدخال بريد إلكتروني صحيح";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Terms Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          termsAccepted = value!;
                        });
                      },
                      activeColor: kPrimaryColor,
                    ),
                    Expanded(
                      child: Text(
                        "من خلال التسجيل، أنت توافق على شروط الخدمة وسياسة الخصوصية",
                        style:
                            GoogleFonts.cairo(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

// Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (!termsAccepted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "يجب الموافقة على الشروط والأحكام قبل المتابعة",
                                style: GoogleFonts.cairo(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Otp()),
                        );
                      }
                    },
                    child: Text(
                      "إنشاء حساب",
                      style:
                          GoogleFonts.cairo(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Login Link
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "سجل الدخول",
                          style: GoogleFonts.cairo(
                              fontSize: 14, color: kPrimaryColor),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "لديك حساب بالفعل؟",
                        style: GoogleFonts.cairo(
                            fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
