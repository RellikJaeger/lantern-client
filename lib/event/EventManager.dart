import 'dart:async';

import 'package:flutter/services.dart';

import 'Event.dart';

class EventManager extends EventChannel {
  var nextSubscriberID = 0;
  final subscribers = <int, Function>{};
  final subscriptions = <int, StreamSubscription>{};

  EventManager(String name) : super(name);

  void Function() subscribe(Event event, void Function(String newEvent, Map map) onNewEvent) {
    var subscriberID = nextSubscriberID++;
    var arguments = {
      'subscriberID': subscriberID,
      'eventName': event.toShortString()
    };
    subscribers[subscriberID] = onNewEvent;
    var stream = receiveBroadcastStream(arguments);
    subscriptions[subscriberID] = listen(stream);
    return () {
      var subscription = subscriptions.remove(subscriberID);
      if (subscription != null) {
        subscribers.remove(subscriberID);
        subscription.cancel();
        if (subscribers.isNotEmpty) {
          listen(stream);
        }
      }
    };
  }

  StreamSubscription listen(Stream<dynamic> stream) {
    return stream.listen((dynamic update) {
      var updateMap = update as Map;
      var subscriberID = updateMap['subscriberID'];
      var eventName = updateMap['eventName'];
      var subscriber = subscribers[subscriberID];
      if (subscriber != null) {
        subscriber(eventName, updateMap);
      }
    });
  }
}
