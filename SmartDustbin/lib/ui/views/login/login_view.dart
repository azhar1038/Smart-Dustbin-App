import 'package:flutter/material.dart';
import 'package:smart_dustbin/ui/views/login/login_viewmodel.dart';
import 'package:smart_dustbin/ui/widgets/buttons.dart';
import 'package:smart_dustbin/ui/widgets/loader.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _name, _address, _height;

  @override
  void initState() {
    _name = TextEditingController();
    _address = TextEditingController();
    _height = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _height.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Smart Dustbin",
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24),
                        child: TextFormField(
                          controller: _name,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Enter your Name',
                          ),
                          validator: model.nameValidator,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24),
                        child: TextFormField(
                          minLines: 3,
                          maxLines: 5,
                          controller: _address,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Enter your Address',
                          ),
                          validator: model.addressValidator,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24),
                        child: TextFormField(
                          controller: _height,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Enter Dustbin  height',
                          ),
                          validator: model.heightValidator,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 80,
                        child: model.isBusy
                            ? Loader()
                            : GeneralButton(
                                title: 'Register',
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    model.register(_height.text, _name.text, _address.text);
                                  }
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
