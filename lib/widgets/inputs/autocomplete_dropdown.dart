import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/shared/resources/dimensions.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

typedef OnTextChangeCallback = Future<List<DropDownOption>> Function(String);

class AutocompleteDropdownWidget extends StatefulWidget {
  final List<DropDownOption> listItems;
  final Function(DropDownOption) onSelected;
  final String label;
  final String hintText;
  final Function(bool) onFocusChange;
  final Function(bool)? resetClean;
  final OnTextChangeCallback onTextChange;
  final TextEditingController? textController;
  final bool clean;
  final FormFieldValidator<DropDownOption>? validator;
  final DropDownOption? initialValue;
  final bool enabled;
  final IconData prefixIcon;

  const AutocompleteDropdownWidget({
    super.key,
    required this.listItems,
    required this.onSelected,
    required this.label,
    required this.hintText,
    required this.onFocusChange,
    this.resetClean,
    required this.onTextChange,
    this.textController,
    this.clean = true,
    this.validator,
    this.initialValue,
    this.enabled = true,
    this.prefixIcon = Icons.person_outline,
  });

  @override
  State<AutocompleteDropdownWidget> createState() =>
      _AutocompleteDropdownWidgetState();
}

class _AutocompleteDropdownWidgetState
    extends State<AutocompleteDropdownWidget> {
  DropDownOption? selectedOption;
  late TextEditingController textEditingController;

  @override
  void initState() {
    if(widget.initialValue != null) {
      // selectedOption = widget.initialValue;
      widget.listItems
          .firstWhere((option) => option.id == widget.initialValue!.id, orElse: () => DropDownOption(id: '', label: ''));
      selectedOption = widget.initialValue;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FormField<DropDownOption>(
      initialValue: widget.initialValue,
      validator: widget.validator,
      enabled: widget.enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (FormFieldState<DropDownOption> fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Autocomplete<DropDownOption>(
              
              initialValue: TextEditingValue(text: widget.initialValue?.label ?? ''),
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (fieldState.value == null && selectedOption != null) {
                  fieldState.didChange(selectedOption);
                }

                return widget.onTextChange(textEditingValue.text);
              },
              onSelected: (DropDownOption option) {
                setState(() {
                  selectedOption = option;
                });
                fieldState.didChange(selectedOption);
                widget.onSelected(option);
              },
              displayStringForOption: (DropDownOption option) => option.label,
              fieldViewBuilder: (
                BuildContext context,
                textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted,
              ) {
                return CustomInputWidget(
                  enabled: widget.enabled,
                  onFocusChangeInput: widget.onFocusChange,
                  focusNode: focusNode,
                  onFieldSubmitted: (String value) => onFieldSubmitted(),
                  controller: textEditingController,
                  label: widget.label,
                  hintText: widget.hintText,
                  prefixIcon: widget.prefixIcon,
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<DropDownOption> onSelected,
                  Iterable<DropDownOption> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    color: Colors.white,
                    elevation: 4.0,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final option = options.elementAt(index);
                          return InkWell(
                            onTap: () {
                              widget.onSelected(option);
                              fieldState.didChange(option);
                              onSelected(option);
                            },
                            child: Builder(builder: (BuildContext context) {
                              final bool highlight =
                                  AutocompleteHighlightedOption.of(context) ==
                                      index;
                              if (highlight) {
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  Scrollable.ensureVisible(context,
                                      alignment: 0.5);
                                });
                              }
                              return Container(
                                color: highlight
                                    ? Theme.of(context).focusColor
                                    : null,
                                padding:
                                    const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
                                child: Text(option.label),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            if (fieldState.hasError)
              Text(
                fieldState.errorText!,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: Dimensions.smallTextSize),
              ),
          ],
        );
      },
    );
  }
}
