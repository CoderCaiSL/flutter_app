// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app2/http_utils/HttpUtils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:pull_to_refresh/pull_to_refresh.dart";

// Examples can assume:
// enum Commands { heroAndScholar, hurricaneCame }
// dynamic _heroAndScholar;

const Duration _kMenuDuration = const Duration(milliseconds: 300);
const double _kBaselineOffsetFromBottom = 20.0;
const double _kMenuCloseIntervalEnd = 2.0 / 3.0;
const double _kMenuHorizontalPadding = 16.0;
const double _kMenuItemHeight = 48.0;
const double _kMenuDividerHeight = 16.0;
const double _kMenuMaxWidth = 5.0 * _kMenuWidthStep;
const double _kMenuMinWidth = 2.0 * _kMenuWidthStep;
const double _kMenuVerticalPadding = 8.0;
const double _kMenuWidthStep = 56.0;
const double _kMenuScreenPadding = 8.0;

/// A base class for entries in a material design popup menu.
///
/// The popup menu widget uses this interface to interact with the menu items.
/// To show a popup menu, use the [showMenu] function. To create a button that
/// shows a popup menu, consider using [PopupMenuButton].
///
/// The type `T` is the type of the value(s) the entry represents. All the
/// entries in a given menu must represent values with consistent types.
///
/// A [PopupMenuEntry] may represent multiple values, for example a row with
/// several icons, or a single entry, for example a menu item with an icon (see
/// [PopupMenuItems]), or no value at all (for example, [PopupMenuDivider]).
///
/// See also:
///
///  * [PopupMenuItems], a popup menu entry for a single value.
///  * [PopupMenuDivider], a popup menu entry that is just a horizontal line.
///  * [CheckedPopupMenuItems], a popup menu item with a checkmark.
///  * [showMenu], a method to dynamically show a popup menu at a given location.
///  * [PopupMenuButton], an [IconButton] that automatically shows a menu when
///    it is tapped.
abstract class PopupMenuEntry<T> extends StatefulWidget {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const PopupMenuEntry({ Key key }) : super(key: key);

  /// The amount of vertical space occupied by this entry.
  ///
  /// This value is used at the time the [showMenu] method is called, if the
  /// `initialValue` argument is provided, to determine the position of this
  /// entry when aligning the selected entry over the given `position`. It is
  /// otherwise ignored.
  double get height;

  /// Whether this entry represents a particular value.
  ///
  /// This method is used by [showMenu], when it is called, to align the entry
  /// representing the `initialValue`, if any, to the given `position`, and then
  /// later is called on each entry to determine if it should be highlighted (if
  /// the method returns true, the entry will have its background color set to
  /// the ambient [ThemeData.highlightColor]). If `initialValue` is null, then
  /// this method is not called.
  ///
  /// If the [PopupMenuEntry] represents a single value, this should return true
  /// if the argument matches that value. If it represents multiple values, it
  /// should return true if the argument matches any of them.
  bool represents(T value);
}

/// A horizontal divider in a material design popup menu.
///
/// This widget adapts the [Divider] for use in popup menus.
///
/// See also:
///
///  * [PopupMenuItems], for the kinds of items that this widget divides.
///  * [showMenu], a method to dynamically show a popup menu at a given location.
///  * [PopupMenuButton], an [IconButton] that automatically shows a menu when
///    it is tapped.
class PopupMenuDivider extends PopupMenuEntry<Null> {
  /// Creates a horizontal divider for a popup menu.
  ///
  /// By default, the divider has a height of 16 logical pixels.
  const PopupMenuDivider({ Key key, this.height = _kMenuDividerHeight }) : super(key: key);

  /// The height of the divider entry.
  ///
  /// Defaults to 16 pixels.
  @override
  final double height;

  @override
  bool represents(dynamic value) => false;

  @override
  _PopupMenuDividerState createState() => new _PopupMenuDividerState();
}

class _PopupMenuDividerState extends State<PopupMenuDivider> {
  @override
  Widget build(BuildContext context) => new Divider(height: widget.height);
}

/// An item in a material design popup menu.
///
/// To show a popup menu, use the [showMenu] function. To create a button that
/// shows a popup menu, consider using [PopupMenuButton].
///
/// To show a checkmark next to a popup menu item, consider using
/// [CheckedPopupMenuItems].
///
/// Typically the [child] of a [PopupMenuItems] is a [Text] widget. More
/// elaborate menus with icons can use a [ListTile]. By default, a
/// [PopupMenuItems] is 48 pixels high. If you use a widget with a different
/// height, it must be specified in the [height] property.
///
/// ## Sample code
///
/// Here, a [Text] widget is used with a popup menu item. The `WhyFarther` type
/// is an enum, not shown here.
///
/// ```dart
/// const PopupMenuItems<WhyFarther>(
///   value: WhyFarther.harder,
///   child: const Text('Working a lot harder'),
/// )
/// ```
///
/// See the example at [PopupMenuButton] for how this example could be used in a
/// complete menu, and see the example at [CheckedPopupMenuItems] for one way to
/// keep the text of [PopupMenuItems]s that use [Text] widgets in their [child]
/// slot aligned with the text of [CheckedPopupMenuItems]s or of [PopupMenuItems]
/// that use a [ListTile] in their [child] slot.
///
/// See also:
///
///  * [PopupMenuDivider], which can be used to divide items from each other.
///  * [CheckedPopupMenuItems], a variant of [PopupMenuItems] with a checkmark.
///  * [showMenu], a method to dynamically show a popup menu at a given location.
///  * [PopupMenuButton], an [IconButton] that automatically shows a menu when
///    it is tapped.
class PopupMenuItems<T> extends PopupMenuEntry<T> {
  /// Creates an item for a popup menu.
  ///
  /// By default, the item is [enabled].
  ///
  /// The `height` and `enabled` arguments must not be null.
  const PopupMenuItems({
    Key key,
    this.value,
    this.enabled = true,
    this.height = _kMenuItemHeight,
    @required this.child,
  }) : assert(enabled != null),
        assert(height != null),
        super(key: key);

  /// The value that will be returned by [showMenu] if this entry is selected.
  final T value;

  /// Whether the user is permitted to select this entry.
  ///
  /// Defaults to true. If this is false, then the item will not react to
  /// touches.
  final bool enabled;

  /// The height of the entry.
  ///
  /// Defaults to 48 pixels.
  @override
  final double height;

  /// The widget below this widget in the tree.
  ///
  /// Typically a single-line [ListTile] (for menus with icons) or a [Text]. An
  /// appropriate [DefaultTextStyle] is put in scope for the child. In either
  /// case, the text should be short enough that it won't wrap.
  final Widget child;

  @override
  bool represents(T value) => value == this.value;

  @override
  PopupMenuItemsState<T, PopupMenuItems<T>> createState() => new PopupMenuItemsState<T, PopupMenuItems<T>>();
}

/// The [State] for [PopupMenuItems] subclasses.
///
/// By default this implements the basic styling and layout of Material Design
/// popup menu items.
///
/// The [buildChild] method can be overridden to adjust exactly what gets placed
/// in the menu. By default it returns [PopupMenuItems.child].
///
/// The [handleTap] method can be overridden to adjust exactly what happens when
/// the item is tapped. By default, it uses [Navigator.pop] to return the
/// [PopupMenuItems.value] from the menu route.
///
/// This class takes two type arguments. The second, `W`, is the exact type of
/// the [Widget] that is using this [State]. It must be a subclass of
/// [PopupMenuItems]. The first, `T`, must match the type argument of that widget
/// class, and is the type of values returned from this menu.
class PopupMenuItemsState<T, W extends PopupMenuItems<T>> extends State<W> {
  /// The menu item contents.
  ///
  /// Used by the [build] method.
  ///
  /// By default, this returns [PopupMenuItems.child]. Override this to put
  /// something else in the menu entry.
  @protected
  Widget buildChild() => widget.child;

  /// The handler for when the user selects the menu item.
  ///
  /// Used by the [InkWell] inserted by the [build] method.
  ///
  /// By default, uses [Navigator.pop] to return the [PopupMenuItems.value] from
  /// the menu route.
  @protected
  void handleTap() {
    Navigator.pop<T>(context, widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.subhead;
    if (!widget.enabled)
      style = style.copyWith(color: theme.disabledColor);

    Widget item = new AnimatedDefaultTextStyle(
        style: style,
        duration: kThemeChangeDuration,
        child: new Baseline(
          baseline: widget.height - _kBaselineOffsetFromBottom,
          baselineType: style.textBaseline,
          child: buildChild(),
        )
    );
    if (!widget.enabled) {
      final bool isDark = theme.brightness == Brightness.dark;
      item = IconTheme.merge(
        data: new IconThemeData(opacity: isDark ? 0.5 : 0.38),
        child: item,
      );
    }

    return new InkWell(
      onTap: widget.enabled ? handleTap : null,
      child: new Container(
        height: widget.height,
        padding: const EdgeInsets.symmetric(horizontal: _kMenuHorizontalPadding),
        child: item,
      ),
    );
  }
}

/// An item with a checkmark in a material design popup menu.
///
/// To show a popup menu, use the [showMenu] function. To create a button that
/// shows a popup menu, consider using [PopupMenuButton].
///
/// A [CheckedPopupMenuItems] is 48 pixels high, which matches the default height
/// of a [PopupMenuItems]. The horizontal layout uses a [ListTile]; the checkmark
/// is an [Icons.done] icon, shown in the [ListTile.leading] position.
///
/// ## Sample code
///
/// Suppose a `Commands` enum exists that lists the possible commands from a
/// particular popup menu, including `Commands.heroAndScholar` and
/// `Commands.hurricaneCame`, and further suppose that there is a
/// `_heroAndScholar` member field which is a boolean. The example below shows a
/// menu with one menu item with a checkmark that can toggle the boolean, and
/// one menu item without a checkmark for selecting the second option. (It also
/// shows a divider placed between the two menu items.)
///
/// ```dart
/// new PopupMenuButton<Commands>(
///   onSelected: (Commands result) {
///     switch (result) {
///       case Commands.heroAndScholar:
///         setState(() { _heroAndScholar = !_heroAndScholar; });
///         break;
///       case Commands.hurricaneCame:
///         // ...handle hurricane option
///         break;
///       // ...other items handled here
///     }
///   },
///   itemBuilder: (BuildContext context) => <PopupMenuEntry<Commands>>[
///     new CheckedPopupMenuItems<Commands>(
///       checked: _heroAndScholar,
///       value: Commands.heroAndScholar,
///       child: const Text('Hero and scholar'),
///     ),
///     const PopupMenuDivider(),
///     const PopupMenuItems<Commands>(
///       value: Commands.hurricaneCame,
///       child: const ListTile(leading: const Icon(null), title: const Text('Bring hurricane')),
///     ),
///     // ...other items listed here
///   ],
/// )
/// ```
///
/// In particular, observe how the second menu item uses a [ListTile] with a
/// blank [Icon] in the [ListTile.leading] position to get the same alignment as
/// the item with the checkmark.
///
/// See also:
///
///  * [PopupMenuItems], a popup menu entry for picking a command (as opposed to
///    toggling a value).
///  * [PopupMenuDivider], a popup menu entry that is just a horizontal line.
///  * [showMenu], a method to dynamically show a popup menu at a given location.
///  * [PopupMenuButton], an [IconButton] that automatically shows a menu when
///    it is tapped.
class CheckedPopupMenuItems<T> extends PopupMenuItems<T> {
  /// Creates a popup menu item with a checkmark.
  ///
  /// By default, the menu item is [enabled] but unchecked. To mark the item as
  /// checked, set [checked] to true.
  ///
  /// The `checked` and `enabled` arguments must not be null.
  const CheckedPopupMenuItems({
    Key key,
    T value,
    this.checked = false,
    bool enabled = true,
    Widget child,
  }) : assert(checked != null),
        super(
        key: key,
        value: value,
        enabled: enabled,
        child: child,
      );

  /// Whether to display a checkmark next to the menu item.
  ///
  /// Defaults to false.
  ///
  /// When true, an [Icons.done] checkmark is displayed.
  ///
  /// When this popup menu item is selected, the checkmark will fade in or out
  /// as appropriate to represent the implied new state.
  final bool checked;

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Text]. An appropriate [DefaultTextStyle] is put in scope for
  /// the child. The text should be short enough that it won't wrap.
  ///
  /// This widget is placed in the [ListTile.title] slot of a [ListTile] whose
  /// [ListTile.leading] slot is an [Icons.done] icon.
  @override
  Widget get child => super.child;

  @override
  _CheckedPopupMenuItemsState<T> createState() => new _CheckedPopupMenuItemsState<T>();
}

class _CheckedPopupMenuItemsState<T> extends PopupMenuItemsState<T, CheckedPopupMenuItems<T>> with SingleTickerProviderStateMixin {
  static const Duration _fadeDuration = const Duration(milliseconds: 150);
  AnimationController _controller;
  Animation<double> get _opacity => _controller.view;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(duration: _fadeDuration, vsync: this)
      ..value = widget.checked ? 1.0 : 0.0
      ..addListener(() => setState(() { /* animation changed */ }));
  }

  @override
  void handleTap() {
    // This fades the checkmark in or out when tapped.
    if (widget.checked)
      _controller.reverse();
    else
      _controller.forward();
    super.handleTap();
  }

  @override
  Widget buildChild() {
    return new ListTile(
      enabled: widget.enabled,
      leading: new FadeTransition(
          opacity: _opacity,
          child: new Icon(_controller.isDismissed ? null : Icons.done)
      ),
      title: widget.child,
    );
  }
}

class _PopupMenu<T> extends StatelessWidget {
  const _PopupMenu({
    Key key,
    this.route,
    this.semanticLabel,
  }) : super(key: key);

  final _PopupMenuRoute<T> route;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final double unit = 1.0 / (route.items.length + 1.5); // 1.0 for the width and 0.5 for the last item's fade.
    final List<Widget> children = <Widget>[];

    for (int i = 0; i < route.items.length; i += 1) {
      final double start = (i + 1) * unit;
      final double end = (start + 1.5 * unit).clamp(0.0, 1.0);
      final CurvedAnimation opacity = new CurvedAnimation(
          parent: route.animation,
          curve: new Interval(start, end)
      );
      Widget item = route.items[i];
      if (route.initialValue != null && route.items[i].represents(route.initialValue)) {
        item = new Container(
          color: Theme.of(context).highlightColor,
          child: item,
        );
      }
      children.add(new FadeTransition(
        opacity: opacity,
        child: item,
      ));
    }

    final CurveTween opacity = new CurveTween(curve: const Interval(0.0, 1.0 / 3.0));
    final CurveTween width = new CurveTween(curve: new Interval(0.0, unit));
    final CurveTween height = new CurveTween(curve: new Interval(0.0, unit * route.items.length));

    final Widget child = new ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: _kMenuMinWidth,
          maxWidth: _kMenuMaxWidth,
        ),
        child: new IntrinsicWidth(
            stepWidth: _kMenuWidthStep,
            child: new SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  vertical: _kMenuVerticalPadding
              ),
              child: new ListBody(children: children),
            )
        )
    );

    return new AnimatedBuilder(
      animation: route.animation,
      builder: (BuildContext context, Widget child) {
        return new Opacity(
          opacity: opacity.evaluate(route.animation),
          child: new Material(
            type: MaterialType.card,
            elevation: route.elevation,
            child: new Align(
              alignment: AlignmentDirectional.topEnd,
              widthFactor: width.evaluate(route.animation),
              heightFactor: height.evaluate(route.animation),
              child: new Semantics(
                scopesRoute: true,
                namesRoute: true,
                explicitChildNodes: true,
                label: semanticLabel,
                child: child,
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}

// Positioning of the menu on the screen.
class _PopupMenuRouteLayout extends SingleChildLayoutDelegate {
  _PopupMenuRouteLayout(this.position, this.selectedItemOffset, this.textDirection);

  // Rectangle of underlying button, relative to the overlay's dimensions.
  final RelativeRect position;

  // The distance from the top of the menu to the middle of selected item.
  //
  // This will be null if there's no item to position in this way.
  final double selectedItemOffset;

  // Whether to prefer going to the left or to the right.
  final TextDirection textDirection;

  // We put the child wherever position specifies, so long as it will fit within
  // the specified parent size padded (inset) by 8. If necessary, we adjust the
  // child's position so that it fits.

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // The menu can be at most the size of the overlay minus 8.0 pixels in each
    // direction.
    return new BoxConstraints.loose(constraints.biggest - const Offset(_kMenuScreenPadding * 2.0, _kMenuScreenPadding * 2.0));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // size: The size of the overlay.
    // childSize: The size of the menu, when fully open, as determined by
    // getConstraintsForChild.

    // Find the ideal vertical position.
    double y;
    if (selectedItemOffset == null) {
      y = position.top;
    } else {
      y = position.top + (size.height - position.top - position.bottom) / 2.0 - selectedItemOffset;
    }

    // Find the ideal horizontal position.
    double x;
    if (position.left > position.right) {
      // Menu button is closer to the right edge, so grow to the left, aligned to the right edge.
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      // Menu button is closer to the left edge, so grow to the right, aligned to the left edge.
      x = position.left;
    } else {
      // Menu button is equidistant from both edges, so grow in reading direction.
      assert(textDirection != null);
      switch (textDirection) {
        case TextDirection.rtl:
          x = size.width - position.right - childSize.width;
          break;
        case TextDirection.ltr:
          x = position.left;
          break;
      }
    }

    // Avoid going outside an area defined as the rectangle 8.0 pixels from the
    // edge of the screen in every direction.
    if (x < _kMenuScreenPadding)
      x = _kMenuScreenPadding;
    else if (x + childSize.width > size.width - _kMenuScreenPadding)
      x = size.width - childSize.width - _kMenuScreenPadding;
    if (y < _kMenuScreenPadding)
      y = _kMenuScreenPadding;
    else if (y + childSize.height > size.height - _kMenuScreenPadding)
      y = size.height - childSize.height - _kMenuScreenPadding;
    return new Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupMenuRouteLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}

class _PopupMenuRoute<T> extends PopupRoute<T> {
  _PopupMenuRoute({
    this.position,
    this.items,
    this.initialValue,
    this.elevation,
    this.theme,
    this.barrierLabel,
    this.semanticLabel,
  });

  final RelativeRect position;
  final List<PopupMenuEntry<T>> items;
  final dynamic initialValue;
  final double elevation;
  final ThemeData theme;
  final String semanticLabel;

  @override
  Animation<double> createAnimation() {
    return new CurvedAnimation(
        parent: super.createAnimation(),
        curve: Curves.linear,
        reverseCurve: const Interval(0.0, _kMenuCloseIntervalEnd)
    );
  }

  @override
  Duration get transitionDuration => _kMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => null;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    double selectedItemOffset;
    if (initialValue != null) {
      double y = _kMenuVerticalPadding;
      for (PopupMenuEntry<T> entry in items) {
        if (entry.represents(initialValue)) {
          selectedItemOffset = y + entry.height / 2.0;
          break;
        }
        y += entry.height;
      }
    }

    Widget menu = new _PopupMenu<T>(route: this, semanticLabel: semanticLabel);
    if (theme != null)
      menu = new Theme(data: theme, child: menu);

    return new MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: new Builder(
        builder: (BuildContext context) {
          return new CustomSingleChildLayout(
            delegate: new _PopupMenuRouteLayout(
              position,
              selectedItemOffset,
              Directionality.of(context),
            ),
            child: menu,
          );
        },
      ),
    );
  }
}

/// Show a popup menu that contains the `items` at `position`.
///
/// If `initialValue` is specified then the first item with a matching value
/// will be highlighted and the value of `position` gives the rectangle whose
/// vertical center will be aligned with the vertical center of the highlighted
/// item (when possible).
///
/// If `initialValue` is not specified then the top of the menu will be aligned
/// with the top of the `position` rectangle.
///
/// In both cases, the menu position will be adjusted if necessary to fit on the
/// screen.
///
/// Horizontally, the menu is positioned so that it grows in the direction that
/// has the most room. For example, if the `position` describes a rectangle on
/// the left edge of the screen, then the left edge of the menu is aligned with
/// the left edge of the `position`, and the menu grows to the right. If both
/// edges of the `position` are equidistant from the opposite edge of the
/// screen, then the ambient [Directionality] is used as a tie-breaker,
/// preferring to grow in the reading direction.
///
/// The positioning of the `initialValue` at the `position` is implemented by
/// iterating over the `items` to find the first whose
/// [PopupMenuEntry.represents] method returns true for `initialValue`, and then
/// summing the values of [PopupMenuEntry.height] for all the preceding widgets
/// in the list.
///
/// The `elevation` argument specifies the z-coordinate at which to place the
/// menu. The elevation defaults to 8, the appropriate elevation for popup
/// menus.
///
/// The `context` argument is used to look up the [Navigator] and [Theme] for
/// the menu. It is only used when the method is called. Its corresponding
/// widget can be safely removed from the tree before the popup menu is closed.
///
/// The `semanticLabel` argument is used by accessibility frameworks to
/// announce screen transitions when the menu is opened and closed. If this
/// label is not provided, it will default to
/// [MaterialLocalizations.popupMenuLabel].
///
/// See also:
///
///  * [PopupMenuItems], a popup menu entry for a single value.
///  * [PopupMenuDivider], a popup menu entry that is just a horizontal line.
///  * [CheckedPopupMenuItems], a popup menu item with a checkmark.
///  * [PopupMenuButton], which provides an [IconButton] that shows a menu by
///    calling this method automatically.
///  * [SemanticsConfiguration.namesRoute], for a description of edge triggered
///    semantics.
Future<T> showMenu<T>({
  @required BuildContext context,
  RelativeRect position,
  @required List<PopupMenuEntry<T>> items,
  T initialValue,
  double elevation = 8.0,
  String semanticLabel,
}) {
  assert(context != null);
  assert(items != null && items.isNotEmpty);
  String label = semanticLabel;
  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
      label = semanticLabel;
      break;
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
      label = semanticLabel ?? MaterialLocalizations.of(context)?.popupMenuLabel;
  }

  return Navigator.push(context, new _PopupMenuRoute<T>(
    position: position,
    items: items,
    initialValue: initialValue,
    elevation: elevation,
    semanticLabel: label,
    theme: Theme.of(context, shadowThemeOnly: true),
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
  ));
}

/// Signature for the callback invoked when a menu item is selected. The
/// argument is the value of the [PopupMenuItems] that caused its menu to be
/// dismissed.
///
/// Used by [PopupMenuButton.onSelected].
typedef void PopupMenuItemsSelected<T>(T value);

/// Signature for the callback invoked when a [PopupMenuButton] is dismissed
/// without selecting an item.
///
/// Used by [PopupMenuButton.onCanceled].
typedef void PopupMenuCanceled();

/// Signature used by [PopupMenuButton] to lazily construct the items shown when
/// the button is pressed.
///
/// Used by [PopupMenuButton.itemBuilder].
typedef List<PopupMenuEntry<T>> PopupMenuItemsBuilder<T>(BuildContext context);

/// Displays a menu when pressed and calls [onSelected] when the menu is dismissed
/// because an item was selected. The value passed to [onSelected] is the value of
/// the selected menu item.
///
/// One of [child] or [icon] may be provided, but not both. If [icon] is provided,
/// then [PopupMenuButton] behaves like an [IconButton].
///
/// If both are null, then a standard overflow icon is created (depending on the
/// platform).
///
/// ## Sample code
///
/// This example shows a menu with four items, selecting between an enum's
/// values and setting a `_selection` field based on the selection.
///
/// ```dart
/// // This is the type used by the popup menu below.
/// enum WhyFarther { harder, smarter, selfStarter, tradingCharter }
///
/// // This menu button widget updates a _selection field (of type WhyFarther,
/// // not shown here).
/// new PopupMenuButton<WhyFarther>(
///   onSelected: (WhyFarther result) { setState(() { _selection = result; }); },
///   itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
///     const PopupMenuItems<WhyFarther>(
///       value: WhyFarther.harder,
///       child: const Text('Working a lot harder'),
///     ),
///     const PopupMenuItems<WhyFarther>(
///       value: WhyFarther.smarter,
///       child: const Text('Being a lot smarter'),
///     ),
///     const PopupMenuItems<WhyFarther>(
///       value: WhyFarther.selfStarter,
///       child: const Text('Being a self-starter'),
///     ),
///     const PopupMenuItems<WhyFarther>(
///       value: WhyFarther.tradingCharter,
///       child: const Text('Placed in charge of trading charter'),
///     ),
///   ],
/// )
/// ```
///
/// See also:
///
///  * [PopupMenuItems], a popup menu entry for a single value.
///  * [PopupMenuDivider], a popup menu entry that is just a horizontal line.
///  * [CheckedPopupMenuItems], a popup menu item with a checkmark.
///  * [showMenu], a method to dynamically show a popup menu at a given location.
class PopupMenuButtons<T> extends StatefulWidget {
  /// Creates a button that shows a popup menu.
  ///
  /// The [itemBuilder] argument must not be null.
  const PopupMenuButtons({
    Key key,
    @required this.itemBuilder,
    this.initialValue,
    this.onSelected,
    this.onCanceled,
    this.tooltip,
    this.elevation = 8.0,
    this.padding = const EdgeInsets.all(8.0),
    this.child,
    this.icon,
    this.marginTopHeigt,
    this.marginLeftWidth
  }) : assert(itemBuilder != null),
        assert(!(child != null && icon != null)), // fails if passed both parameters
        super(key: key);

  /// Called when the button is pressed to create the items to show in the menu.
  final PopupMenuItemsBuilder<T> itemBuilder;

  /// The value of the menu item, if any, that should be highlighted when the menu opens.
  final T initialValue;

  /// Called when the user selects a value from the popup menu created by this button.
  ///
  /// If the popup menu is dismissed without selecting a value, [onCanceled] is
  /// called instead.
  final PopupMenuItemsSelected<T> onSelected;

  /// Called when the user dismisses the popup menu without selecting an item.
  ///
  /// If the user selects a value, [onSelected] is called instead.
  final PopupMenuCanceled onCanceled;

  /// Text that describes the action that will occur when the button is pressed.
  ///
  /// This text is displayed when the user long-presses on the button and is
  /// used for accessibility.
  final String tooltip;

  /// The z-coordinate at which to place the menu when open. This controls the
  /// size of the shadow below the menu.
  ///
  /// Defaults to 8, the appropriate elevation for popup menus.
  final double elevation;

  /// Matches IconButton's 8 dps padding by default. In some cases, notably where
  /// this button appears as the trailing element of a list item, it's useful to be able
  /// to set the padding to zero.
  final EdgeInsetsGeometry padding;

  /// If provided, the widget used for this button.
  final Widget child;

  /// If provided, the icon used for this button.
  final Icon icon;
  final double marginTopHeigt;
  final double marginLeftWidth;

  @override
  _PopupMenuButtonState<T> createState() => new _PopupMenuButtonState<T>(marginTopHeigt,marginLeftWidth);
}

class _PopupMenuButtonState<T> extends State<PopupMenuButtons<T>> {
  final double marginTopHeigt;
  final double marginLeftWidth;
  _PopupMenuButtonState(this.marginTopHeigt,this.marginLeftWidth);
  void showButtonMenu() {
    final RenderBox button = context.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    final RelativeRect position = new RelativeRect.fromRect(
      new Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
    //  Offset.zero & overlay.size,
      Offset.lerp(Offset(-marginLeftWidth,-marginTopHeigt),Offset(-marginLeftWidth,-marginTopHeigt),0.0)&overlay.size,
    );
    showMenu<T>(
      context: context,
      elevation: widget.elevation,
      items: widget.itemBuilder(context),
      initialValue: widget.initialValue,
      position: position,
    )
        .then<void>((T newValue) {
      if (!mounted)
        return null;
      if (newValue == null) {
        if (widget.onCanceled != null)
          widget.onCanceled();
        return null;
      }
      if (widget.onSelected != null)
        widget.onSelected(newValue);
    });
  }

  Icon _getIcon(TargetPlatform platform) {
    assert(platform != null);
    switch (platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return const Icon(Icons.more_vert);
      case TargetPlatform.iOS:
        return const Icon(Icons.more_horiz);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child != null
        ? new InkWell(
      onTap: showButtonMenu,
      child: widget.child,
    )
        : new IconButton(
      icon: widget.icon ?? _getIcon(Theme.of(context).platform),
      padding: widget.padding,
      tooltip: widget.tooltip ?? MaterialLocalizations.of(context).showMenuTooltip,
      onPressed: showButtonMenu,
    );
  }
}
