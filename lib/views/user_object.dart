import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/user_object_repository.dart';

class UserObjectPage extends StatefulWidget {
  const UserObjectPage({super.key});

  @override
  State<UserObjectPage> createState() => _UserObjectPageState();
}

class _UserObjectPageState extends State<UserObjectPage> {

  @override
  void initState() {
    super.initState();
    // Fetch product data when the state object is inserted into the tree.
    final productViewModel =
    Provider.of<UserObjectViewModel>(context, listen: false);
    productViewModel.fetchUserData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Object'),
      ),
      body: Consumer<UserObjectViewModel>(
        builder: (context, userViewModel, _) {
          // Fetch user data when the app starts.
          // userViewModel.fetchUserData();
          final user = userViewModel.user?.data;
          final support = userViewModel.user?.support;

          return Center(
            child: userViewModel.loading
                ? const CircularProgressIndicator()
                : userViewModel.errorMessage.isNotEmpty
                ? Text(userViewModel.errorMessage)
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user?.avatar ?? ''),
                  radius: 50,
                ),
                const SizedBox(height: 10),
                Text('ID: ${user?.id ?? 'N/A'}'),
                Text('Email: ${user?.email ?? 'N/A'}'),
                Text('First Name: ${user?.firstName ?? 'N/A'}'),
                Text('Last Name: ${user?.lastName ?? 'N/A'}'),
                const SizedBox(height: 20),
                Text('Support URL: ${support?.url ?? 'N/A'}'),
                Text('Support Text: ${support?.text ?? 'N/A'}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
