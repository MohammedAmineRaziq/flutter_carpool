import 'dart:convert';

import 'package:carpool_app/models/AnnounceModel.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/ReservationModel.dart';


class driverServices{
  static var client = http.Client();
  static addNewAnnounce(String start,String end ,String date, int price ,int places ) async {
    print(start);
    print(end);
    print(date);
    print(price);
    print(places);
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkcml2ZXIyMi5kcml2ZXIyMkBnbWFpbC5jb20iLCJyb2xlcyI6WyJEUklWRVIiXSwiaXNzIjoiaHR0cDovL2F1dGhlbnRpY2F0aW9uLW1pY3Jvc2VydmljZS1wcm9kdWN0aW9uLnVwLnJhaWx3YXkuYXBwL2F1dGgvbG9naW4iLCJleHAiOjE2NzMwODEzMjF9.qWlghm5sLlArwk1D8jCwjjzYVi9LAlLIv2gB1RJEtFc'
    };
    var url = Uri.https(
      Config.AnnounceUrl,
      Config.addAnnounce,
    );
    try{print("try methode");
   await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode({
          "start": start,
          "end": end,
          "date": date,
          "price": price,
          "places": places
        }),
      ).then((response) {
        print(response.statusCode);
        print("success");
        return true;});
    }catch(e){
    print("************error**********");
      return false;
    }
  }
  static Future<List<AnnounceModel>> getAnnounces() async {
    var url = Uri.https(
      Config.AnnounceUrl,
      Config.getAnnounces,
    );
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkcml2ZXIudGVzdEBnbWFpbC5jb20iLCJyb2xlcyI6WyJEUklWRVIiXSwiaXNzIjoiaHR0cDovL2F1dGhlbnRpY2F0aW9uLW1pY3Jvc2VydmljZS1wcm9kdWN0aW9uLnVwLnJhaWx3YXkuYXBwL2F1dGgvbG9naW4iLCJleHAiOjU5NDE2NzMxNzQzMTd9.lvgeICbeDc9KzmgyTJYM8GHVjhZ46Jw_M53fQ0DowG0'
    };
    var response = await client.get(
        url,
        headers: requestHeaders
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((date)=>AnnounceModel.fromJson(date)).toList();
    }
    else {
      throw Exception('Failed to load data!');
    }
  }
  static Future<List<ReservationModel>> getReservations(String AnnounceId) async {
    print(AnnounceId);
    var url = Uri.https(
      Config.ReservationUrl,
      "/booking/announcements/${AnnounceId}/passengers",
    );
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkcml2ZXIudGVzdEBnbWFpbC5jb20iLCJyb2xlcyI6WyJEUklWRVIiXSwiaXNzIjoiaHR0cDovL2F1dGhlbnRpY2F0aW9uLW1pY3Jvc2VydmljZS1wcm9kdWN0aW9uLnVwLnJhaWx3YXkuYXBwL2F1dGgvbG9naW4iLCJleHAiOjU5NDE2NzMxNzQzMTd9.lvgeICbeDc9KzmgyTJYM8GHVjhZ46Jw_M53fQ0DowG0'
    };

    try {
      var response = await client.get(
          url,
          headers: requestHeaders
      ).timeout(const Duration(seconds: 10));
      print("success");
      print(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((date)=>ReservationModel.fromJson(date)).toList();
    }catch (e, s) {
      print("*********error**********");
      print(e);
      return [];
    }
  }

  static Future<bool> acceptReservation(String announceId ,String passengerPublicId) async {
    print('announce Id :'+announceId);
    print('passenger Id :'+passengerPublicId);
    var url = Uri.https(
      Config.ReservationUrl,
      "/booking/announcements/${announceId}",
    );
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkcml2ZXIudGVzdEBnbWFpbC5jb20iLCJyb2xlcyI6WyJEUklWRVIiXSwiaXNzIjoiaHR0cDovL2F1dGhlbnRpY2F0aW9uLW1pY3Jvc2VydmljZS1wcm9kdWN0aW9uLnVwLnJhaWx3YXkuYXBwL2F1dGgvbG9naW4iLCJleHAiOjU5NDE2NzMxNzQzMTd9.lvgeICbeDc9KzmgyTJYM8GHVjhZ46Jw_M53fQ0DowG0',
      'passengerPublicId':passengerPublicId
    };
    var response = await client.put(
        url,
        headers: requestHeaders
    );
    if (response.statusCode == 200) {
      print("success");
      return true;

    } else {
      print(response.statusCode.toString());
      return false;
    }
  }

  static Future<bool> rejectReservation(String ReservationId , String passengerPublicId) async {
    var url = Uri.https(
      Config.ReservationUrl,
      "/booking/announcements/${ReservationId}/passengers",
    );
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkcml2ZXIudGVzdEBnbWFpbC5jb20iLCJyb2xlcyI6WyJEUklWRVIiXSwiaXNzIjoiaHR0cDovL2F1dGhlbnRpY2F0aW9uLW1pY3Jvc2VydmljZS1wcm9kdWN0aW9uLnVwLnJhaWx3YXkuYXBwL2F1dGgvbG9naW4iLCJleHAiOjU5NDE2NzMxNzQzMTd9.lvgeICbeDc9KzmgyTJYM8GHVjhZ46Jw_M53fQ0DowG0',
      'passengerPublicId':passengerPublicId
    };
    var response = await client.delete(
        url,
        headers: requestHeaders
    );
    if (response.statusCode == 200) {
      print("success");
      return true;

    } else {
      print(response.statusCode.toString());
      return false;
    }
  }
}