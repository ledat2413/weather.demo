import 'package:flutter/material.dart';

enum AlertType { Inform, Error, Success, Confirm }

class AlertPage extends StatelessWidget {
  const AlertPage(
      {this.context,
      this.title,
      required this.message,
      this.closeTitle,
      this.okTitle,
      this.alertType = AlertType.Inform});

  final BuildContext? context;
  final String? title;
  final String? message;
  final String? closeTitle;
  final String? okTitle;
  final AlertType alertType;

  static Future<dynamic>? showError(
      {required BuildContext context,
      String? title,
      required String? message,
      String? closeTitle,
      Function(int)? callback}) {
    return AlertPage.show(
        context: context,
        title: title,
        message: message,
        closeTitle: closeTitle,
        alertType: AlertType.Error,
        callback: callback);
  }

  static bool isShow = false;
  static Future<dynamic>? show(
      {required BuildContext context,
      String? title,
      required String? message,
      String? closeTitle,
      String? okTitle,
      AlertType alertType = AlertType.Inform,
      Function(int)? callback}) async {
    if (message == null || message.isEmpty) {
      return null;
    }
    if (AlertPage.isShow && Navigator.of(context).canPop()) {
      return null;
    }
    AlertPage.isShow = true;
    final int? result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertPage(
              context: context,
              title: 'Lỗi',
              message: message,
              closeTitle: closeTitle,
              okTitle: okTitle,
              alertType: alertType,
            ));
      },
    );
    AlertPage.isShow = false;
    if (callback != null) {
      callback(result ?? 0);
    }
    debugPrint("Dismiss alert");
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: alertWidget(context),
      ),
    );
  }

  Widget alertWidget(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if ((title != null) &&
              alertType != AlertType.Error &&
              alertType != AlertType.Success) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text((title ?? "").toUpperCase(),
                  style: const TextStyle(fontSize: 18)),
            ),
            const Divider(
              height: 1,
            ),
          ],
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              message ?? "",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: () {},
                child: Text('Đóng'),
              )),
        ],
      ),
    );
  }
}
