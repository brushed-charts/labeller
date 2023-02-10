import 'package:labelling/linkHub/event.dart';

abstract class HubConsumer {
  handleHubEvent(HubEvent event);
}
