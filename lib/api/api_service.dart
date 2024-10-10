import "package:http/http.dart" as http;
import "dart:convert";
import "package:t_polls_app/types/poll.dart";
import "package:telegram_web_app/telegram_web_app.dart";

class ApiService {
  String serverURL = "http://192.168.116.29:5000";
  static final ApiService service = ApiService();

  Future<Map<String, bool>?> getSettings() async {
    http.Response baseInfoResponse = await http.get(Uri.parse(
        "$serverURL/api/user/settings?user_id=${TelegramWebApp.instance.initData.user.id}"));
    Map<String, bool> baseInfoJson = jsonDecode(baseInfoResponse.body);
    return baseInfoJson;
  }

  Future<List<Poll>?> getPolls() async {
    http.Response baseInfoResponse = await http.get(Uri.parse(
        "$serverURL/api/user/polls?id=${TelegramWebApp.instance.initData.user.id}"));
    List baseInfoJson = jsonDecode(baseInfoResponse.body);
    List<Poll> a = List.generate(
        baseInfoJson.length, (index) => Poll.fromJson(baseInfoJson[index]));
    return a;
  }

  Future<List<Poll>?> getHistories() async {
    http.Response baseInfoResponse = await http.get(Uri.parse(
        "$serverURL/api/user/histories?id=${TelegramWebApp.instance.initData.user.id}"));
    List baseInfoJson = jsonDecode(baseInfoResponse.body);
    List<Poll> a = List.generate(
        baseInfoJson.length, (index) => Poll.fromJson(baseInfoJson[index]));
    return a;
  }

  Future<Poll?> getPoll(int id) async {
    http.Response baseInfoResponse =
        await http.get(Uri.parse("$serverURL/api/user/poll?id=$id"));
    print(baseInfoResponse.request!.url);
    Map baseInfoJson = jsonDecode(baseInfoResponse.body);
    print(baseInfoJson);
    var a = Poll.fromJson(baseInfoJson);
    print(a);
    return a;
  }

  Future<Map?> getHistory(int id) async {
    http.Response baseInfoResponse =
    await http.get(Uri.parse("$serverURL/api/user/history?poll_id=$id&user_id=${TelegramWebApp.instance.initData.user.id}"));
    print(baseInfoResponse.request!.url);
    Map baseInfoJson = jsonDecode(baseInfoResponse.body);
    print(baseInfoJson);
    return baseInfoJson;
  }

  Future<Poll?> getRandomPoll(int previousId) async {
    http.Response baseInfoResponse =
    await http.get(Uri.parse("$serverURL/api/user/swipe?poll_id=$previousId&user_id=${TelegramWebApp.instance.initData.user.id}"));
    print(baseInfoResponse.request!.url);
    Map baseInfoJson = jsonDecode(baseInfoResponse.body);
    print(baseInfoJson);
    var a = Poll.fromJson(baseInfoJson);
    print(a);
    return a;
  }

  Future<bool> loadResult(int pollId, Map<String, int?> questions, bool finalQuestion) async {
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
    http.Response baseInfoResponse = await http.post(
      Uri.parse("$serverURL/api/user/poll"),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(body),
    );
    return baseInfoResponse.statusCode == 200;
  }

  Future<int?> getCompletedCount() async {
    http.Response baseInfoResponse =
    await http.get(Uri.parse("$serverURL/api/user/profile?&id=${TelegramWebApp.instance.initData.user.id}"));
    print(baseInfoResponse.request!.url);
    Map baseInfoJson = jsonDecode(baseInfoResponse.body);
    return baseInfoJson["polls_amount"];
  }


}
