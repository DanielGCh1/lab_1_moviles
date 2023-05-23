import 'package:flutter/material.dart';

class DropdownList extends StatefulWidget {
  final List<String> list;
  final String selectedOption;
  final ValueChanged<String> onChanged;
  final String title;
  final double? heig;

  DropdownList({
    required this.list,
    required this.selectedOption,
    required this.onChanged,
    required this.title,
    required this.heig,
    Key? key,
  }) : super(key: key);

  @override
  DropdownListState createState() => DropdownListState();
}

class DropdownListState extends State<DropdownList> {
  late String _selectedOption;
  late List<String> _list;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
    _list = widget.list;
  }

  void updateValues(List<String> newList, String newSelectedOption) {
    setState(() {
      _list = newList;
      _selectedOption = newSelectedOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.grey),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            width: double.infinity,
            child: DropdownButton<String>(
              value: _selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue ?? '';
                });
                widget.onChanged(newValue ?? '');
              },
              dropdownColor: Colors.white,
              iconSize: 30.0,
              elevation: 16,
              style: TextStyle(color: Colors.black),
              underline: Container(),
              items: _list.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(
          height: widget.heig,
        ),
      ],
    );
  }
}
