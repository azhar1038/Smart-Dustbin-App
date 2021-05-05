import 'package:flutter/material.dart';
import 'package:smart_dustbin/ui/views/settings/settings_viewmodel.dart';
import 'package:smart_dustbin/ui/widgets/buttons.dart';
import 'package:smart_dustbin/ui/widgets/loader.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatefulWidget {
  final VoidCallback onNavigationPressed;

  const SettingsView({Key key, this.onNavigationPressed}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _height, _name, _address;

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
    return ViewModelBuilder<SettingsViewModel>.reactive(
      onModelReady: (model) {
        _height.text = model.user.dustbinHeight.toString();
        _name.text = model.user.name;
        _address.text = model.user.address;
      },
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: IconButton(
                                icon: Icon(Icons.logout),
                                tooltip: 'Logout',
                                onPressed: model.logout,
                              ),
                            ),
                          ),
                          SizedBox(height: 48),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
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
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
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
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
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
                                    title: 'Update',
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        model.update(
                                          _height.text,
                                          _name.text,
                                          _address.text,
                                        );
                                      }
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: widget.onNavigationPressed,
                  child: Column(
                    children: [
                      Icon(
                        Icons.home_outlined,
                        size: 32,
                        color: Color(0xff454545),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xff454545),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => SettingsViewModel(),
    );
  }
}
