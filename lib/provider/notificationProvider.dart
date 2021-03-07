import 'package:flutter/foundation.dart';
import 'package:WalkmanMobile/model/notification.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;

  // set from api
  setnotifications(NotificationModel notificationText) {
    _notifications.add(notificationText);
    notifyListeners();
  }

  // Add Notification Item from firebase ...
  addNotificationItem(NotificationModel notificationText) {
    _notifications.insert(0, notificationText);
    notifyListeners();
  }

  // Fetch notification from server(Pagination Form)
  fetchNotification() {

  }

  // Change notification particular item colour on tap...
  set changeNotificationMarkStatus(int index) {}
}
