import 'package:intl/intl.dart';

String fromatDateBydMMMYYYY(DateTime dateTime) {
  return DateFormat("d MMM, yyyy").format(dateTime);
}
