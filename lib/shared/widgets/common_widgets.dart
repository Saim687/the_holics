import 'package:flutter/material.dart';
import 'package:the_holics/core/theme/app_theme.dart';

class HolicsLogo extends StatelessWidget {
  final double size;

  const HolicsLogo({Key? key, this.size = 48}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: AppTheme.orangeGradient,
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: Center(
        child: Text(
          'H',
          style: TextStyle(
            fontSize: size * 0.55,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class HolicsCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Border? border;
  final EdgeInsets? margin;

  const HolicsCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.backgroundColor,
    this.border,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        border: border ?? Border.all(color: AppTheme.borderColor, width: 0.5),
        boxShadow: [AppTheme.cardShadow],
      ),
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: child,
      ),
    );
  }
}

class HolicsTextField extends StatefulWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final VoidCallback? onShowPassword;

  const HolicsTextField({
    Key? key,
    required this.label,
    required this.placeholder,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onShowPassword,
  }) : super(key: key);

  @override
  State<HolicsTextField> createState() => _HolicsTextFieldState();
}

class _HolicsTextFieldState extends State<HolicsTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: _obscureText,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppTheme.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

class HolicsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const HolicsAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBackPressed ?? () => Navigator.pop(context),
            )
          : null,
      actions: actions,
      backgroundColor: AppTheme.darkBg,
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget? desktopBody;

  const ResponsiveLayout({
    Key? key,
    required this.mobileBody,
    this.desktopBody,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return isMobile ? mobileBody : (desktopBody ?? mobileBody);
  }
}
