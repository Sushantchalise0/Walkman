import 'dart:convert';

import 'package:WalkmanMobile/model/leaderBoardModel.dart';
import 'package:http/http.dart' as http;

class LeaderBoardService {
  Future<LeaderBoardModel> getLeaderBoard() async {
    try {
      final response = await http
          .get('https://peaceful-atoll-49860.herokuapp.com/leaderboard');
      print(json.decode(response.body));
      return LeaderBoardModel.fromJson(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }
}
