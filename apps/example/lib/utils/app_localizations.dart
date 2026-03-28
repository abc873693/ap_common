import 'package:ap_common_example/l10n/strings.g.dart';

export 'package:ap_common_example/l10n/strings.g.dart';

extension AppLocalizationsExtension on AppLocalizations {
  List<String> get busSegment => <String>[
        fromJiangong,
        fromYanchao,
      ];

  List<String> get campuses => <String>[
        jiangong,
        yanchao,
        first,
        nanzi,
        qijin,
      ];
}
