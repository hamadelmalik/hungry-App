import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/shared/custom_btn.dart';
import 'package:hungry/shared/custom_text.dart';
class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
child: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 30),
  child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(AssetsPath.hamburger,width: 110,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             CustomText(text: 'Hamburger',fontWeight: FontWeight.w500,fontSize: 18,),
              CustomText(text: 'price : 20\$ ',fontWeight: FontWeight.w500,fontSize: 18,),
              CustomText(text: 'qyt   :     2',fontWeight: FontWeight.w500,fontSize: 18,),
                  ],),
      
        ],
      ),
    //  Gap(10),
  CustomBtn(
    heightSize: 50,
    widthSize: double.infinity,
    backgroundColor:  ColorPalette.primaryColor.withValues(alpha: 0.15),
    onTap: () {
      log('Checkout');
    },child: CustomText(text: 'Re Order',color: ColorPalette.primaryColor,fontSize: 20,fontWeight: FontWeight.w700,),),
    ],
  ),
),
                  );
                },
              ),
            ),


          ],
        ),)
    );


  }
}
