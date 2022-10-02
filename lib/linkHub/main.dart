import 'package:labelling/linkHub/event.dart';
import 'package:labelling/linkHub/consumer_interface.dart';

class LinkHub {
  static final _registry = <String, HubConsumer>{};
  static final _eventRetention = <HubEvent>[];

  static void subscribe(String channel, HubConsumer consumer) {
    if (_registry.containsKey(channel)) {
      throw Exception("A subscriber for channel '$channel' already exist");
    }
    _registry[channel] = consumer;
    _emitAllRetainsEvent();
  }

  static void emit(HubEvent eventToEmit) {
    _retainsEvent(eventToEmit);
    final isEmitted = _tryToEmit(eventToEmit);
    if (isEmitted) _removeEvent(eventToEmit);
  }

  static void _emitAllRetainsEvent() {
    for (final eventToEmit in _eventRetention) {
      _tryToEmit(eventToEmit);
    }
  }

  static _tryToEmit(HubEvent eventToEmit) {
    var succeed = false;
    _registry.forEach((channel, consumer) {
      if (channel == eventToEmit.channel) {
        consumer.handleHubEvent(eventToEmit);
        succeed = true;
      }
    });
    return succeed;
  }

  static void _retainsEvent(HubEvent event) {
    _eventRetention.add(event);
  }

  static void _removeEvent(HubEvent event) {
    _registry.remove(event);
  }
}
