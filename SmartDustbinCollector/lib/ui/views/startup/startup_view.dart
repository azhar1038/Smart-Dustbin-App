import 'package:flutter/material.dart';
import 'package:smart_dustbin/ui/views/startup/startup_viewmodel.dart';
import 'package:smart_dustbin/ui/widgets/loader.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.nonReactive(
      onModelReady: (model) => model.startupLogic(),
      builder: (context, model, child) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(child: Loader()),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(24),
                child: Text(
                  "Fetching Data ...",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => StartupViewModel(),
    );
  }
}
