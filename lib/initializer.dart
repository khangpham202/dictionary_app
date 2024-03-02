part of 'main.dart';

class _Initializer {
  static Future<void> start() async {
    WidgetsFlutterBinding.ensureInitialized();
    _initialFirebase();
    await EasyLocalization.ensureInitialized();
  }

  static Future<void> _initialFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      routerConfig.refresh();
    });
  }
}
