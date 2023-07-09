import 'package:intl/intl.dart';

String formatTimeAgo(DateTime dateTime) 
{
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 1) {
    return 'حالياً';
  } else if (difference.inMinutes < 60) {
    final minutes = difference.inMinutes;
    return "منذ"  + " $minutes ${minutes >= 3 && minutes <= 10 ? 'دقائق' : 'دقيقة'} ";
  } else if (difference.inHours < 24) {
    final hours = difference.inHours;
    return "منذ"  + " $hours ${hours >= 3 && hours <= 10 ? 'ساعات' : 'ساعة'} ";
  } else if (difference.inDays < 30) {
    final days = difference.inDays;
    return "منذ"  + " $days ${days >= 3 && days <= 10 ? 'أيام' : 'يوم'} ";
  } else {
    final formatter = DateFormat('dd-MMM-yyyy');
    return formatter.format(dateTime);
  }
}
