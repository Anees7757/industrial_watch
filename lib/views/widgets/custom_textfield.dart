import 'package:flutter/material.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/employeeRecord_viewmodel.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputAction action;
  late bool obscureText;
  final TextInputType textInputType;
  final bool isFocus;
  late bool readOnly;

  CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.action,
      this.obscureText = true,
      required this.textInputType,
      required this.isFocus,
      this.readOnly = false})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 56.79,
        color: widget.hintText == 'Search Employee'
            ? Colors.white
            : const Color(0xFFDDDDDD).withOpacity(0.5),
        child: Center(
          child: TextField(
            readOnly: widget.readOnly,
            autofocus: widget.isFocus,
            controller: widget.controller,
            keyboardType: widget.textInputType,
            textInputAction: widget.action,
            obscureText:
                (widget.hintText == 'Password') ? widget.obscureText : false,
            decoration: InputDecoration(
              prefixIcon: (widget.hintText.contains('Search'))
                  ? const Icon(Icons.search, color: Color(0xFF575757))
                  : null,
              hintText: widget.hintText,
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
              suffixIcon: (widget.hintText == 'Password')
                  ? IconButton(
                      splashRadius: 20,
                      icon: Icon(
                        widget.obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xFF575757),
                      ),
                      onPressed: () {
                        setState(() {
                          setState(() {
                            widget.obscureText = !widget.obscureText;
                          });
                        });
                      },
                    )
                  : ((widget.hintText == 'Search Employee' &&
                              Provider.of<EmployeeRecordViewModel>(context,
                                      listen: false)
                                  .searchController
                                  .text
                                  .isNotEmpty) ||
                          widget.hintText == 'Search')
                      ? IconButton(
                          splashRadius: 20,
                          icon: const Icon(
                            Icons.close,
                            color: Color(0xFF575757),
                          ),
                          onPressed: () {
                            Provider.of<EmployeeRecordViewModel>(context,
                                    listen: false)
                                .searchController
                                .clear();
                          },
                        )
                      : null,
            ),
          ),
        ),
      ),
    );
  }
}
