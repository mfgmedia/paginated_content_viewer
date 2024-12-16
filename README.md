# Paginated Content Viewer

Paginated Content Viewer is a Flutter widget that enables you to display content across multiple pages with a customizable page indicator. It's designed to be intuitive, flexible, and visually appealing.

## Features

- Display content in a paginated format.
- Customizable page indicator (colors, radius, spacing, etc.).
- Handles page changes programmatically via a `PageController`.

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  paginated_content_viewer: ^1.0.0
```

Run the following command to fetch the package:

```bash
flutter pub get
```

## Usage

Here's a simple example to get started:

```dart
import 'package:flutter/material.dart';
import 'package:paginated_content_viewer/paginated_content_viewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatelessWidget {
  ExamplePage({super.key});

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paginated Content Viewer Example')),
      body: PaginatedContentViewer(
        pageController: pageController,
        children: const [
          Center(child: Text('Page 1')),
          Center(child: Text('Page 2')),
          Center(child: Text('Page 3')),
        ],
        dotFillColor: Colors.grey.withOpacity(0.3),
        dotOutlineColor: Colors.black,
        indicatorColor: Colors.blue,
        dotRadius: 8.0,
        spacing: 15.0,
        onPageChanged: (index) {
          print('Current page: $index');
        },
      ),
    );
  }
}
```

## Customization

You can customize the appearance and behavior of the `PaginatedContentViewer` widget with the following properties:

| Property              | Type              | Default            | Description                                         |
|-----------------------|-------------------|--------------------|-----------------------------------------------------|
| `pageController`      | `PageController` | **Required**       | Controls the current page of the `PageView`.       |
| `children`            | `List<Widget>`   | **Required**       | The pages to display.                              |
| `dotFillColor`        | `Color`          | `Color(0x20000000)`| The fill color of the dots.                        |
| `dotOutlineColor`     | `Color`          | `Color(0x6F000000)`| The outline color of the dots.                     |
| `indicatorColor`      | `Color`          | `Colors.redAccent` | The color of the active page indicator.            |
| `dotRadius`           | `double`         | `10.0`             | The radius of the dots.                            |
| `dotOutlineThickness` | `double`         | `3.0`              | The thickness of the dot outlines.                 |
| `spacing`             | `double`         | `20.0`             | The spacing between dots.                          |
| `onPageChanged`       | `ValueChanged<int>` | `null`           | A callback for when the page changes.              |

## Example

See the `example/` folder for a complete Flutter app demonstrating the usage of `Paginated Content Viewer`.

## Testing

Run the included tests to ensure everything works as expected:

```bash
flutter test
```

## Credits

Inspired by modern UI designs for paginated content viewers.

## License

This package is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
