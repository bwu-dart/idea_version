import 'dart:async' show Future;
import 'package:idea_version/get_idea_version.dart' show GetIdeaVersion;

Future<Null> main(List<String> args) async {
  final versionGetter = new GetIdeaVersion();
  final version = await versionGetter.fetchVersion();
  print(version);
}
