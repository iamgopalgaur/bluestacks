import 'package:bluestacks/l10n/l10n.dart';
import 'package:bluestacks/providers/local_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    return DropdownButton(
      hint: Text('Lang'),
      value: provider.locale,
      items: L10n.all.map(
        (locale) {
          final flag = L10n.getFlag(locale.languageCode);
          return DropdownMenuItem(
            onTap: () {
              final provider =
                  Provider.of<LocaleProvider>(context, listen: false);
              provider.setLocale(locale);
            },
            child: Center(
              child: Text(
                flag!,
                style: TextStyle(fontSize: 25),
              ),
            ),
            value: locale,
          );
        },
      ).toList(),
      onChanged: (_) {},
    );
  }
}
