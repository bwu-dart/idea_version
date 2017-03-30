
import 'dart:async' show Future;
import 'package:xml/xml.dart' show parse;
import 'package:http/http.dart' show IOClient;

// see also https://intellij-support.jetbrains.com/hc/en-us/community/posts/207155515-Programmatically-download-latest-version
class GetIdeaVersion {
  static const String updatesXmlUrl = 'https://www.jetbrains.com/updates/updates.xml';
  Future<String> fetchVersion() async {
    final response = await new IOClient().get(updatesXmlUrl);
    final xml = parse(response.body);
    final idea = ((xml
            .findElements('products')
            .first
            .findElements('product')
            .where((p) => p.getAttribute('name') == 'IntelliJ IDEA')
            .first
            .findElements('channel')
            .map((c) => c.findElements('build').toList())
            .expand((a) => a)
            .toList())
          ..sort((a, b) => double
              .parse(a.getAttribute('number'))
              .compareTo(double.parse(b.getAttribute('number')))))
        .last;
    final version = idea.getAttribute('version');
//    final channel = (idea.parent as XmlElement).getAttribute('id');

    return version;
  }
}
