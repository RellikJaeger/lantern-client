import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'common.dart';

abstract class Model {
  late MethodChannel methodChannel;
  late ModelEventChannel _updatesChannel;
  final Map<String, SubscribedSingleValueNotifier> _singleValueNotifierCache =
      HashMap();
  final Map<String, SubscribedListNotifier> _listNotifierCache = HashMap();

  Model(String name) {
    methodChannel = MethodChannel('${name}_method_channel');
    _updatesChannel = ModelEventChannel('${name}_event_channel');
  }

  Future<T> get<T>(String path) async {
    return methodChannel.invokeMethod('get', path) as Future<T>;
  }

  Future<List<T>> list<T>(String path,
      {int start = 0,
      int count = 2 ^ 32,
      String? fullTextSearch,
      bool reverseSort = false,
      T Function(Uint8List serialized)? deserialize}) async {
    var intermediate =
        await methodChannel.invokeMethod('list', <String, dynamic>{
      'path': path,
      'start': start,
      'count': count,
      'fullTextSearch': fullTextSearch,
      'reverseSort': reverseSort,
    });
    var result = <T>[];
    if (deserialize != null) {
      intermediate
          .forEach((element) => result.add(deserialize(element as Uint8List)));
    } else {
      intermediate.forEach((element) => result.add(element as T));
    }
    return result;
  }

  ValueListenableBuilder<T?> subscribedSingleValueBuilder<T>(String path,
      {T? defaultValue,
      required ValueWidgetBuilder<T> builder,
      bool details = false,
      T Function(Uint8List serialized)? deserialize}) {
    var notifier = singleValueNotifier(path, defaultValue,
        details: details, deserialize: deserialize);
    return SubscribedSingleValueBuilder<T>(path, notifier, builder);
  }

  ValueNotifier<T?> singleValueNotifier<T>(String path, T? defaultValue,
      {bool details = false, T Function(Uint8List serialized)? deserialize}) {
    var result =
        _singleValueNotifierCache[path] as SubscribedSingleValueNotifier<T>?;
    if (result == null) {
      result = SubscribedSingleValueNotifier(
          path, defaultValue, _updatesChannel, () {
        _singleValueNotifierCache.remove(path);
      }, details: details, deserialize: deserialize);
      _singleValueNotifierCache[path] = result;
    }
    return result;
  }

  ValueListenableBuilder<ChangeTrackingList<T>> subscribedListBuilder<T>(
      String path,
      {required ValueWidgetBuilder<Iterable<PathAndValue<T>>> builder,
      bool details = false,
      int Function(String key1, String key2)? compare,
      T Function(Uint8List serialized)? deserialize}) {
    var notifier = listNotifier(path,
        details: details, compare: compare, deserialize: deserialize);
    return SubscribedListBuilder<T>(
        path,
        notifier,
        (BuildContext context, ChangeTrackingList<T> value, Widget? child) =>
            builder(
                context,
                value.map.entries.map((e) => PathAndValue(e.key, e.value)),
                child));
  }

  ValueNotifier<ChangeTrackingList<T>> listNotifier<T>(String path,
      {bool details = false,
      int Function(String key1, String key2)? compare,
      T Function(Uint8List serialized)? deserialize}) {
    var result = _listNotifierCache[path] as SubscribedListNotifier<T>?;
    if (result == null) {
      result = SubscribedListNotifier(path, _updatesChannel, () {
        _listNotifierCache.remove(path);
      }, details: details, compare: compare, deserialize: deserialize);
      _listNotifierCache[path] = result;
    }
    return result;
  }

  ValueListenableBuilder<T> listChildBuilder<T>(
      BuildContext context, String path,
      {required T defaultValue, required ValueWidgetBuilder<T> builder}) {
    return ListChildBuilder(
        ListChildValueNotifier(context, path, defaultValue), builder);
  }
}

abstract class SubscribedNotifier<T> extends ValueNotifier<T> {
  void Function() removeFromCache;
  late void Function() cancel;
  int refCount = 0;

  SubscribedNotifier(T defaultValue, this.removeFromCache)
      : super(defaultValue);

  @override
  void addListener(listener) {
    refCount++;
    super.addListener(listener);
  }

  @override
  void removeListener(listener) {
    refCount--;
    super.removeListener(listener);
    if (refCount == 0) {
      removeFromCache();
      cancel();
    }
  }
}

class PathAndValue<T> {
  String path;
  T value;

  PathAndValue(this.path, this.value);
}

class SearchResult<T> {
  String path;
  T value;
  String snippet;

  SearchResult(this.path, this.value, this.snippet);
}

class SnippetConfig<T> {
  String highlightStart;
  String hightlightEnd;
  String ellipses;
  int numTokens;

  SnippetConfig(
      this.highlightStart, this.hightlightEnd, this.ellipses, this.numTokens);
}
