import 'package:flutter/material.dart';
import 'package:edu_app/common/layout/app_navigation_bar.dart';
import 'package:edu_app/common/layout/app_safe_area.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:edu_app/features/auth/conrollers/auth_provider.dart';

class QuizList extends ConsumerWidget {
  const QuizList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider)?['user'];
    return AppSafeArea(
        child: Scaffold(
      appBar: _buildAppBar(user.name),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_quizList()]),
        ),
      ),
      bottomNavigationBar: AppNavigationBar(),
    ));
  }

  AppBar _buildAppBar(String name) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, $name!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    "Let’s start reading",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          )),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedSearch01,
              color: Colors.black,
              size: 25.0,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _quizList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: 15,
      itemBuilder: (context, index) {
        return Row(children: [
          Expanded(
            child: Card(
              color: Colors.red.shade50,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                title: Text('Quiz ${index * 2 + 1}'),
                subtitle: Text('Description for Quiz ${index * 2 + 1}'),
                onTap: () {},
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Card(
              color: Colors.red.shade50,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                title: Text('Quiz ${index * 2 + 2}'),
                subtitle: Text('Description for Quiz ${index * 2 + 2}'),
                onTap: () {},
              ),
            ),
          ),
        ]);
      },
    );
  }
}
