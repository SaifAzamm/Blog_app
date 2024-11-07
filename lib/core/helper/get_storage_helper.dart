import 'package:get_storage/get_storage.dart';

final box = GetStorage();

class GetStorageHelper {
  static setInitialData() {
    box.writeIfNull('is_first_launch', true);
    box.writeIfNull('is_logged_in', false);
    box.writeIfNull('email', "");
    box.writeIfNull('uid', "");
  }
}
