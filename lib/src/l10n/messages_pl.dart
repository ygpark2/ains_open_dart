
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pl';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function> {
    'Description: %s' : MessageLookupByLibrary.simpleMessage('Opis: %s'),
    'Github sample' : MessageLookupByLibrary.simpleMessage("Próbka Github"),
    'Not found' : MessageLookupByLibrary.simpleMessage("Nie znaleziono"),
    'Project Name: %s - Language: %s' : MessageLookupByLibrary.simpleMessage("Nazwa projektu: %s - Język: %s")
  };
}
