import '../models/recipe.dart';
import 'http_service.dart';

class DataService {
  // define a static variable
  static final DataService _singleton = DataService._internal();

  // define the http service variable to use in sending the request
  final HTTPService _httpService = HTTPService();

  // define the factory function for thee data service
  factory DataService() {
    return _singleton;
  }

  // define the internal constructor just to ensure there only exist a single instance of the data service
  DataService._internal();

  // define a function that will allow me fetch recipes
  Future<List<Recipes>?> getRecipes(String filter) async {
    String path = "recipes/";

    if (filter.isNotEmpty) {
      path += "meal-type/$filter";
    }

    // create a variable to use in performing a get request
    var response = await _httpService.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      List data = response!.data["recipes"];
      // convert it into a list of Recipe
      List<Recipes> recipes = data.map((e) => Recipes.fromJson(e)).toList();

      return recipes;
    }
    return null;
  }
}
