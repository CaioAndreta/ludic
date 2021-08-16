import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ludic/shared/themes/app_colors.dart';
import 'package:ludic/shared/themes/app_textstyles.dart';

class DatePicker extends StatefulWidget {
  DatePicker({Key? key, required this.selectedDate}) : super(key: key);

  DateTime selectedDate = DateTime.now();
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != widget.selectedDate)
      setState(() {
        widget.selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text('Data de Envio:', style: TextStyles.primaryHintText),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          width: size.width * 0.8,
          decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(29),
              border: Border.all(color: AppColors.primary)),
          child: TextButton(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                primary: AppColors.primary),
            onPressed: () {
              _selectDate(context);
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}',
                style: TextStyles.primaryCodigoSala,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
