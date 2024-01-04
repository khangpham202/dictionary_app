import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/core/enum/country.dart';
import 'package:training/modules/translatePage/bloc/language/language_bloc.dart';

class LanguageSelector extends StatelessWidget {
  final Country selectedLanguage;
  final bool isSourceLanguage;
  final Function(Country) onLanguageChanged;

  const LanguageSelector({
    super.key,
    required this.selectedLanguage,
    required this.isSourceLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return PopupMenuButton<Country>(
          constraints: const BoxConstraints(maxHeight: 400),
          onSelected: (Country value) {
            onLanguageChanged(value);
            if (isSourceLanguage) {
              BlocProvider.of<LanguageBloc>(context)
                  .add(ChangeSourceLanguageEvent(value));
            } else {
              BlocProvider.of<LanguageBloc>(context)
                  .add(ChangeTargetLanguageEvent(value));
            }
          },
          itemBuilder: (BuildContext context) {
            return Country.values.map((Country value) {
              return PopupMenuItem<Country>(
                value: value,
                child: Text(value.format),
              );
            }).toList();
          },
          offset: const Offset(0, 30),
          child: Row(
            children: [
              Text(
                selectedLanguage.format,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
        );
      },
    );
  }
}
