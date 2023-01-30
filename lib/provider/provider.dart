import 'package:provider/provider.dart';
import 'package:wgnrr/provider/date_picker_provider.dart';
import 'package:wgnrr/provider/shared_data.dart';

final appProviders = [
  ChangeNotifierProvider<SharedDate>(create: (_) => sharedDate),
  ChangeNotifierProvider<SharedData>(create: (_)=> sharedData)
];