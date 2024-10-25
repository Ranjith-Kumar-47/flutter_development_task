import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  static void showToastMessage(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.SNACKBAR);
  }
}
