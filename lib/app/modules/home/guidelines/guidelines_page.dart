import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pautas_app/app/modules/home/guidelines/guidelines_controller.dart';

class GuidelinesPage extends StatefulWidget {
  GuidelinesPage({Key key}) : super(key: key);

  @override
  _GuidelinesPageState createState() => _GuidelinesPageState();
}

class _GuidelinesPageState
    extends ModularState<GuidelinesPage, GuidelinesController> {
  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Abertas'),
              Tab(text: 'Finalizadas'),
            ],
          ),
          title: Text('Pautas'),
          actions: <Widget>[
            RaisedButton(
              onPressed: controller.logout,
              child: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              color: Colors.blue,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.register,
          child: Icon(Icons.add),
        ),
        body: TabBarView(
          children: [
            Observer(
              builder: (_) {
                return controller.guidelinesOpenList.length > 0
                    ? ListView.builder(
                        itemCount: controller.guidelinesOpenList.length,
                        itemBuilder: buildItemOpen,
                      )
                    : Center(
                        child: Text('Nenhuma pauta aberta.'),
                      );
              },
            ),
            Observer(
              builder: (_) {
                return controller.guidelinesCloseList.length > 0
                    ? ListView.builder(
                        itemCount: controller.guidelinesCloseList.length,
                        itemBuilder: buildItemClose,
                      )
                    : Center(
                        child: Text('Nenhuma pauta finalizada.'),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemOpen(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).buttonColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: EdgeInsets.all(3),
      child: ExpansionTile(
        title: Text(
          controller.guidelinesOpenList[index].title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          controller.guidelinesOpenList[index].description,
        ),
        children: [
          ListTile(
            title: Text(controller.guidelinesOpenList[index].details),
          ),
          ListTile(
            title: Text(controller.guidelinesOpenList[index].author),
          ),
          Row(
            children: [
              Expanded(
                child: RaisedButton(
                  onPressed: () => controller
                      .closeGuideline(controller.guidelinesOpenList[index]),
                  color: Colors.blue,
                  child: Text(
                    'Finalizar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildItemClose(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).buttonColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: EdgeInsets.all(3),
      child: ExpansionTile(
        title: Text(
          controller.guidelinesCloseList[index].title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          controller.guidelinesCloseList[index].description,
        ),
        children: [
          ListTile(
            title: Text(controller.guidelinesCloseList[index].details),
          ),
          ListTile(
            title: Text(controller.guidelinesCloseList[index].author),
          ),
          Row(
            children: [
              Expanded(
                child: RaisedButton(
                  onPressed: () => controller
                      .reopenGuideline(controller.guidelinesCloseList[index]),
                  color: Colors.blue,
                  child: Text(
                    'Reabrir',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
