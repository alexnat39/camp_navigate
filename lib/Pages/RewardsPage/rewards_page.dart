import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:camp_navigate/Helpers/custom_sizes.dart';
import 'package:camp_navigate/Models/UserVM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

class RewardsPage extends StatefulWidget {
  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  PaginateRefreshedChangeListener refreshChangeListener =
  PaginateRefreshedChangeListener();

  @override
  Widget build(BuildContext context) {
    double? height = CustomSizes(context).getHeight(context);
    return RefreshIndicator(
      color: CustomColors.BLUE,
      child: PaginateFirestore(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        itemBuilderType: PaginateBuilderType.listView,
        itemBuilder: (index, context, documentSnapshot) {
          final reward = documentSnapshot.data() as Map?;
          return Consumer<UserVM>(

            builder: (BuildContext context, myUserVM, Widget? child) {
              print(myUserVM.totalPoints);
              return ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    width: double.infinity,
                    child: Card(
                      color: CustomColors.WHITE,
                      clipBehavior: Clip.hardEdge,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
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
                                  Expanded(
                                    child: Column(children: [
                                      Text(
                                        reward["name"],
                                        style:
                                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: ExpandableText(
                                            reward["description"],
                                            expandText: 'More',
                                            collapseText: 'Less',
                                            maxLines: 4,
                                            linkColor: CustomColors.LIGHTGREY,
                                            style: TextStyle(
                                                fontSize: 14, fontWeight: FontWeight.w400)),
                                      ),Padding(
                                        padding: const EdgeInsets.only(top:20),
                                        child: Text('Need ${reward['points']} points'),
                                      )
                                    ]),
                                  )
                                ]),
                          ),
                          (myUserVM.totalPoints! >= reward['points']) ? Container() : Container(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 0.4, sigmaY: 0.4),
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                              ),
                            ),
                          ),
                          (myUserVM.totalPoints! >= reward['points']) ? Container() : Positioned.fill(child: Icon(Icons.lock, color: CustomColors.BLACK, size: 50,), ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(15),
                    ),
                  ),
                ],
              );
            },
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
    );
  }
}