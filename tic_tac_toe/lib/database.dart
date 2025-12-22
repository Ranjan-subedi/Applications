import 'package:shared_preferences/shared_preferences.dart';

class StorageService {

  Future<void> saveScores(int xScore, int oScore) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('xScore', xScore);
    await prefs.setInt('oScore', oScore);
  }

  Future<Map<String, int>> loadScores() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'xScore': prefs.getInt('xScore') ?? 0,
      'oScore': prefs.getInt('oScore') ?? 0,
    };
  }

  Future<void> resetScores() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('xScore');
    await prefs.remove('oScore');
  }
}
