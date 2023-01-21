

import 'package:article_app/core/view_models/search_vm/search_view_model.dart';
import 'package:get_it/get_it.dart';

import '../../services/http_api.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../home_vm/home_view_model.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => HttpApi());
}

List<SingleChildWidget> providers = [
  ...independentServices,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider<HomeViewModel>(create: (_) => locator<HomeViewModel>()),
  ChangeNotifierProvider<SearchViewModel>(create: (_) => SearchViewModel())
  
  ];