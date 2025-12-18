import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chatapp/constant/app_colors.dart';
import 'package:chatapp/constant/app_typography.dart';

class PhoneNumberInput extends StatelessWidget {
  final TextEditingController controller;
  final Country country;
  final bool autofocus;
  final String? placeholder;

  const PhoneNumberInput({
    super.key,
    required this.controller,
    required this.country,
    this.autofocus = false,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final borderColor = colorScheme.outline.withValues(alpha: 0.3);

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkSurfaceVariant.withValues(alpha: 0.3)
            : AppColors.lightSurfaceVariant.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '+${country.phoneCode}',
              style: AppTypography.bodyLarge(
                color: colorScheme.primary,
                fontWeight: AppTypography.fontWeightBold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: autofocus,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: AppTypography.bodyLarge(
                color: textColor,
                fontWeight: AppTypography.fontWeightMedium,
              ),
              decoration: InputDecoration(
                hintText: placeholder ?? 'phone number',
                hintStyle: AppTypography.bodyLarge(
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                isDense: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
