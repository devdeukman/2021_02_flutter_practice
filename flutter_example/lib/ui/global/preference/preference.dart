import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/ui/global/theme/app_themes.dart';
import 'package:flutter_example/ui/global/theme/theme_bloc.dart';

class PreferencePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: AppTheme.values.length,
        itemBuilder: (context, index) {
          final itemAppTheme = AppTheme.values[index];
          return Card(
            color: appThemeData[itemAppTheme]!.primaryColor,
            child: ListTile(
              title: Text(
                itemAppTheme.toString(),
                style: appThemeData[itemAppTheme]!.textTheme.bodyText2,
              ),
              onTap: () {
                BlocProvider.of<ThemeBloc>(context)
                    .add(ThemeChanged(theme: itemAppTheme));
              },
            ),
          );
        },
      ),
    );
  }
}
