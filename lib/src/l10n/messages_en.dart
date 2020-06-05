
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function> {
    'Description: %s' : MessageLookupByLibrary.simpleMessage('Description: %s'),
    'Github sample' : MessageLookupByLibrary.simpleMessage('Github sample'),
    'Not found' : MessageLookupByLibrary.simpleMessage('Not found'),
    'Project Name: %s - Language: %s' : MessageLookupByLibrary.simpleMessage('Project Name: %s - Language: %s')
  };
}
