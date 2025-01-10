import 'package:edu_app/app/routes/routes.dart';
import 'package:edu_app/common/layout/app_navigation_bar.dart';
import 'package:edu_app/common/layout/app_safe_area.dart';
import 'package:edu_app/features/auth/conrollers/auth_provider.dart';
import 'package:edu_app/features/textbook/views/screens/admin_dash.dart';
import 'package:edu_app/features/textbook/views/widgets/book_section.dart';
import 'package:edu_app/features/textbook/views/widgets/featured_book_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider)?['user'];

    return AppSafeArea(
        child: Scaffold(
      appBar: _buildAppBar(user.name),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LatestBookSection(),
              SizedBox(height: 20),
              FeaturedBookSection(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppNavigationBar(currentIndex: 0),
    ));
  }

  AppBar _buildAppBar(String name) {
    return AppBar(
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
              color: Theme.of(context).primaryColor,
              size: 25.0,
            ),
            onPressed: () {
              context.replaceNamed(bookListRoute.name as String);
            },
          ),
        ),
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminDashScreen(),
              ),
            );
          },
          icon: Icon(
            Icons.menu_book_outlined, 
            color: Colors.blue,
            size: 25, 
          ),
          tooltip: "Manage Books",
        ),
      ),
      
      
      ],
    );
  }
}
