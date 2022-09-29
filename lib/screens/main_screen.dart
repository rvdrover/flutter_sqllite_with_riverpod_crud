import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sqllite_crud/providers/crud_provider.dart';
import 'package:flutter_sqllite_crud/widgets/custom_button.dart';
import 'package:flutter_sqllite_crud/widgets/custom_textfield.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crudNotifier = ref.watch(crudProvider.notifier);
    final crud = ref.watch(crudProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Flutter & SqlLite")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(
                parent: NeverScrollableScrollPhysics()),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      "Enter Your details",
                      style: TextStyle(fontSize: 40, color: Colors.blueGrey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                CustomTxtFeild(
                  controller: crudNotifier.firstname!,
                  hint: "First Name",
                  lable: 'First Name',
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTxtFeild(
                  controller: crudNotifier.lastname!,
                  hint: "Last Name",
                  lable: 'Last Name',
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      onPressed: () => crudNotifier.addPerson(context),
                      child: const Text("ADD"),
                    ),
                    CustomButton(
                      onPressed: () {
                        if (crud.isUpdateButtonDisable == true) {
                          crudNotifier.showSnackBar(
                              context, "Please click person field to update");
                        } else {
                          crudNotifier.updatePerson(
                              crudNotifier.person!, context);
                        }
                      },
                      child: const Text("UPDATE"),
                    ),
                    CustomButton(
                      onPressed: () => crudNotifier.clear(),
                      child: const Text("CLEAR"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
                itemCount: crud.persons!.length,
                itemBuilder: (context, index) => ListTile(
                      title: Text(
                          "${crud.persons![index].firstname} ${crud.persons![index].lastname}"),
                      leading: Text(crud.persons![index].id!.toString()),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          crudNotifier.deletePerson(
                              crud.persons![index], context);
                        },
                      ),
                      onTap: () {
                        crudNotifier.buttonDisble();
                        crudNotifier.showUpdateText(crud.persons![index]);
                        crudNotifier.person = crud.persons![index];
                      },
                    )),
          ),
        ],
      ),
    );
  }
}
