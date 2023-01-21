import 'package:article_app/core/view_models/search_vm/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../../core/models/articles_model.dart';
import '../../../utils/general_methods.dart';
import '../../widgets/article_widget.dart';
import '../details/article_details_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  bool _loadingData = true;
  @override
  void initState() {
    super.initState();
    //_init();
  }

  int page = 0;
  ScrollController? controller;
  bool _loadMore = false;
  List<Doc> data = [];
  var searchController = TextEditingController();
  _init() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (this.mounted) {
        setState(() => _loadingData = true);
        final searchVM = Provider.of<SearchViewModel>(context, listen: false);
        await context.read<SearchViewModel>().getSearchData(page: page,keyWord: searchController.text);
        if (searchVM.articlesList != null) data.addAll(searchVM.articlesList!.response!.docs);
        setState(() => _loadingData = false);
      }
      controller = ScrollController()..addListener(_scrollListener);
    });
  }

  void _scrollListener() async {
    final searchVM = Provider.of<SearchViewModel>(context, listen: false);
    if ((controller!.position.pixels == controller!.position.maxScrollExtent) && 
    (page <= 200)
    ) {
      page += 1;
      setState(() => _loadMore = true);
      await searchVM.getSearchData(page: page, keyWord: searchController.text);
      for (var element in searchVM.articlesList!.response!.docs) {
        data.add(element);
      }
      setState(() => _loadMore = false);
    }
  }
  void dispose() {
    controller!.removeListener(_scrollListener);
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
        
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("SEARCH",
              style: textTheme.headline1!.copyWith(color: Colors.black))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              
              decoration: InputDecoration(
                hintText: "what are you searching for..?",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                )
              ),
              onChanged: (value){
                data.clear();
                _init();
              },

            ),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: AnimationLimiter(
              child: ListView.separated(
                controller: controller,
                // shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(height: 5.h), 
              itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                position: index,
            duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: ScaleAnimation(
                    child: InkWell(
                      onTap: (){
                            General.routingPage(context, ArticleDetailsView(
                    article: data[index],
                            ));
                          },
                      child: ArticleWidget(
                        title: data[index].headline!.main??"", 
                        headline: data[index].docAbstract!, 
                        author: data[index].byline!.original??"UNKNOWN"),
                    ),
                  ),
                ),
              ),
              itemCount: data.length),
            ),
          ),
          SizedBox(height: 10.h),
          if(_loadMore)
          CircularProgressIndicator()
        ],
      ),
      ),
    );
  }
}