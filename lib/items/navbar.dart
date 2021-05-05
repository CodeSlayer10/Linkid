import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigation extends StatefulWidget {
  final EdgeInsets padding;
  final List<Widget> items;
  final Color backgroundColor;
  final BorderRadius radius;
  final double width;
  final double height;

  CustomBottomNavigation({
    Key key,
    this.items,
    this.padding,
    this.backgroundColor,
    this.radius,
    this.width,
    this.height,
  }) : super(key: key);
  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {

    return

        Container(
          height: MediaQuery.of(context).size.height / 6,
          color: Color(0xff323232),
          child: Stack(
            children: [
              Container(
                margin: widget.padding,
                height: widget.height,
                width: widget.width,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: widget.radius,
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.items.map((icon) {
                    return icon;
                  }
                  ).toList(),
                ),
                ),

            ],
          ),
        );
  }

}

class NavItem extends StatefulWidget {
  final String icon;
  final String icon2;
  bool selected;
  Function onTap;
  NavItem({
    Key key,
    this.onTap,
    this.icon,
    this.icon2,
    this.selected,
  }) : super(key: key);

  @override
  _NavItemState createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(child: SvgPicture.asset(widget.selected ? widget.icon : widget.icon2), onTap: widget.onTap),
    );
  }
}

