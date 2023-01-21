import 'dart:developer';

import 'package:article_app/core/models/articles_model.dart';

import '../setup/base_notifier.dart';

class SearchViewModel extends BaseNotifier{


  ArticlesModel? articlesList;

  Future getSearchData({int? page, required String keyWord}) async {
    setBusy();
    try {
      final _response = await api.getSearchData(page: page, keyWord: keyWord);
      articlesList = ArticlesModel.fromJson(_response.data);
      log(articlesList!.status!);
      setIdle();
    } catch (e) {
      log(
        e.toString()
      );
      setError();
    }
  }

}