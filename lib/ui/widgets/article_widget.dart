import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/general_methods.dart';
import '../views/details/article_details_view.dart';

class ArticleWidget extends StatelessWidget {
  final String title;
  final String headline;
  final String author;
  ArticleWidget({required this.title,required this.headline,required this.author});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 5.w,
          ),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //**   title */
              Text(title, 
              style: textTheme.headline1,),
              SizedBox(height: 5.h,),
              //**   headline */
              Text(headline, 
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyText2!.copyWith(color: Colors.black),),
              SizedBox(height: 10.h,),
              //**   headline */
              Align(
                alignment: Alignment.centerRight,
                child: Text(author, 
                style: textTheme.subtitle1!.copyWith(color: Colors.black),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}