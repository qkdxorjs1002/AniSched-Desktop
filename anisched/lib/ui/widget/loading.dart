import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {

    final double value;

    const LoadingIndicator({ this.value = null });
    
    @override
    Widget build(BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
                strokeWidth: 1.5,
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).backgroundColor.withOpacity(0.45)),
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
                value: value,
            ),
        );
    }

}