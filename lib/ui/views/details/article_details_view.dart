import 'package:article_app/core/models/articles_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleDetailsView extends StatelessWidget {
  final Doc article;
  const ArticleDetailsView({required this.article});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,

        title: Text("Article Details", 
      style: textTheme.headline2!.copyWith(color: Colors.white),),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
          onTap:(){
            Navigator.of(context).pop();
          },
          child: Icon(CupertinoIcons.forward, color: Colors.white),
      ),
        ),
      ],
      ),
      body: SingleChildScrollView(
       child: Padding(
         padding: const EdgeInsets.all(20.0),
         child: Column(
           children: [
             SizedBox(height: 10.h),
             //**  Headline */
             Text(article.headline!.main!,
             style: textTheme.headline1),
             SizedBox(height: 10.h),
             //**  Content */
             Text(article.leadParagraph!,
             style: textTheme.bodyText1!.copyWith(color: Colors.blueGrey)),
             SizedBox(height: 20.h),
             //**  Author */
             Align(alignment: Alignment.centerRight,
             child: Text(article.byline!.original??"Unknown",
             style: textTheme.bodyText2),
             )
           ],
         ),
       ),
      ),
    );
  }
}