import 'package:get/get.dart';

import 'languages/en_us.dart';
import 'languages/es_es.dart';


class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUS, 'es_ES': esES};
}
