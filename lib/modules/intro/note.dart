// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<Album> fetchAlbum() async {
//   final response =
//       await http.get(Uri.parse('https://fakestoreapi.com/products/1'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// class Album {
//   final int id;
//   final String title;
//   final double price;
//   final String category;
//   final String description;
//   final String image;

//   const Album({
//     required this.id,
//     required this.title,
//     required this.price,
//     required this.category,
//     required this.description,
//     required this.image,
//   });

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       id: json['id'] as int,
//       title: json['title'] as String,
//       price: json['price'] as double,
//       category: json['category'] as String,
//       description: json['description'] as String,
//       image: json['image'] as String,
//     );
//   }
// }

// void main() => runApp(const MyAppp());

// class MyAppp extends StatefulWidget {
//   const MyAppp({super.key});

//   @override
//   State<MyAppp> createState() => _MyApppState();
// }

// class _MyApppState extends State<MyAppp> {
//   late Future<Album> futureAlbum;

//   @override
//   void initState() {
//     super.initState();
//     futureAlbum = fetchAlbum();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fetch Data Example',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Fetch Data Example'),
//         ),
//         body: Center(
//           child: FutureBuilder<Album>(
//             future: futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 // const productInfo = snapshot.data;
//                 return Column(
//                   children: [
//                     Text(snapshot.data!.title),
//                     Image.network(
//                       snapshot.data!.image,
//                       height: 200,
//                       width: 200,
//                     ),
//                   ],
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }

//               // By default, show a loading spinner.
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../util/api_service.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TranslationService translationService = TranslationService();
  String translatedText = '';

  @override
  void initState() {
    super.initState();
    translateText();
  }

  Future<void> translateText() async {
    try {
      final result = await translationService.translate('Low', 'vi');
      setState(() {
        translatedText = result;
      });
    } catch (error) {
      print('Translation error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Translated Text Example'),
        ),
        body: Center(
          child: Text(
            translatedText.isNotEmpty ? translatedText : 'Loading...',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
