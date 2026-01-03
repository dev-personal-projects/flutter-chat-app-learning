import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chatapp/constant/app_colors.dart';
import 'package:chatapp/constant/app_typography.dart';

class OTPInput extends StatefulWidget {
  final ValueChanged<String> onCompleted;
  final bool autofocus;

  const OTPInput({
    super.key,
    required this.onCompleted,
    this.autofocus = true,
  });

  @override
  State<OTPInput> createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 6; i++) {
      _controllers[i].addListener(() => _onDigitChanged(i));
    }
    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNodes[0].requestFocus();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index) {
    final text = _controllers[index].text;
    if (text.length == 6) {
      _handlePaste(text);
      return;
    }
    if (text.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (_isComplete()) {
      _focusNodes[index].unfocus();
      widget.onCompleted(_getOTPCode());
    }
  }

  void _handlePaste(String pastedText) {
    final digits = pastedText.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length >= 6) {
      for (int i = 0; i < 6; i++) {
        _controllers[i].text = digits[i];
      }
      _focusNodes[5].requestFocus();
      if (_isComplete()) {
        widget.onCompleted(_getOTPCode());
      }
    }
  }

  bool _isComplete() {
    return _controllers.every((controller) => controller.text.isNotEmpty);
  }

  String _getOTPCode() {
    return _controllers.map((controller) => controller.text).join();
  }

  void _handleBackspace(int index) {
    if (_controllers[index].text.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
    } else {
      _controllers[index].clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor =
        isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant;
    final filledColor = colorScheme.primary;
    final textColor =
        isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        final isFilled = _controllers[index].text.isNotEmpty;
        return SizedBox(
          width: 45,
          height: 55,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            maxLength: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: AppTypography.headlineMedium(
              color: textColor,
              fontWeight: AppTypography.fontWeightBold,
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                _handleBackspace(index);
              }
            },
            decoration: InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.zero,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isFilled ? filledColor : borderColor,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: filledColor, width: 2),
              ),
              filled: true,
              fillColor: isFilled
                  ? filledColor.withValues(alpha: 0.1)
                  : Colors.transparent,
            ),
          ),
        );
      }),
    );
  }
}
