import 'dart:async';

void main() {
  List convidados = ["Daniel", "João", "Paulo", "Marcos"];

  final controller = StreamController();

  // ignore: cancel_subscriptions
  final subscription = controller.stream.where((data) {
    return convidados.contains(data);
  }).listen((data) {
    print(data);
  });

  controller.sink.add("Daniel");
  controller.sink.add("Leticia");
  controller.sink.add("Paulo");
  controller.sink.add("Leo");

  controller.close();
}
