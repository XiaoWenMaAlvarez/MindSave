import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      color: colors.primary,
      fontWeight: FontWeight.w600,
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 28,
                width: 28,
                child: Image.asset("assets/img/icon.png", fit: BoxFit.contain),
              ),
              //Icon(Icons.psychology_alt_outlined, color: colors.primary, size: 32,),
              const SizedBox(width: 5),
              Text('Mind Save', style: titleStyle,),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}