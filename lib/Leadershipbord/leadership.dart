import 'package:flutter/material.dart';

class LeaderboardDialog extends StatelessWidget {
  const LeaderboardDialog({super.key});
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> leaderboardData = [
      {'name': 'John', 'score': 100},
      {'name': 'Alice', 'score': 85},
      {'name': 'Bob', 'score': 72},
      {'name': 'Eva', 'score': 64},
      {'name': 'Sam', 'score': 52},
      {'name': 'Linda', 'score': 48},
      // Add more entries as needed
    ];

    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Leaderboard',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: leaderboardData.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text(leaderboardData[index]['name']),
                      const Spacer(),
                      Text(' ${leaderboardData[index]['score']}'),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  );
                  // return ListTile(
                  //   title: Text(leaderboardData[index]['name']),
                  //   subtitle: Text('Score: ${leaderboardData[index]['score']}'),
                  // );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
