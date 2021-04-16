import 'package:mobx/mobx.dart';

part 'counter.store.g.dart';

class CounterStore = CounterStoreBase with _$CounterStore;

abstract class CounterStoreBase with Store {
  @observable
  int counter = 0;

  @observable
  ObservableList<String> frases = ObservableList();

  String text = '';

  void setText(String value) => text = value;

  @action
  void increment() => counter++;

  @action
  void _adicionar(String frase) => frases.add(frase);

  void add() {
    if (text.isNotEmpty) {
      _adicionar(text);
      text = '';
    }
  }
}
