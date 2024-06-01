import 'package:flutter/material.dart';
import 'package:seyehatapp/services/model/illermodel.dart';

// ignore: must_be_immutable
class IllerWidget extends StatefulWidget {
  final List<IllerModdel> allIller;
  int secilenIlindex;
  IllerWidget({
    super.key,
    required this.allIller,
    required this.secilenIlindex,
  });

  @override
  State<IllerWidget> createState() => _IllerWidgetState();
}

class _IllerWidgetState extends State<IllerWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<IllerModdel>(
      borderRadius: BorderRadius.circular(12),
      icon: Icon(
        Icons.map,
        color: Theme.of(context).appBarTheme.backgroundColor,
      ),
      value: widget.allIller.isNotEmpty
          ? widget.allIller[widget.secilenIlindex]
          : null,
      onChanged: (var selectedIl) {
        setState(() {
          widget.secilenIlindex = widget.allIller.indexOf(selectedIl!);
        });
      },
      items:
          widget.allIller.map<DropdownMenuItem<IllerModdel>>((IllerModdel il) {
        return DropdownMenuItem<IllerModdel>(
          value: il,
          child: Text(
            il.ilAdi,
            style:
                TextStyle(color: Theme.of(context).appBarTheme.backgroundColor),
          ),
        );
      }).toList(),
    );
  }
}
