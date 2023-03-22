// Step 5: Create the view
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model.dart/user_view_model.dart';

class UserList extends StatefulWidget {
  const UserList({super.key}); // A stateful widget to display the users

  @override
  State<UserList> createState() => _UserListState(); // Returns the state of the widget
}

class _UserListState extends State<UserList> {
  @override
  void initState() { // Called when the state object is inserted into the tree.
    super.initState();

    final userViewModel = Provider.of<UserViewModel>(context, listen: false); // Fetches userViewModel object
    userViewModel.fetchUsers(); // Calls the method to fetch the users

  }

  @override
  Widget build(BuildContext context) { // Build method which returns the UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Consumer<UserViewModel>( // Consumer widget to listen for changes in UserViewModel
        builder: (context, userViewModel, child) {
          if (userViewModel.loading) { // If data is still loading, show a progress indicator
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (userViewModel.errorMessage.isNotEmpty) { // If there is an error, show the error message
            return Center(
              child: Text(userViewModel.errorMessage),
            );
          } else { // Otherwise, show the list of users
            return ListView.builder(
              itemCount: userViewModel.users.length,
              itemBuilder: (context, index) {
                final user = userViewModel.users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  leading: CircleAvatar(
                    child: Text(user.id.toString()),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
