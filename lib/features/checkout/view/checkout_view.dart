import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/checkout/view/widget/order_details_widget.dart';
import 'package:hungry/shared/custom_btn.dart';
import 'package:hungry/shared/custom_text.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(

      appBar: AppBar(
        toolbarHeight: 60, // أقل من 0 مش ممكن
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorPalette.primaryColor, size: 22),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: 'Order Summary',fontWeight: FontWeight.bold,fontSize: 25,),
                OrderDetailsWidget(order: '20', taxes: '0.3', fees: '0.2', total: '18',),

                Gap(20),
                CustomText(text: 'Payment Method',fontWeight: FontWeight.bold,fontSize: 25,),



                //-------delivery  time------



                InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: () {},
                  child: Container(
                    height: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B2F2F), // لون غامق قريب من الصورة
                      borderRadius: BorderRadius.circular(40),
            
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Cash on Delivery',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: const DecorationImage(
                      image: AssetImage(AssetsPath.visa), // مسار الصورة
                      fit: BoxFit.cover, // تغطي الكونتينر بالكامل
                    ),
            
                  ),
                ),
               Gap(10),
                Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Icon(Icons.check_box,color: Colors.red,),
                  Gap(10),
                  CustomText(text: 'Save card details for future payments'),
                    
                ],
                ),
                    CustomText(text: 'Total price'),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  CustomText(text: '18.19\$',color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30,),
                  CustomBtn(heightSize: 70, widthSize: 120, backgroundColor: ColorPalette.primaryColor, child: CustomText(text: 'Pay Now',color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold,)),
                    
                ],)
                    
                    
                    
              ],
            ),
          ),
        ),
      ),
    );
  }

}


