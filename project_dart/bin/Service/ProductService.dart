import '../models/ApiResponse.dart';
import '../models/Product.dart';
import 'ConnectAPI.dart';

class ProductService {
  // Get index
  static Future<ApiResponse> index() async =>
      apiResponseFromJson(await ConnectAPI.get('/product/index'));

  // Get products
  static Future<ApiResponse> products() async =>
      apiResponseFromJson(await ConnectAPI.get('/product/products'));

  // Get product by users ID
  static Future<ApiResponse> getProductByUserId(int userId) async =>
      apiResponseFromJson(
          await ConnectAPI.get('/product/getProductByUserId/${userId}'));

  // Dummy products
  static Future<ApiResponse> dummy(int userId, int index) async =>
      apiResponseFromJson(
          await ConnectAPI.get('/product/dummy/${userId}/${index}'));

  // Add
  static Future<ApiResponse> add(Product product) async =>
      apiResponseFromJson(await ConnectAPI.post('/product/add', product));

  // Update
  static Future<ApiResponse> update(Product product) async =>
      apiResponseFromJson(await ConnectAPI.post('/product/update', product));

  // Remove
  static Future<ApiResponse> remove(Product product) async =>
      apiResponseFromJson(await ConnectAPI.post('/product/remove', product));

}
