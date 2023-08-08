import 'package:flutter/material.dart';

import '../data/database_helper.dart';
import '../models/TranslationHistory.dart';

class HistoryScreen extends StatelessWidget {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử dịch'),
      ),
      body: FutureBuilder<List<TranslationHistory>>(
        future: dbHelper.getTranslationHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final history = snapshot.data!;
            return ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(history[index].translatedText),
                  subtitle: Text(history[index].originalText),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

