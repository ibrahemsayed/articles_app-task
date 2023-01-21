import 'dart:developer';

import 'package:article_app/core/models/articles_model.dart';

import '../setup/base_notifier.dart';

class HomeViewModel extends BaseNotifier{


  ArticlesModel? articlesList;

  Future getArticlesList({int? page}) async {
    setBusy();
    try {
      final _response = await api.getArticlesList(page: page);
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