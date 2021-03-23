import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'model_event_channel.dart';

abstract class Model {
  MethodChannel methodChannel;
  ModelEventChannel _updatesChannel;
  Map<String, SubscribedValueNotifier> _subscribedValueNotifiers = HashMap();
  Map<String, TailingValueNotifier> _tailingValueNotifiers = HashMap();

  Model(String name) {
    methodChannel = MethodChannel('${name}_method_channel');
    _updatesChannel = ModelEventChannel('${name}_event_channel');
  }

  Future<T> get<T>(String path) async {
    return methodChannel.invokeMethod('get', <String, dynamic>{
      'path': path,
    });
  }

  Future<List<T>> list<T>(String path,
      {int start = 0,
      int count = 2 ^ 32,
      String fullTextSearch,
      bool reverseSort,
      T deserialize(Uint8List serialized)}) async {
    var intermediate =
        await methodChannel.invokeMethod('list', <String, dynamic>{
      'path': path,
      'start': start,
      'count': count,
      'fullTextSearch': fullTextSearch,
      'reverseSort': reverseSort,
    });
    List<T> result = [];
    if (deserialize != null) {
      intermediate
          .forEach((element) => result.add(deserialize(element as Uint8List)));
    } else {
      intermediate.forEach((element) => result.add(element as T));
    }
    return result;
  }

  ValueNotifier<T> buildValueNotifier<T>(String path, T defaultValue,
      {bool details, T deserialize(Uint8List serialized)}) {
    SubscribedValueNotifier<T> result = _subscribedValueNotifiers[path];
    if (result == null) {
      result = SubscribedValueNotifier(path, defaultValue, _updatesChannel,
          details: details, deserialize: deserialize);
      _subscribedValueNotifiers[path] = result;
    }
    return result;
  }

  ValueNotifier<List<T>> buildTailingNotifier<T>(String path,
      {bool details, int count = 2 ^ 32, T deserialize(Uint8List serialized)}) {
    TailingValueNotifier<T> result = _tailingValueNotifiers[path];
    if (result == null) {
      result = TailingValueNotifier(path, _updatesChannel,
          details: details, count: count, deserialize: deserialize);
      _tailingValueNotifiers[path] = result;
    }
    return result;
  }

  ValueListenableBuilder<T> subscribedBuilder<T>(String path,
      {T defaultValue,
      @required ValueWidgetBuilder<T> builder,
      bool details,
      T deserialize(Uint8List serialized)}) {
    var notifier = buildValueNotifier(path, defaultValue,
        details: details, deserialize: deserialize);
    return SubscribedBuilder<T>(path, notifier, builder);
    // TODO: provide a mechanism for canceling subscriptions
  }

  ValueListenableBuilder<List<T>> tailingBuilder<T>(String path,
      {@required ValueWidgetBuilder<List<T>> builder,
      bool details,
      int count = 2 ^ 32,
      T deserialize(Uint8List serialized)}) {
    var notifier = buildTailingNotifier(path,
        details: details, count: count, deserialize: deserialize);
    return SubscribedBuilder<List<T>>(path, notifier, builder);
    // TODO: provide a mechanism for canceling subscriptions
  }
}

class SubscribedValueNotifier<T> extends ValueNotifier<T> {
  void Function() cancel;

  SubscribedValueNotifier(
      String path, T defaultValue, ModelEventChannel channel,
      {bool details, T deserialize(Uint8List serialized)})
      : super(defaultValue) {
    cancel =
        channel.subscribe(path, details: details, onNewValue: (T newValue) {
      value = newValue;
    }, deserialize: deserialize);
  }
}

class TailingValueNotifier<T> extends ValueNotifier<List<T>> {
  void Function() cancel;

  TailingValueNotifier(String path, ModelEventChannel channel,
      {bool details, int count = 2 ^ 32, T deserialize(Uint8List serialized)})
      : super([]) {
    cancel = channel.tail(path, details: details, count: count,
        onNewValue: (List<T> newValue) {
      value = newValue;
    }, deserialize: deserialize);
  }
}

class SubscribedBuilder<T> extends ValueListenableBuilder<T> {
  SubscribedBuilder(
      String path, ValueNotifier<T> notifier, ValueWidgetBuilder<T> builder)
      : super(valueListenable: notifier, builder: builder);

  @override
  _SubscribedBuilderState createState() => _SubscribedBuilderState<T>();
}

class _SubscribedBuilderState<T> extends State<ValueListenableBuilder<T>> {
  T value;

  @override
  void initState() {
    super.initState();
    value = widget.valueListenable.value;
    widget.valueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(ValueListenableBuilder<T> oldWidget) {
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_valueChanged);
      value = widget.valueListenable.value;
      widget.valueListenable.addListener(_valueChanged);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_valueChanged);
    // TODO: we should only cancel if we're the last one
    // (widget.valueListenable as SubscribedValueNotifier).cancel();
    super.dispose();
  }

  void _valueChanged() {
    setState(() {
      value = widget.valueListenable.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return Container();
    }
    return widget.builder(context, value, widget.child);
  }
}
