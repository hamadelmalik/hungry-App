import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/auth/view/login_view.dart';
import 'package:hungry/features/auth/view/register_view.dart';
class GuestModeView extends StatelessWidget {
  const GuestModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Guest Mode",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.grey.shade400,
              ),
              SizedBox(height: 20),
              Text(
                "أنت الآن في وضع الزائر",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "سجّل دخولك للحصول على تجربة كاملة داخل التطبيق",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30),

              // زر تسجيل الدخول
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginView()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorPalette.secondaryColor,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  "تسجيل الدخول",
                  style: TextStyle(fontSize: 18),
                ),
              ),

              SizedBox(height: 10),

              // زر إنشاء حساب
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterView()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  side: BorderSide(color: ColorPalette.primaryColor),
                ),
                child: Text(
                  "إنشاء حساب جديد",
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorPalette.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}