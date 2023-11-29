// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:training/core/enum/language.dart';
// import 'package:training/modules/translatePage/bloc/language/language_bloc.dart';

// class LanguageSelector extends StatelessWidget {
//   const LanguageSelector({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LanguageBloc, LanguageState>(
//       builder: (context, state) {
//         late Language selectedLanguage;

//         return Column(
//           children: [
//             Text('$label: $selectedLanguage'),
//             SizedBox(height: 10),
//             DropdownButton<String>(
//               value: selectedLanguage,
//               onChanged: (newValue) {
//                 context.read<LanguageBloc>().add(
//                       ChangeLanguageEvent(
//                         sourceLanguage: isSource
//                             ? newValue!
//                             : context.read<LanguageBloc>().state.sourceLanguage,
//                         targetLanguage: isSource
//                             ? context.read<LanguageBloc>().state.targetLanguage
//                             : newValue!,
//                       ),
//                     );
//               },
//               items: languages.map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
