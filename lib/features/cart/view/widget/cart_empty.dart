import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/home/view/home_view.dart';
class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "No Item Selected ",
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
                Icons.remove_shopping_cart,
                size: 200,
                color: Colors.red,
              ),
              SizedBox(height: 20),
              Text(
                "السلة فارغه",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),


              SizedBox(height: 30),

              // زر تسجيل الدخول
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HomeView()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorPalette.primaryColor,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  "الشاشة الرئيسة",
                  style: TextStyle(fontSize: 18,color: Colors.white),
                ),
              ),

              SizedBox(height: 10),

              // زر إنشاء حساب

            ],
          ),
        ),
      ),
    );
  }
}