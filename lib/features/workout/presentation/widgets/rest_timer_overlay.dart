import 'dart:math' as math;

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

class _FloatingRestTimerOverlayState extends State<FloatingRestTimerOverlay>
    with SingleTickerProviderStateMixin {
  static const double _chipWidth = 172;
  static const double _chipHeight = 68;
  static const double _minStopSpeed = 55;
  static const double _bounceLoss = 0.58;
  static const double _wallFriction = 0.94;

  Offset? _position;
  late final AnimationController _inertiaController;
  Offset _velocity = Offset.zero;
  Duration? _lastElapsed;
  Size _lastScreenSize = Size.zero;
  EdgeInsets _lastSafePadding = EdgeInsets.zero;

  @override
  void initState() {
    super.initState();
    _inertiaController = AnimationController.unbounded(vsync: this);
    _inertiaController.addListener(() {
      if (!mounted || !_inertiaController.isAnimating) {
        return;
      }
      _stepInertia();
    });
  }

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

    _lastScreenSize = screenSize;
    _lastSafePadding = safePadding;

    final defaultPosition = Offset(
      screenSize.width - _chipWidth - 16,
      screenSize.height - safePadding.bottom - _chipHeight - 100,
    );

    final rawPos = _position ?? defaultPosition;
    final pos = _clampPosition(
      rawPos,
      screenSize,
      safePadding,
      _chipWidth,
      _chipHeight,
    );

    return Positioned(
      left: pos.dx,
      top: pos.dy,
      child: GestureDetector(
        onPanStart: (_) => _stopInertia(),
        onPanUpdate: (details) {
          final base = _position ?? pos;
          setState(() {
            _position = _clampPosition(
              base + details.delta,
              screenSize,
              safePadding,
              _chipWidth,
              _chipHeight,
            );
          });
        },
        onPanEnd: (details) {
          _startInertia(details.velocity.pixelsPerSecond);
        },
        child: _TimerChip(service: widget.service),
      ),
    );
  }

  Offset _clampPosition(
    Offset raw,
    Size screenSize,
    EdgeInsets safePadding,
    double chipWidth,
    double chipHeight,
  ) {
    return Offset(
      raw.dx.clamp(0.0, screenSize.width - chipWidth),
      raw.dy.clamp(
        safePadding.top + 8,
        screenSize.height - safePadding.bottom - chipHeight,
      ),
    );
  }

  void _startInertia(Offset initialVelocity) {
    _stopInertia();

    if (initialVelocity.distance < _minStopSpeed) {
      return;
    }

    _velocity = initialVelocity;
    _lastElapsed = null;
    _inertiaController
      ..value = 0
      ..repeat(min: 0, max: 1, period: const Duration(milliseconds: 16));
  }

  void _stepInertia() {
    final elapsed = _inertiaController.lastElapsedDuration;
    if (elapsed == null) {
      return;
    }

    final previousElapsed = _lastElapsed;
    _lastElapsed = elapsed;
    if (previousElapsed == null) {
      return;
    }

    final dtMicroseconds = (elapsed - previousElapsed).inMicroseconds;
    if (dtMicroseconds <= 0) {
      return;
    }

    final dt = dtMicroseconds / 1000000.0;
    final friction = math.pow(0.90, dt * 60).toDouble();

    final minX = 0.0;
    final maxX = (_lastScreenSize.width - _chipWidth).clamp(0.0, double.infinity);
    final minY = _lastSafePadding.top + 8;
    final maxY = (_lastScreenSize.height - _lastSafePadding.bottom - _chipHeight)
        .clamp(minY, double.infinity);

    final current = _position ?? Offset(maxX - 16, maxY - 16);
    var next = current + Offset(_velocity.dx * dt, _velocity.dy * dt);
    var nextVelocity = Offset(_velocity.dx * friction, _velocity.dy * friction);

    if (next.dx < minX) {
      next = Offset(minX, next.dy);
      nextVelocity = Offset(
        nextVelocity.dx.abs() * _bounceLoss,
        nextVelocity.dy * _wallFriction,
      );
    } else if (next.dx > maxX) {
      next = Offset(maxX, next.dy);
      nextVelocity = Offset(
        -nextVelocity.dx.abs() * _bounceLoss,
        nextVelocity.dy * _wallFriction,
      );
    }

    if (next.dy < minY) {
      next = Offset(next.dx, minY);
      nextVelocity = Offset(
        nextVelocity.dx * _wallFriction,
        nextVelocity.dy.abs() * _bounceLoss,
      );
    } else if (next.dy > maxY) {
      next = Offset(next.dx, maxY);
      nextVelocity = Offset(
        nextVelocity.dx * _wallFriction,
        -nextVelocity.dy.abs() * _bounceLoss,
      );
    }

    if (nextVelocity.distance < _minStopSpeed) {
      _stopInertia();
      return;
    }

    setState(() {
      _position = next;
      _velocity = nextVelocity;
    });
  }

  void _stopInertia() {
    _inertiaController.stop();
    _lastElapsed = null;
    _velocity = Offset.zero;
  }

  @override
  void dispose() {
    _inertiaController.dispose();
    super.dispose();
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
      color: Colors.transparent,
      child: Container(
        width: 172,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.38),
            width: 1.4,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.12),
              blurRadius: 14,
              spreadRadius: 1,
            ),
          ],
        ),
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
