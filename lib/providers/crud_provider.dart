
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sqllite_crud/providers/crud_notifier.dart';

final crudProvider =
    StateNotifierProvider<CrudNotifier, Crud>((ref) => CrudNotifier());
