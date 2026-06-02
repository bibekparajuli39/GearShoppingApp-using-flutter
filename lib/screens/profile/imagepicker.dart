import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:gearapp/provider/sharedpreferprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImageNotifier extends StateNotifier<String?> {
  final SharedPreferences prefs;
  ProfileImageNotifier(this.prefs) : super(null) {
    loadImage();
  }
  void loadImage() async {
    state = prefs.getString('profile_image');
  }

  Future<void> saveImage(String imagePath) async {
    await prefs.setString('profile_image', imagePath);
    state = imagePath;
  }

  Future<void> clearImage() async {
    await prefs.remove('profile_image');
    state = null;
  }
}

final profileImageProvider =
    StateNotifierProvider<ProfileImageNotifier, String?>((ref) {
      final prefs = ref.watch(sharepreferprovider);

      return prefs.when(
        data: (pref) => ProfileImageNotifier(pref),
        error: (e, r) =>
            throw Exception('Failed to load SharedPreferences: $e'),
        loading: () => throw Exception('Failed to load SharedPreferences'),
      );
    });
