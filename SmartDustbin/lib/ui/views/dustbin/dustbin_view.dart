import 'package:flutter/material.dart';
import 'package:smart_dustbin/ui/views/dustbin/dustbin_viewmodel.dart';
import 'package:smart_dustbin/ui/widgets/animated_dustbin.dart';
import 'package:stacked/stacked.dart';

class DustbinView extends StatelessWidget {
  final VoidCallback onNavigationPressed;

  const DustbinView({
    Key key,
    this.onNavigationPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DustbinViewModel>.reactive(
      builder: (context, model, child) {
        return SafeArea(
          child: Column(
            children: [
              // Container(
              //   alignment: Alignment.centerRight,
              //   child: IconButton(
              //     icon: Icon(Icons.refresh_rounded),
              //     onPressed: model.loadTrashLevel,
              //   ),
              // ),
              Expanded(
                child: Center(
                  child: AnimatedDustbin(
                    trashLevel: model.getTrashLevel(model.data)??0,
                    isBusy: model.isBusy,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.centerRight,
                child: Text(
                  model.data.toString(),
                  style: TextStyle(color: Colors.black45),
                ),
              ),
              GestureDetector(
                onTap: onNavigationPressed,
                child: Column(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_up,
                      color: Color(0xff454545),
                    ),
                    Icon(
                      Icons.settings_outlined,
                      size: 32,
                      color: Color(0xff454545),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => DustbinViewModel(),
    );
  }
}
