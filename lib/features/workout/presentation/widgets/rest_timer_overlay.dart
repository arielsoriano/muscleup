import 'package:flutter/material.dart';

import '../services/rest_timer_service.dart';

class FloatingRestTimerOverlay extends StatefulWidget {
  const FloatingRestTimerOverlay({
    required this.service,
    required this.child,
    super.key,
  });

  final RestTimerService service;
  final Widget child;

  @override
  State<FloatingRestTimerOverlay> createState() =>
      _FloatingRestTimerOverlayState();
}

class _FloatingRestTimerOverlayState extends State<FloatingRestTimerOverlay> {
  Offset? _position;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        ListenableBuilder(
          listenable: widget.service,
          builder: (context, _) {
            if (!widget.service.isActive) return const SizedBox.shrink();
            return _buildPositioned(context);
          },
        ),
      ],
    );
  }

  Widget _buildPositioned(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final safePadding = MediaQuery.paddingOf(context);

    const chipWidth = 172.0;
    const chipHeight = 68.0;

    final defaultPosition = Offset(
      screenSize.width - chipWidth - 16,
      screenSize.height - safePadding.bottom - chipHeight - 100,
    );

    final rawPos = _position ?? defaultPosition;
    final pos = Offset(
      rawPos.dx.clamp(0.0, screenSize.width - chipWidth),
      rawPos.dy.clamp(
        safePadding.top + 8,
        screenSize.height - safePadding.bottom - chipHeight,
      ),
    );

    return Positioned(
      left: pos.dx,
      top: pos.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _position = pos + details.delta;
          });
        },
        child: _TimerChip(service: widget.service),
      ),
    );
  }
}

class _TimerChip extends StatelessWidget {
  const _TimerChip({required this.service});

  final RestTimerService service;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final seconds = service.remainingSeconds ?? 0;
    final progress = service.progress;

    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(16),
      shadowColor: colorScheme.shadow,
      color: colorScheme.surfaceContainer,
      child: SizedBox(
        width: 172,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 8, 8),
              child: Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 18,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      '${seconds}s',
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => service.addSeconds(30),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      child: Text(
                        '+30s',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  InkWell(
                    onTap: () => service.stop(),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.close_rounded,
                        size: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 4,
                backgroundColor: colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
