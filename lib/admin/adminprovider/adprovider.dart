import 'package:flutter_riverpod/legacy.dart';
import 'package:gearapp/admin/service/adlogin_service.dart';

final adminService = StateNotifierProvider<LoginService, bool>((ref) {
  return LoginService();
});
