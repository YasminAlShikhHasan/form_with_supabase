import 'package:flutter/material.dart';
import 'package:form_with_supabase/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuestionsPage extends StatelessWidget {
  QuestionsPage({super.key});

  final stream = supabase.from('questions').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 203, 190, 206),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              print(data);

              for (var i = 0; i < data!.length; i++) {
                if (type == data[i]['type']) {
                  print(data[i]['type']);
                  List questions = data[i]['questions'];
                  print(questions);
                  return PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(questions[index],style: TextStyle(color: Colors.purple,fontSize: 30),),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "enter your answer",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          )
                        ],
                      );
                    },
                  );
                }
              }
            }
            return Text('no data');
          }),
    );
  }
}
