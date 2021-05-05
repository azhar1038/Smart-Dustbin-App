import 'package:flutter/material.dart';
import 'package:smart_dustbin/ui/views/signin/signin_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Sign in with:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 48,
                  alignment: Alignment.center,
                  child: model.isBusy
                      ? CircularProgressIndicator()
                      : GestureDetector(
                    onTap: model.googleLogin,
                    child: Image.asset("assets/google.png", height: 40),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => SignInViewModel(),
    );
  }
}
