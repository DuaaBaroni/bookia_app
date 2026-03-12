import 'package:bookia_app/core/services/dio/apis.dart';
import 'package:bookia_app/core/services/dio/dio_provider.dart';
import 'package:bookia_app/features/home/data/model/best_seller_model/best_seller_model.dart';
import 'package:bookia_app/features/home/data/model/slider_model/slider_model.dart';

class HomeRepo {
  static Future<SliderModel?> getSliders() async {
    try {
      var response = await DioProvider.get(endpoint: Apis.slider);
      if (response.statusCode == 200) {
        return SliderModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }



// static Future<BestSellerModel?> getBestSellers() async {
//   try {
//     var response = await DioProvider.get(endpoint: Apis.bestSellerProducts);
    //     print('Raw API Response:');
//     print(response.data);
    
//     if (response.statusCode == 200) {
//       final model = BestSellerModel.fromJson(response.data);
      
//       print(' After Parsing:');
//       print('Data: ${model.data}');
//       print('Products: ${model.data?.products}');
      
//       return model;
//     } else {
//       return null;
//     }
//   } catch (e) {
//     print(' Error: $e');
//     return null;
//   }
// }
  static Future<BestSellerModel?> getBestSellers() async {
    try {
      var response = await DioProvider.get(endpoint: Apis.bestSellerProducts);
      if (response.statusCode == 200) {
        return BestSellerModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
