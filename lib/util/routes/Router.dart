import 'package:flutter/material.dart';
import 'package:WalkmanMobile/screens/step_count/step_count.dart';
import '../../screens/introscreen/introduction.dart';
import '../../screens/landing/start_walking/walking_result.dart';
import '../../screens/landing/start_walking/create_image.dart';
import '../../screens/landing/start_walking/start_walking.dart';
import '../../screens/landing/start_walking/walking.dart';
import '../../screens/search/QR_code/qr_code_scan.dart';
import '../../screens/all_vendors/show_all_vendors.dart';
import '../../screens/auth/auth.dart';
import '../../screens/home/home.dart';
import '../../screens/offers/offers.dart';
import '../../screens/profile/total_friends_invites/total_friends.dart';
import '../../screens/profile/total_friends_invites/total_invites.dart';
import '../../screens/search/cart/cart.dart';
import '../../screens/search/notification/notification.dart';
//import '../../screens/search/walkman_deals/resturant_deals_details.dart';
import '../../screens/view_all/view_all.dart';
import '../../widgets/my_page_route_builder.dart';

class RouterApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/':
      //   return MyPageRouteBuilder(screen: IntroductionScreen()).buildPageRoute();
      case '/':
        return MyPageRouteBuilder(screen: Auth()).buildPageRoute();
      // case '/landing':
      //   return MyPageRouteBuilder(screen: StepCount()).buildPageRoute();
      case '/start':
        return MyPageRouteBuilder(screen: Startwalking()).buildPageRoute();
      case '/walking':
        return MyPageRouteBuilder(screen: Walking()).buildPageRoute();
      case '/create-image':
        return MyPageRouteBuilder(screen: CreateImage()).buildPageRoute();
      case '/walking-result':
        return MyPageRouteBuilder(screen: WalkingResult()).buildPageRoute();
      case '/home':
        return MyPageRouteBuilder(screen: Home()).buildPageRoute();
      case '/show-all-vendors':
        return MyPageRouteBuilder(screen: ShowAllVendors()).buildPageRoute();
      case '/total-friends':
        return MyPageRouteBuilder(screen: TotalFriends()).buildPageRoute();
      case '/total-invites':
        return MyPageRouteBuilder(screen: TotalInvites()).buildPageRoute();
//      case '/resturant-details':
//        return MyPageRouteBuilder(screen: ResturantDealsDetails())
//            .buildPageRoute();
      case '/offers':
        return MyPageRouteBuilder(screen: Offers()).buildPageRoute();
      case '/view-all':
        return MyPageRouteBuilder(screen: ViewAll()).buildPageRoute();
      case '/cart':
        return MyPageRouteBuilder(screen: Cart()).buildPageRoute();
      case '/notification':
        return MyPageRouteBuilder(screen: MyNotification()).buildPageRoute();
      // case '/scan-qr':
      //   return MyPageRouteBuilder(screen: QRCodeScan()).buildPageRoute();
      default:
        return null;
    }
  }
}
