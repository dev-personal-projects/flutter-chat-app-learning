# 🎓 Flutter Core Concepts

Comprehensive guide to Flutter fundamentals and core concepts for mobile development.

## Table of Contents

1. [Widgets](#widgets)
2. [State Management](#state-management)
3. [BuildContext](#buildcontext)
4. [Lifecycle](#lifecycle)
5. [Navigation](#navigation)
6. [Async Programming](#async-programming)
7. [Layout & Styling](#layout--styling)
8. [Performance](#performance)

---

## Widgets

### What are Widgets?

Everything in Flutter is a widget. Widgets are the building blocks of Flutter apps.

**Key Points:**
- Widgets are immutable (can't be changed after creation)
- Widgets describe what the UI should look like
- Flutter rebuilds widgets when state changes
- Widgets can be composed together

### Types of Widgets

#### 1. StatelessWidget
- Widget that doesn't change over time
- No internal state
- Build method called once (unless parent rebuilds)

```dart
class MyText extends StatelessWidget {
  final String text;
  
  const MyText({super.key, required this.text});
  
  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
```

**When to use:**
- Display-only widgets
- Static content
- No user interaction needed
- No state to manage

#### 2. StatefulWidget
- Widget that can change over time
- Has mutable state
- Can rebuild itself when state changes

```dart
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;
  
  void _increment() {
    setState(() {
      _count++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Text('Count: $_count');
  }
}
```

**When to use:**
- Need to manage state
- User input (forms, text fields)
- Animations
- Timers or async operations

### Widget Tree

```
MaterialApp
  └── Scaffold
      ├── AppBar
      ├── Body
      │   └── Column
      │       ├── Text
      │       └── Button
      └── FloatingActionButton
```

**Key Concepts:**
- Parent widgets contain child widgets
- Widget tree determines layout and hierarchy
- Changes propagate down the tree
- State can be lifted up the tree

---

## State Management

### Local State (setState)

**Use for:**
- State that belongs to a single widget
- Form inputs
- UI toggles
- Loading indicators

```dart
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  String _input = '';
  
  void _updateInput(String value) {
    setState(() {
      _input = value;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: _updateInput,
      decoration: InputDecoration(hintText: _input),
    );
  }
}
```

### Global State (Provider)

**Use for:**
- State shared across multiple widgets
- User authentication
- Theme preferences
- Shopping cart
- App-wide settings

See [LEARNING_NOTES.md](./LEARNING_NOTES.md#state-management-in-flutter) for detailed comparison.

---

## BuildContext

### What is BuildContext?

`BuildContext` represents the location of a widget in the widget tree.

**Key Uses:**
- Access theme: `Theme.of(context)`
- Access media query: `MediaQuery.of(context)`
- Navigation: `Navigator.of(context)`
- Show dialogs: `showDialog(context: context)`
- Access providers: `Provider.of<T>(context)`

### Important Rules:

1. **Don't use context in async callbacks without checking `mounted`**
```dart
Future<void> loadData() async {
  final data = await fetchData();
  if (mounted) {  // Always check!
    setState(() {
      _data = data;
    });
  }
}
```

2. **Context is only valid during build**
```dart
@override
Widget build(BuildContext context) {
  // ✅ Context is valid here
  return Text('Hello');
}

void someMethod() {
  // ❌ Context might not be valid here
  Navigator.push(context, ...);  // Might fail!
}
```

---

## Lifecycle

### Widget Lifecycle

#### StatelessWidget
1. Constructor
2. `build()` method
3. Dispose (if resources need cleanup)

#### StatefulWidget
1. Constructor
2. `createState()` - creates state object
3. `initState()` - called once when widget is inserted
4. `build()` - called to build widget
5. `setState()` - triggers rebuild
6. `build()` - called again after setState
7. `dispose()` - called when widget is removed

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    // Initialize resources
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Do something
    });
  }
  
  @override
  void dispose() {
    // Clean up resources
    _timer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### App Lifecycle

Flutter apps have lifecycle states:
- `resumed` - App is visible and responding
- `inactive` - App is transitioning (e.g., phone call)
- `paused` - App is not visible
- `detached` - App is terminated

```dart
class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App is paused
    } else if (state == AppLifecycleState.resumed) {
      // App is resumed
    }
  }
}
```

---

## Navigation

### Basic Navigation

```dart
// Navigate to new screen
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SecondScreen()),
);

// Navigate back
Navigator.pop(context);

// Navigate and replace (can't go back)
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => HomeScreen()),
);

// Navigate and remove all previous routes
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => HomeScreen()),
  (route) => false,  // Remove all routes
);
```

### Named Routes

```dart
// Define routes
MaterialApp(
  routes: {
    '/home': (context) => HomeScreen(),
    '/profile': (context) => ProfileScreen(),
  },
)

// Navigate using route name
Navigator.pushNamed(context, '/profile');

// Navigate with arguments
Navigator.pushNamed(
  context,
  '/profile',
  arguments: {'userId': 123},
);

// Get arguments
final args = ModalRoute.of(context)!.settings.arguments as Map;
```

### Passing Data

```dart
// Forward
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailScreen(data: myData),
  ),
);

// Backward
Navigator.pop(context, resultData);
```

---

## Async Programming

### Futures

```dart
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Data loaded';
}

// Usage
fetchData().then((data) {
  print(data);
});

// Or with async/await
final data = await fetchData();
print(data);
```

### Streams

```dart
Stream<int> countStream() async* {
  for (int i = 0; i < 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

// Usage with StreamBuilder
StreamBuilder<int>(
  stream: countStream(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Text('Count: ${snapshot.data}');
    }
    return CircularProgressIndicator();
  },
)
```

### Error Handling

```dart
try {
  final data = await fetchData();
  // Use data
} on NetworkException catch (e) {
  // Handle specific error
  print('Network error: ${e.message}');
} catch (e) {
  // Handle any other error
  print('Error: $e');
} finally {
  // Always executed
  // Clean up resources
}
```

---

## Layout & Styling

### Common Layout Widgets

#### Column
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Item 1'),
    Text('Item 2'),
  ],
)
```

#### Row
```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text('Left'),
    Text('Right'),
  ],
)
```

#### Stack
```dart
Stack(
  children: [
    Container(color: Colors.blue),
    Positioned(
      top: 10,
      left: 10,
      child: Text('Overlay'),
    ),
  ],
)
```

#### Expanded & Flexible
```dart
Row(
  children: [
    Expanded(
      flex: 2,  // Takes 2/3 of space
      child: Container(color: Colors.red),
    ),
    Expanded(
      flex: 1,  // Takes 1/3 of space
      child: Container(color: Colors.blue),
    ),
  ],
)
```

### Responsive Design

```dart
// Get screen size
final size = MediaQuery.of(context).size;
final width = size.width;
final height = size.height;

// Responsive padding
final padding = width * 0.05;  // 5% of screen width

// Breakpoints
if (width > 600) {
  // Tablet layout
} else {
  // Phone layout
}
```

---

## Performance

### Optimization Tips

1. **Use const constructors**
```dart
const Text('Hello')  // ✅ Better
Text('Hello')       // ❌ Rebuilds unnecessarily
```

2. **Extract widgets**
```dart
// ❌ Bad - rebuilds entire list
ListView(
  children: items.map((item) => 
    Container(
      child: Column(
        children: [/* complex widget tree */],
      ),
    ),
  ).toList(),
)

// ✅ Good - only rebuilds changed items
ListView(
  children: items.map((item) => 
    ItemWidget(item: item),  // Extracted widget
  ).toList(),
)
```

3. **Use keys for lists**
```dart
ListView(
  children: items.map((item) => 
    ItemWidget(
      key: ValueKey(item.id),  // Helps Flutter identify widgets
      item: item,
    ),
  ).toList(),
)
```

4. **Avoid unnecessary rebuilds**
```dart
// ❌ Bad - rebuilds on every provider change
Consumer<AuthProvider>(
  builder: (context, provider, child) {
    return Column(
      children: [
        Text(provider.user?.name ?? ''),
        ExpensiveWidget(),  // Rebuilds unnecessarily
      ],
    );
  },
)

// ✅ Good - only expensive widget rebuilds when needed
Consumer<AuthProvider>(
  builder: (context, provider, child) {
    return Column(
      children: [
        Text(provider.user?.name ?? ''),
        child!,  // Doesn't rebuild
      ],
    );
  },
  child: ExpensiveWidget(),  // Passed as child
)
```

---

## Common Patterns

### Loading States
```dart
bool _isLoading = false;

Future<void> _loadData() async {
  setState(() => _isLoading = true);
  try {
    final data = await fetchData();
    // Use data
  } finally {
    setState(() => _isLoading = false);
  }
}
```

### Form Handling
```dart
final _formKey = GlobalKey<FormState>();
final _controller = TextEditingController();

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}

void _submit() {
  if (_formKey.currentState!.validate()) {
    // Form is valid
  }
}
```

### Error Handling
```dart
Future<void> _handleAction() async {
  try {
    await riskyOperation();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Success')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}
```

---

## Best Practices

1. **Always dispose resources**
   - Controllers, streams, timers, listeners

2. **Check mounted before using context**
   - In async callbacks after await

3. **Use const where possible**
   - Improves performance

4. **Extract widgets for reusability**
   - Keeps code DRY and maintainable

5. **Handle errors gracefully**
   - Show user-friendly messages

6. **Test on different screen sizes**
   - Use responsive design

7. **Follow naming conventions**
   - Private members: `_privateMember`
   - Constants: `kConstantName` or `CONSTANT_NAME`

---

**Note**: This is a living document. Update as you learn more!

