// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CounterStore on CounterStoreBase, Store {
  final _$counterAtom = Atom(name: 'CounterStoreBase.counter');

  @override
  int get counter {
    _$counterAtom.reportRead();
    return super.counter;
  }

  @override
  set counter(int value) {
    _$counterAtom.reportWrite(value, super.counter, () {
      super.counter = value;
    });
  }

  final _$frasesAtom = Atom(name: 'CounterStoreBase.frases');

  @override
  ObservableList<String> get frases {
    _$frasesAtom.reportRead();
    return super.frases;
  }

  @override
  set frases(ObservableList<String> value) {
    _$frasesAtom.reportWrite(value, super.frases, () {
      super.frases = value;
    });
  }

  final _$CounterStoreBaseActionController =
      ActionController(name: 'CounterStoreBase');

  @override
  void increment() {
    final _$actionInfo = _$CounterStoreBaseActionController.startAction(
        name: 'CounterStoreBase.increment');
    try {
      return super.increment();
    } finally {
      _$CounterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _adicionar(String frase) {
    final _$actionInfo = _$CounterStoreBaseActionController.startAction(
        name: 'CounterStoreBase._adicionar');
    try {
      return super._adicionar(frase);
    } finally {
      _$CounterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
counter: ${counter},
frases: ${frases}
    ''';
  }
}
