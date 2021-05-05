import 'package:flutter/material.dart';
import 'package:smart_dustbin/datamodels/dustbin_model.dart';
import 'package:smart_dustbin/ui/views/dustbin/dustbin_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DustbinView extends StatelessWidget {
  final DustbinModel dustbin;

  const DustbinView({
    Key key,
    this.dustbin,
  }) : super(key: key);

  Color _getColor(int percent) {
    Color color;
    if (percent < 50)
      color = Colors.green[200];
    else if (percent < 80)
      color = Colors.orange[200];
    else
      color = Colors.red[200];
    return color;
  }

  static const TextStyle _header = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 2,
  );

  static const TextStyle _body = TextStyle(fontSize: 16, height: 2);

  Widget _getRow(String header, String body) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:4, horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 120,
            child: Text(header, style: _header),
          ),
          Expanded(
            child: Text(
              body,
              style: _body,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DustbinViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: _getColor(dustbin.percentFull),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(MediaQuery.of(context).size.width / 2))),
                child: Hero(
                  tag: dustbin.id,
                  child: Container(
                    height: 80,
                    width: 100,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        '${dustbin.percentFull} %',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Spacer(),
              _getRow("Dustbin Id", dustbin.id),
              _getRow("Name", dustbin.name),
              _getRow("Email", dustbin.email),
              _getRow("Address", dustbin.address),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
      viewModelBuilder: () => DustbinViewModel(),
    );
  }
}
