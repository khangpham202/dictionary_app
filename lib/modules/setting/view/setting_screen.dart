import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training/core/common/theme/app_color.dart';
import 'package:training/modules/setting/bloc/theme/theme_bloc.dart';
import 'package:training/modules/setting/bloc/theme/theme_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // bool? isDarkTheme;
  // bool isDarkMode = false;
  // getThemeAtInit() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   isDarkTheme = sharedPreferences.getBool("is_dark");
  //   if (isDarkTheme != null && isDarkTheme!) {
  //     isDarkMode = true;
  //   } else {
  //     isDarkMode = false;
  //   }
  // }

  // void toggleTheme(bool isDarkModeTheme) async {
  //   setState(() {
  //     isDarkMode = isDarkModeTheme;
  //     isDarkMode ? ThemeMode.dark : ThemeMode.light;
  //   });

  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setBool("is_dark", !isDarkModeTheme);
  // }

  @override
  void initState() {
    super.initState();
    // getThemeAtInit();
  }

  @override
  Widget build(BuildContext context) {
    void showLanguageChoice() {
      showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 300),
        context: context,
        pageBuilder: (ctx, a1, a2) {
          return Container();
        },
        transitionBuilder: (ctx, a1, a2, child) {
          var curve = Curves.easeInOut.transform(a1.value);
          return Transform.scale(
              scale: curve,
              child: AlertDialog(
                title: Center(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade200,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          "Language",
                          style: TextStyle(
                              color: Color.fromARGB(255, 44, 46, 153),
                              fontWeight: FontWeight.w600,
                              fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // if (dictionaryType == "EV") {
                        //   Navigator.of(context).pop();
                        //   return;
                        // } else {
                        //   setState(() {
                        //     dictionaryType = "EV";
                        //     selectedItemColor =
                        //         const Color.fromARGB(255, 19, 21, 123);
                        //   });
                        // }
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/image/logo/uk_logo.png',
                            width: 30,
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                          const Gap(10),
                          const Text(
                            'English',
                            style: TextStyle(fontSize: 23),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Color.fromARGB(255, 118, 114, 114)),
                    GestureDetector(
                      onTap: () {
                        // if (dictionaryType == "VE") {
                        //   Navigator.of(context).pop();
                        //   return;
                        // } else {
                        //   setState(() {
                        //     dictionaryType = "VE";
                        //     selectedItemColor =
                        //         const Color.fromARGB(255, 182, 11, 11);
                        //   });
                        // }
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/image/logo/vn_logo.png',
                            width: 30,
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                          const Gap(10),
                          const Text(
                            'Vietnamese',
                            style: TextStyle(fontSize: 23),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppColors.kPrimary,
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 241, 237, 237),
        child: Column(
          children: [
            const Gap(20),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Gap(15),
                          Icon(
                            FontAwesomeIcons.globe,
                            size: 25,
                          ),
                          Gap(10),
                          Text(
                            'Language',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      TextButton(
                          onPressed: showLanguageChoice,
                          child: const Text(
                            'English',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ))
                    ],
                  ),
                  const Divider(color: Color.fromARGB(255, 171, 168, 168)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Gap(15),
                          Icon(
                            FontAwesomeIcons.solidMoon,
                            size: 25,
                          ),
                          Gap(10),
                          Text(
                            'Dark mode',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      BlocBuilder<ThemeBloc, ThemeState>(
                        buildWhen: (previousTheme, currentTheme) {
                          return previousTheme != currentTheme;
                        },
                        builder: (context, state) {
                          return Switch(
                            activeColor: const Color.fromARGB(255, 7, 57, 255),
                            activeTrackColor: Colors.cyan,
                            inactiveThumbColor: Colors.blueGrey.shade600,
                            inactiveTrackColor: Colors.grey.shade400,
                            splashRadius: 50.0,
                            value: state.themeData == ThemeData.dark(),
                            onChanged: (value) {
                              BlocProvider.of<ThemeBloc>(context)
                                  .add(ThemeSwitchEvent());
                            },
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
