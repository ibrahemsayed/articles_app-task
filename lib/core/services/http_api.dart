import 'api_paths.dart';
import 'custom_dio.dart';

class HttpApi {
  CustomDio customDio = CustomDio();

  //******************* Get Home Articles ************************** */
  Future<dynamic> getArticlesList({int? page}) async {
    final res = await customDio.request(
      "${EndPoint.ARTICLESLIST}&page=$page",
      type: RequestType.Get,
      headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    }
    );
    return res;
  }

  //*******************  Get Search Data  ***********************/
  Future<dynamic> getSearchData({int? page, required String keyWord}) async {
    final res = await customDio.request(
      "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=$keyWord&api-key=4zHpCpkNmpwXJ0HUIAfiFp9fQ0Y0i8Sl&page=$page",
      type: RequestType.Get,
      headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    }
    );
    return res;
  }
  
  }