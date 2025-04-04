import 'package:flora_mart/core/api/api_manager.dart';
import 'package:flora_mart/core/api/api_result.dart';
import 'package:flora_mart/core/api/endpoints.dart';
import 'package:flora_mart/data/datasource_contract/categories_datasource.dart';
import 'package:flora_mart/data/model/categories/all_categories/all_categories_response.dart';
import 'package:flora_mart/data/model/categories/all_categories/categories.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesDatasource)
class CategoriesDatasourceImpl extends CategoriesDatasource {
  final ApiManager apiManager;

  @factoryMethod
  CategoriesDatasourceImpl(this.apiManager);

  @override
  Future<ApiResult<List<Categories>>> getAllCategories(
      {required String id,
      required String name,
      required num productsCount}) async {
    try {
      var response = await apiManager.getRequest(
        Endpoint: EndPoint.allCategoriesEndpoint,
      );

      print("📌 Full API Response: ${response.data}");

      AllCategoriesResponse allCategoriesResponse =
          AllCategoriesResponse.fromJson(response.data);

      print(
          "📌 Parsed Categories Response: ${allCategoriesResponse.categories}");

      var filteredCategories =
          allCategoriesResponse.categories?.where((category) {
        bool idMatches = category.id == id || id.isEmpty;
        bool nameMatches = category.name == name || name.isEmpty;
        bool productsCountMatches = category.productsCount == productsCount;
        return idMatches && nameMatches && productsCountMatches;
      }).toList();

      print("📌 Filtered Categories: $filteredCategories");

      if (filteredCategories != null && filteredCategories.isNotEmpty) {
        return SuccessApiResult(filteredCategories);
      } else {
        print(
            "⚠️ [Datasource] No matching categories found for id=$id, name=$name, productsCount=$productsCount");
        return ErrorApiResult(Exception("No matching categories found"));
      }
    } catch (err) {
      print("❌ [Datasource] Error: $err");
      return ErrorApiResult(
          Exception("Server connection error: ${err.toString()}"));
    }
  }
}
