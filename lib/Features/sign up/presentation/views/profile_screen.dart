import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_picker/country_picker.dart';
import 'package:wasalny/constant.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String countryCode = "+20";
  String countryFlag = "🇪🇬";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? selectedGovernorate;
  String? selectedDistrict;
  String? selectedNeighborhood;

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      hintText: label,
      hintStyle: GoogleFonts.cairo(fontSize: 14, color: Colors.grey.shade400),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
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
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade300,
                      ),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: kPrimaryColor,
                          child: Icon(Icons.camera_alt, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: _inputDecoration("الاسم بالكامل"),
                  validator: (value) =>
                      value!.isEmpty ? "الاسم بالكامل مطلوب" : null,
                ),
                const SizedBox(height: 5),
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
                const SizedBox(height: 5),
                TextFormField(
                  controller: _emailController,
                  decoration: _inputDecoration("البريد الإلكتروني"),
                  validator: (value) =>
                      value!.isEmpty ? "البريد الإلكتروني مطلوب" : null,
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration("محافظة"),
                  items: ["القاهرة", "الجيزة"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => selectedGovernorate = value),
                  validator: (value) => value == null ? "محافظه مطلوبه" : null,
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration("المركز"),
                  items: ["المهندسين", "مدينة نصر"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => selectedDistrict = value),
                  validator: (value) => value == null ? "المركز مطلوب" : null,
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration("الحي"),
                  items: ["الحي الأول", "الحي الثاني"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => selectedNeighborhood = value),
                  validator: (value) => value == null ? "الحي مطلوب" : null,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: kPrimaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("إلغاء",
                            style: TextStyle(color: kPrimaryColor)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Submit logic
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: kPrimaryColor),
                        child: const Text("حفظ",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
