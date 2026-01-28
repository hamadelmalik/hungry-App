
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/cart/data/model/model.dart';

class CartRepo{
   ApiServices apiServices=ApiServices();
//----------fuction send not recive void--------------------------//
  Future<void>addToCCart(CartRequestModel cartData)async{
    try{
      final res=await apiServices.post('/cart/add', cartData.toJson());

      throw ApiError(message: 'Product added Successfully');
    }catch (e){
      throw ApiError(message: e.toString());
    }





    
  }


}