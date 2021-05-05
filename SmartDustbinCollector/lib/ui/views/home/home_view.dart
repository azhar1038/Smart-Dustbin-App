import 'package:flutter/material.dart';
import 'package:smart_dustbin/ui/views/home/home_viewmodel.dart';
import 'package:smart_dustbin/ui/widgets/dustbin_card.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0, keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.loadDustbins(),
      builder: (context, model, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh_rounded),
            onPressed: model.loadDustbins,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: model.logout,
                  ),
                ),
                Expanded(
                  child: model.isBusy
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: model.dustbins
                              .map(
                                (e) => DustbinCard(
                                  percent: e.percentFull,
                                  hero: e.id,
                                  onPressed: ()=>model.navigateToDustbin(e),
                                ),
                              )
                              .toList(),
                        ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
