import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view-model/admin/production/production_viewmodel.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputAction action;
  late bool obscureText;
  final TextInputType textInputType;
  final bool isFocus;

  CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.action,
    this.obscureText = true,
    required this.textInputType,
    required this.isFocus
  }) : super(key: key);

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
        color: const Color(0xFFDDDDDD).withOpacity(0.5),
        child: Center(
          child: TextField(
            autofocus: widget.isFocus,
            controller: widget.controller,
            keyboardType: widget.textInputType,
            textInputAction: widget.action,
            obscureText:
                (widget.hintText == 'Password') ? widget.obscureText : false,
            decoration: InputDecoration(
              prefixIcon: (widget.hintText == 'Search' || widget.hintText == 'Search ')
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
                            ? Icons.visibility_off
                            : Icons.visibility,
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
                  : ((widget.hintText == 'Search' &&
                          Provider.of<ProductionViewModel>(context,
                                  listen: false)
                              .searchController
                              .text
                              .isNotEmpty) || widget.hintText == 'Search ')
                      ? IconButton(
                          splashRadius: 20,
                          icon: const Icon(
                            Icons.close,
                            color: Color(0xFF575757),
                          ),
                          onPressed: () {
                            Provider.of<ProductionViewModel>(context,
                                    listen: false)
                                .clear();
                          },
                        )
                      : null,
            ),
            onChanged: (query) {
              if (widget.hintText == 'Search') {
                Provider.of<ProductionViewModel>(context, listen: false)
                    .search(context, query);
                setState(() {});
              }
            },
          ),
        ),
      ),
    );
  }
}
