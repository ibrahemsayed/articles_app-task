import 'package:article_app/ui/views/search/search_view.dart';
import 'package:article_app/ui/widgets/article_widget.dart';
import'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../../core/models/articles_model.dart';
import '../../../core/view_models/home_vm/home_view_model.dart';
import '../../../utils/general_methods.dart';
import '../details/article_details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  bool _loadingData = true;
  @override
  void initState() {
    super.initState();
    _init();
  }

  int page = 0;
  ScrollController? controller;
  bool _loadMore = false;
  List<Doc> data = [];
  _init() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (this.mounted) {
        setState(() => _loadingData = true);
        final homeVM = Provider.of<HomeViewModel>(context, listen: false);
        await context.read<HomeViewModel>().getArticlesList(page: page);
        if (homeVM.articlesList != null) data.addAll(homeVM.articlesList!.response!.docs);
        setState(() => _loadingData = false);
      }
      controller = ScrollController()..addListener(_scrollListener);
    });
  }

  void _scrollListener() async {
    final homeVM = Provider.of<HomeViewModel>(context, listen: false);
    if ((controller!.position.pixels == controller!.position.maxScrollExtent) && 
    page <= 200
    ) {
      page += 1;
      setState(() => _loadMore = true);
      await homeVM.getArticlesList(page: page);
      for (var element in homeVM.articlesList!.response!.docs) {
        data.add(element);
      }
      setState(() => _loadMore = false);
    }
  }
  void dispose() {
    controller!.removeListener(_scrollListener);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final HomeVM = Provider.of<HomeViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    General.routingPage(context, SearchView());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 10.w,),
                        Text("Search...", style: textTheme.subtitle1),
                        Spacer(),
                        const Icon(Icons.search, color: Colors.black),
                        SizedBox(width: 10.w,),
                      ],
                    ),
                  ),
                ),
              ),
      ),
      body: HomeVM.articlesList == null?
      Center(child: const CircularProgressIndicator())
      :Column(
        
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("ARTICLES", 
              style: textTheme.headline1!.copyWith(color: Colors.black))),
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
    );
  }
}