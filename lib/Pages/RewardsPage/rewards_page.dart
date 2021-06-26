import 'package:cached_network_image/cached_network_image.dart';
import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:camp_navigate/Helpers/custom_sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class RewardsPage extends StatelessWidget {

  PaginateRefreshedChangeListener refreshChangeListener =
  PaginateRefreshedChangeListener();
  @override
  Widget build(BuildContext context) {
    double? height = CustomSizes(context).getHeight(context);
    double? width = CustomSizes(context).getWidth(context);
    return Scaffold(
      body: RefreshIndicator(child: PaginateFirestore(
        itemBuilderType: PaginateBuilderType.listView,
      itemBuilder: (index, context, documentSnapshot) {
        final reward = documentSnapshot.data() as Map?;
        return ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Card(
              clipBehavior: Clip.hardEdge,
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //
              // ),
              child: Row(
                children: [
                  CachedNetworkImage(
                    height: height! * 0.1,
                    imageUrl: reward!['image'],
                    placeholder: (context, url) => Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.07,
                        bottom: height * 0.07,
                        right: height * 0.06,
                        left: height * 0.06,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: CustomColors.GREY,
                    ),
                    fit: BoxFit.fill,
                  ),
                  Column(
                    children: [
                      Text(reward["name"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(reward["description"], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                      ),
                      // ExpandableText(widget.commentaryModel!.text!,
                      //     expandText: 'Развернуть',
                      //     collapseText: 'Спрятать',
                      //     maxLines: 4,
                      //     linkColor: CustomColors.LIGHTGREY,
                      //     style: TextStyle(fontSize: 14, color: CustomColors.WHITE)),
                    ]
                  )
                ]
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(15),
            ),
          ],
        );
      },
      query: FirebaseFirestore.instance.collection('rewards'),
      listeners: [
        refreshChangeListener,
      ],
      isLive: true,
      itemsPerPage: 5,
    ),
      onRefresh: () async {
        refreshChangeListener.refreshed = true;
      },
    ),
    );
  }

}