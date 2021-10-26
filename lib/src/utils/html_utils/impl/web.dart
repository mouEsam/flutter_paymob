import 'dart:html' as html;

void listenToUrlEvent(void Function(String) callback) {
  html.window.onMessage.listen((event) {
    var data = event.data;
    if (data is String) {
      callback(data);
    }
  });
}
