import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:WalkmanMobile/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:WalkmanMobile/provider/notificationProvider.dart';

class MyNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          height: 50.0,
          aTitle: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios),
              ),
              SizedBox(width: 100.0),
              Text('NOTIFICATION'),
            ],
          ),
        ),
        body: notificationProvider.notifications.length == 0
            ? Center(
                child: Text('No Notifications!'),
              )
            : Container(
                margin: EdgeInsets.only(top: 12),
                child: ListView.builder(
                    itemCount: notificationProvider.notifications.length,
                    itemBuilder: (context, int index) {
                      return Card(
                        borderOnForeground: true,
                        elevation: 6,
                        margin:
                            EdgeInsets.only(left: 12, right: 12, bottom: 10),
                        child: Container(
                          padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notificationProvider
                                    .notifications[index].notificationTitle,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                notificationProvider
                                    .notifications[index].notificationDate,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 12),
                              ),
                              SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: notificationProvider
                                        .notifications[index].imgURL,
                                    fit: BoxFit.fill,
                                    width: 100,
                                    height: 80,
                                  ),
                                  SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notificationProvider
                                            .notifications[index].itemTitle,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                          notificationProvider
                                              .notifications[index]
                                              .itemDescription,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300)),
                                      SizedBox(height: 20),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                180,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Rs. ' +
                                                notificationProvider
                                                    .notifications[index]
                                                    .itemPrice),
                                            Text('Qty: ' +
                                                notificationProvider
                                                    .notifications[index]
                                                    .itemQuantity)
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}
