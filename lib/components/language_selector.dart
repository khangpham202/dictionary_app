import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/core/enum/language.dart';
import 'package:training/modules/translatePage/bloc/language/language_bloc.dart';

class LanguageSelector extends StatelessWidget {
  final Language selectedLanguage;
  final bool isSourceLanguage;
  final Function(Language) onLanguageChanged;

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
        return PopupMenuButton<Language>(
          constraints: BoxConstraints(maxHeight: 400),
          onSelected: (Language value) {
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
            return Language.values.map((Language value) {
              return PopupMenuItem<Language>(
                value: value,
                child: Text(value.name.toString()),
              );
            }).toList();
          },
          offset: Offset(0, 30),
          child: Row(
            children: [
              Text(
                selectedLanguage.name.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
        );
      },
    );
  }
}

        // return DropdownButton<Language>(
        //   value: selectedLanguage,
        //   items:
        //       Language.values.map<DropdownMenuItem<Language>>((Language value) {
        //     return DropdownMenuItem<Language>(
        //       value: value,
        //       child: Text(
        //         value.name.toString(),
                // style: TextStyle(
                //   color: Colors.white,
                //   fontSize: 20,
                // ),
        //       ),
        //     );
        //   }).toList(),
        //   underline: Container(
        //     color: Colors.transparent,
        //   ),
        //   focusColor: Colors.transparent,
        //   menuMaxHeight: MediaQuery.of(context).size.height / 2,
        //   iconEnabledColor: Colors.white,
        //   dropdownColor: Colors.black,
        //   // dropdownColor: Color.fromRGBO(18, 55, 149, 0.914),
        //   onChanged: (Language? value) {
        //     onLanguageChanged(value!);
        //     if (isSourceLanguage) {
        //       BlocProvider.of<LanguageBloc>(context)
        //           .add(ChangeSourceLanguageEvent(value));
        //     } else {
        //       BlocProvider.of<LanguageBloc>(context)
        //           .add(ChangeTargetLanguageEvent(value));
        //     }
        //   },
        // );