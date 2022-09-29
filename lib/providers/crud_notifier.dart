// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sqllite_crud/models/personal_model.dart';
import 'package:flutter_sqllite_crud/services/services.dart';

class Crud {
  Crud({
    this.persons,
    this.isUpdateButtonDisable,
  });

  final bool? isUpdateButtonDisable;
  final List<PersonalModal>? persons;
}

class CrudNotifier extends StateNotifier<Crud> {
  CrudNotifier()
      : super(Crud(
          persons: [],
          isUpdateButtonDisable: true,
        )) {
    initAll();
  }

  TextEditingController? firstname;
  TextEditingController? lastname;
  PersonalModal? person;

  initAll() {
    firstname = TextEditingController();
    lastname = TextEditingController();
    createTable();
    fetchData();
  }

  void createTable() {
    Services.createTable();
  }

  void addPerson(BuildContext context) {
    if (firstname!.text.isEmpty || lastname!.text.isEmpty) {
      showSnackBar(context, "Text feild can't empty");
    } else {
      Services.addPerson(firstname!.text, lastname!.text).whenComplete(() {
        showSnackBar(context, "Add Person");
        clear();
        fetchData();

        updatewith(isUpdateButtonDisable: true);
      });
    }
  }

  void fetchData() {
    Services.fetchData().then((persons) {
      return updatewith(persons: persons);
    });
  }

  void updatePerson(PersonalModal person, BuildContext context) {
    if (firstname!.text.isEmpty || lastname!.text.isEmpty) {
      showSnackBar(context, "Text feild can't empty");
    } else {
      Services.updatePerson(person.id!, firstname!.text, lastname!.text)
          .whenComplete(() {
        updatewith(isUpdateButtonDisable: true);
        showSnackBar(context, "Update Person");
        fetchData();
        clear();
      });
    }
  }

  deletePerson(PersonalModal person, BuildContext context) {
    Services.deletePerson(person.id!).whenComplete(() {
      showSnackBar(context, "Delete Person");
      clear();
      fetchData();
    });
  }

  updatewith({
    bool? isUpdateButtonDisable,
    List<PersonalModal>? persons,
  }) {
    state = Crud(
      isUpdateButtonDisable:
          isUpdateButtonDisable ?? state.isUpdateButtonDisable,
      persons: persons ?? state.persons,
    );
  }

  void showSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(message),
    ));
  }

  void showUpdateText(PersonalModal person) {
    firstname!.text = person.firstname!;
    lastname!.text = person.lastname!;
  }

  void clear() {
    firstname!.text = "";
    lastname!.text = "";
  }

  void buttonDisble() {
    updatewith(isUpdateButtonDisable: false);
  }
}
