import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class TextEditorp extends StatefulWidget {
  final String initialText;
  final Function(String) onTextChanged;

  TextEditorp({required this.initialText, required this.onTextChanged});

  @override
  _TextEditorpState createState() => _TextEditorpState();
}

class _TextEditorpState extends State<TextEditorp> {
  late TextEditingController _textEditingController;
  bool _isBold = false;
  bool _isItalic = false;
  Color _textColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _textColor,
              onColorChanged: (color) => setState(() => _textColor = color),
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _toggleBold() {
    setState(() {
      _isBold = !_isBold;
    });
  }

  void _toggleItalic() {
    setState(() {
      _isItalic = !_isItalic;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
      fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
      color: _textColor,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            'Text Editor',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            onPressed: _toggleBold,
            icon: Icon(Icons.format_bold),
            color: _isBold ? Colors.blue : Colors.grey,
          ),
          IconButton(
            onPressed: _toggleItalic,
            icon: Icon(Icons.format_italic),
            color: _isItalic ? Colors.blue : Colors.grey,
          ),
          IconButton(
            onPressed: _showColorPicker,
            icon: Icon(Icons.color_lens),
            color: _textColor,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _textEditingController,
          onChanged: widget.onTextChanged,
          style: textStyle,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter some text...',
          ),
        ),
      ),
    );
  }
}
