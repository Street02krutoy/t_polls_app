import "package:http/http.dart" as http;
import "package:t_polls_app/types/exceptions.dart";
import "dart:convert";
import "package:t_polls_app/types/poll.dart";
import "package:telegram_web_app/telegram_web_app.dart";

class ApiService {
  String serverURL = "http://192.168.116.29:5000";
  static final ApiService service = ApiService();

  Future<Map?> getSettings() async {
    http.Response baseInfoResponse = await http
        .get(Uri.parse(
            "$serverURL/api/user/settings?id=${TelegramWebApp.instance.initData.user.id}"))
        .timeout(const Duration(seconds: 3), onTimeout: () {
      throw APIError("Превышено время ожидания ответа сервера");
    });
    Map baseInfoJson = jsonDecode(baseInfoResponse.body);
    print(baseInfoJson);
    return baseInfoJson;
  }

  Future<bool?> checkUser() async {
    http.Response baseInfoResponse = await http
        .get(Uri.parse(
            "$serverURL/api/user/check_user?id=${TelegramWebApp.instance.initData.user.id}"))
        .timeout(const Duration(seconds: 3), onTimeout: () {
      throw APIError("Превышено время ожидания ответа сервера");
    });
    Map baseInfoJson = jsonDecode(baseInfoResponse.body);
    print(baseInfoJson);
    return baseInfoJson["response"] == 1;
  }

  Future setSettings(bool lightTheme, bool swipeMode) async {
    Map body = {
      "id": TelegramWebApp.instance.initData.user.id.toString(),
      "light_theme": lightTheme,
      "swipe_mode": swipeMode
    };

    print(body);
    http.Response baseInfoResponse = await http.put(
      Uri.parse("$serverURL/api/user/settings"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    return baseInfoResponse.statusCode == 200;
  }

  Future<List<Poll>?> getPolls() async {
    http.Response baseInfoResponse = await http
        .get(Uri.parse(
            "$serverURL/api/user/polls?id=${TelegramWebApp.instance.initData.user.id}"))
        .timeout(const Duration(seconds: 3), onTimeout: () {
      throw APIError("Превышено время ожидания ответа сервера");
    });
    var baseInfoJson = jsonDecode(baseInfoResponse.body);
    if (baseInfoResponse.statusCode != 200) {
      if (baseInfoResponse.statusCode == 404)
        throw NotAuthorizedException(baseInfoJson["message"]);
      throw APIError(baseInfoJson["message"]);
    }
    List<Poll> a = List.generate(
        baseInfoJson.length, (index) => Poll.fromJson(baseInfoJson[index]));
    return a;
  }

  Future<List<Poll>?> getHistories() async {
    http.Response baseInfoResponse = await http
        .get(Uri.parse(
            "$serverURL/api/user/histories?id=${TelegramWebApp.instance.initData.user.id}"))
        .timeout(const Duration(seconds: 3), onTimeout: () {
      throw APIError("Превышено время ожидания ответа сервера");
    });
    var baseInfoJson = jsonDecode(baseInfoResponse.body);
    if (baseInfoResponse.statusCode != 200) {
      throw APIError(baseInfoJson["message"]);
    }
    List<Poll> a = List.generate(
        baseInfoJson.length, (index) => Poll.fromJson(baseInfoJson[index]));
    return a;
  }

  Future<Poll?> getPoll(int id) async {
    http.Response baseInfoResponse = await http
        .get(Uri.parse("$serverURL/api/user/poll?id=$id"))
        .timeout(const Duration(seconds: 3), onTimeout: () {
      throw APIError("Превышено время ожидания ответа сервера");
    });
    print(baseInfoResponse.request!.url);
    Map baseInfoJson = jsonDecode(baseInfoResponse.body);
    if (baseInfoResponse.statusCode != 200) {
      throw APIError(baseInfoJson["message"]);
    }
    print(baseInfoJson);
    var a = Poll.fromJson(baseInfoJson);
    print(a);
    return a;
  }

  Future<Map?> getHistory(int id) async {
    http.Response baseInfoResponse = await http
        .get(Uri.parse(
            "$serverURL/api/user/history?poll_id=$id&user_id=${TelegramWebApp.instance.initData.user.id}"))
        .timeout(const Duration(seconds: 3), onTimeout: () {
      throw APIError("Превышено время ожидания ответа сервера");
    });
    print(baseInfoResponse.request!.url);
    Map baseInfoJson = jsonDecode(baseInfoResponse.body);
    if (baseInfoResponse.statusCode != 200) {
      throw APIError(baseInfoJson["message"]);
    }
    print(baseInfoJson);
    return baseInfoJson;
  }

  Future<Poll?> getRandomPoll(int previousId) async {
    http.Response baseInfoResponse = await http
        .get(Uri.parse(
            "$serverURL/api/user/swipe?poll_id=$previousId&user_id=${TelegramWebApp.instance.initData.user.id}"))
        .timeout(const Duration(seconds: 3), onTimeout: () {
      throw APIError("Превышено время ожидания ответа сервера");
    });
    print(baseInfoResponse.request!.url);
    Map baseInfoJson = jsonDecode(baseInfoResponse.body);
    if (baseInfoResponse.statusCode != 200) {
      throw APIError(baseInfoJson["message"]);
    }
    print(baseInfoJson);
    var a = Poll.fromJson(baseInfoJson);
    print(a);
    return a;
  }

  Future<bool> loadResult(
      int pollId, Map<String, int?> questions, bool finalQuestion) async {
    List<String> keys = questions.keys.toList();
    Map body = {
      "user_id": TelegramWebApp.instance.initData.user.id.toString(),
      "poll_id": pollId.toString(),
      "criterion_1": "${keys[0]},${questions[keys[0]]}",
      "criterion_2": "${keys[1]},${questions[keys[1]]}",
      "criterion_3": "${keys[2]},${questions[keys[2]]}",
      "special": finalQuestion
    };

    print(body);
    http.Response baseInfoResponse = await http
        .post(
      Uri.parse("$serverURL/api/user/poll"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    )
        .timeout(const Duration(seconds: 3), onTimeout: () {
      throw APIError("Превышено время ожидания ответа сервера");
    });
    return baseInfoResponse.statusCode == 200;
  }

  Future<int?> getCompletedCount() async {
    http.Response baseInfoResponse = await http.get(Uri.parse(
        "$serverURL/api/user/profile?&id=${TelegramWebApp.instance.initData.user.id}"));
    print(baseInfoResponse.request!.url);
    Map baseInfoJson = jsonDecode(baseInfoResponse.body);
    return baseInfoJson["polls_amount"];
  }
}
