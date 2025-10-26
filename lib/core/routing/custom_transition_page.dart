import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppPage<T> extends CustomTransitionPage<T> {
  AppPage({
    required super.child,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
    Duration duration = const Duration(milliseconds: 800),
    Curve curve = Curves.easeInOut,
    TransitionType transitionType = TransitionType.fade,
  }) : super(
         transitionDuration: duration,
         reverseTransitionDuration: duration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           // Use CurvedAnimation wrapper
           final curvedAnimation = CurvedAnimation(parent: animation, curve: curve);
           switch (transitionType) {
             case TransitionType.fade:
               return FadeTransition(opacity: curvedAnimation, child: child);

             case TransitionType.slideFromRight:
               return SlideTransition(
                 position: Tween<Offset>(
                   begin: const Offset(1, 0),
                   end: Offset.zero,
                 ).animate(curvedAnimation),
                 child: child,
               );

             case TransitionType.slideFromBottom:
               return SlideTransition(
                 position: Tween<Offset>(
                   begin: const Offset(0, 1),
                   end: Offset.zero,
                 ).animate(curvedAnimation),
                 child: child,
               );

             case TransitionType.scale:
               return ScaleTransition(
                 scale: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
                 child: child,
               );

             case TransitionType.slideFromLeft:
               return SlideTransition(
                 position: Tween<Offset>(
                   begin: const Offset(-1, 0),
                   end: Offset.zero,
                 ).animate(curvedAnimation),
                 child: child,
               );

             case TransitionType.slideFromTop:
               return SlideTransition(
                 position: Tween<Offset>(
                   begin: const Offset(0, -1),
                   end: Offset.zero,
                 ).animate(curvedAnimation),
                 child: child,
               );

             case TransitionType.rotation:
               return RotationTransition(
                 turns: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
                 child: child,
               );

             case TransitionType.size:
               return Align(
                 child: SizeTransition(sizeFactor: curvedAnimation, child: child),
               );

             case TransitionType.fadeSlide:
               return SlideTransition(
                 position: Tween<Offset>(
                   begin: const Offset(0, 0.3),
                   end: Offset.zero,
                 ).animate(curvedAnimation),
                 child: FadeTransition(opacity: curvedAnimation, child: child),
               );

             case TransitionType.none:
               return child;
           }
         },
       );
}

enum TransitionType {
  fade,
  slideFromRight,
  slideFromLeft,
  slideFromBottom,
  slideFromTop,
  scale,
  rotation,
  size,
  fadeSlide,
  none,
}
