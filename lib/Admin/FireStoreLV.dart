import 'package:camp_navigate/Helpers/custom_colors.dart';
import 'package:camp_navigate/Helpers/custom_sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class FireStoreLV extends StatefulWidget {
late String collection;

FireStoreLV(this.collection);

  @override
  _FireStoreLVState createState() => _FireStoreLVState();
}

class _FireStoreLVState extends State<FireStoreLV> {
  PaginateRefreshedChangeListener refreshChangeListener =
  PaginateRefreshedChangeListener();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: PaginateFirestore(itemBuilderType: PaginateBuilderType.listView,
        itemBuilder: (index, context, documentSnapshot) {
          final item = documentSnapshot.data() as Map?;
          return InkWell(
              onTap: () {
                // Navigator.push(
                //       context,
                //    MaterialPageRoute(
                //       builder: (context) => AdminRestaurants()));
              },
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    Padding(
                        padding:
                        EdgeInsets.all(10),
                        child: Text(
                          item!['title'],
                          style: TextStyle(
                              fontSize: 22, color: CustomColors.GREY),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                        padding:
                        EdgeInsets.all(10),
                        child: Text(
                          '+${item['points']}',
                          style: TextStyle(
                              fontSize: 22, color: CustomColors.GREY),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        )),

                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(15),
              ));
        },
        query: FirebaseFirestore.instance.collection(widget.collection),
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
