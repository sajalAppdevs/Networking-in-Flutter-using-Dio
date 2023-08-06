import 'package:flutter/material.dart';
import 'package:dio_api/views/widgets/common_text_field.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_view_model.dart';


class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  // Declare the TextEditingControllers at the class level
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    TextEditingController name = TextEditingController();
    TextEditingController password = TextEditingController();
    name.text = 'eve.holt@reqres.in';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [



            if (viewModel.isLoading) const CircularProgressIndicator(),
            if (!viewModel.isLoading && viewModel.loginError != null)
              Text(
                viewModel.loginError!,
                style: const TextStyle(color: Colors.red),
              ),
            if (viewModel.response != null)
              Text(
                viewModel.response!.toString(),
                style: const TextStyle(color: Colors.green),
              ),
            const SizedBox(height: 16),
            CommonTextField(
              controller: name,
              hintText: 'Enter your username',
              keyboardType: TextInputType.text,
              onChanged: (value) {
                // Handle username changes
              },
            ),
            Container(height: 40),
            CommonTextField(
              controller: password,
              obscureText: true,
              hintText: 'Enter your username',
              keyboardType: TextInputType.text,
              onChanged: (value) {
                // Handle username changes
              },
            ),
            Container(height: 40),
            ElevatedButton(
              onPressed: (){

                Map<dynamic,dynamic> req={
                  "email":name.text,
                  "password":password.text,
                };
                viewModel.login(req);

              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}