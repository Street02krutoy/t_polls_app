import "package:http/http.dart" as http;
import "dart:convert";
import "package:t_polls_app/types/poll.dart";
import "package:telegram_web_app/telegram_web_app.dart";


class ApiService {
  String serverURL = "http://192.168.84.29:5000";
  static final ApiService service = ApiService();

  Future<Map<String, bool>> getSettings() async {
    http.Response baseInfoResponse =
    await http.get(Uri.parse("$serverURL/api/user/settings?user_id=${TelegramWebApp.instance.initData.user.id}"));
    Map<String, bool> baseInfoJson = jsonDecode(baseInfoResponse.body);
    return baseInfoJson;
  }

  Future<List<Poll>> getPolls() async {
    print("AAAA");
    http.Response baseInfoResponse =
        await http.get(Uri.parse("$serverURL/api/user/polls?user_id=${TelegramWebApp.instance.initData.user.id}"));
    List baseInfoJson = jsonDecode(baseInfoResponse.body);
    return List.generate(
        baseInfoJson.length, (index) => Poll.fromJson(baseInfoJson[index]));
  }

  Future<bool> loadResult(int poll_id) async {
    Map body = {
      "user_id": TelegramWebApp.instance.initData.user.id.toString(),
      "poll_id": poll_id,

    };

    http.Response baseInfoResponse = await http.post(
        Uri.parse("$serverURL/api/user/poll"),
        body: body,);
    return baseInfoResponse.statusCode == 200;
  }


}
