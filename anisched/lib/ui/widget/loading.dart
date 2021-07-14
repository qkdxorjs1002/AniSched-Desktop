import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {

    final double value;

    const LoadingIndicator({ this.value = 0.0 });
    
    @override
    Widget build(BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
                strokeWidth: 1,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black12),
                backgroundColor: Colors.white70,
                value: value,
            ),
        );
    }

}