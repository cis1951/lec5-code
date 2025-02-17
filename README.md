# Minicourse Browser
This repo contains the starter code for **Lecture 5: App Structure**.

Here, we're building an app to let users browse CIS 19xx minicourses. The app will start by showing a list of courses, and when the user taps on a course, it will navigate to a new screen displaying the course's description. We'll also add other useful features, like **favoriting courses** so they appear on the top and **animations for course icons**.

Here's a walkthrough of the steps we cover in lecture:

## Step 1: Add a `NavigationStack`

We'll start off by setting up the navigation between the root list view and each course detail view. To do that, we'll need to wrap the contents of `RootView` in a `NavigationStack`:
```swift
struct RootView: View {
    var body: some View {
        NavigationStack {
            List(Course.minicourses) { course in
                CourseRowView(course: course)
            }
        }
    }
}
``` 

Next, we'll update `CourseRowView` to use `NavigationLink` with `CourseDetailView` as a destination. This will make it so that when we tap on a course, the navigation stack will bring us to its description:
```swift
struct CourseRowView: View {
    let course: Course
    
    var body: some View {
        NavigationLink(destination: {
            CourseDetailView(course: course)
        }) {
            Label("**\(course.code)**: \(course.name)", systemImage: course.icon)
        }
    }
}
```

## Step 2: Add navigation titles

To make the user experience better, we'll add titles to each screen. We can do this by adding the `.navigationTitle` modifier to the list in `RootView`:
```swift
List(Course.minicourses) { course in
    CourseRowView(course: course)
}
.navigationTitle("Minicourses")
```

For the course detail, we'll use the course's code. This time, we'll also use the `.navigationBarTitleDisplayMode` modifier to make the top bar appear smaller when we navigate:
```swift
VStack(alignment: .leading) {
    // ...
}
.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
.padding()
.navigationTitle(course.code)
.navigationBarTitleDisplayMode(.inline)
```

## Step 3: Data-driven navigation

What we have so far is great, but it can get unwieldy putting the `CourseDetailView` in `CourseRowView` - ideally, we want `CourseRowView` to be as small and simple as possible. Fortunately, `NavigationStack` supports navigating based on *values*. Let's try it out.

Update the `NavigationLink` in `CourseRowView` to this:
```swift
NavigationLink(value: course) {
    Label("**\(course.code)**: \(course.name)", systemImage: course.icon)
}
``` 

Now `CourseRowView` is a lot cleaner, but how will our navigation stack know where to navigate to? To answer that, add a `.navigationDestination` modifier to `RootView`, like this:
```swift
List(Course.minicourses) { course in
    CourseRowView(course: course)
}
.navigationTitle("Minicourses")
.navigationDestination(for: Course.self) { course in
    CourseDetailView(course: course)
}
```

With this, `NavigationStack` will know to show `CourseDetailView` when we tap on the link.

## Step 4: Use `NavigationPath`

Navigating based on values doesn't just make our code cleaner - it also lets us control navigation programmatically rather than just relying on `NavigationLink`s. To demonstrate this, let's add a button that takes you to a random course.

In SwiftUI, navigation stacks can be driven by what's called a `NavigationPath` - think of it like a URL or a path that tells you where you are in an app's hierarchy. All it takes to set one up is to initialize it and store it in a `@State` property:
```swift
@State var navigationPath = NavigationPath()
```

Then, we can tell our `NavigationStack` in `RootView` to use the path:
```swift
NavigationStack(path: $navigationPath) {
    // ...
}
```

> **Some food for thought:** Why did we need to pass in a `Binding` with the `$` here?

Now, let's use the `.toolbar` modifier to add a button to the top right of the navigation bar. Note this must be applied *inside* the `NavigationStack` since this is what is managing our navigation. Therefore you can place this modifier at the end of the `List`'s modifiers.
```swift
.toolbar {
    ToolbarItem {
        Button("Random Course", systemImage: "dice") {
            // You'll do this in a bit...
        }
    }
}
```

And when the button is tapped, we'll append a random course to our `NavigationPath` using the `.append` method:
```swift
navigationPath.append(Course.minicourses.randomElement()!)
```

> **Understanding check:** Why is it okay to "force unwrap" this optional here with the `!`?

Build and run the app, then tap the dice button on the top right - you'll be taken to a random course, all without having used `NavigationLink`!

## Step 5: Favoriting Courses with a View Model

Now, let's implement the ability to favorite courses. To keep code clean, we'll implement the actual logic for this in a *view model* so we can separate it from the view itself. Let's make a new file in the "View Models" folder and call it `FavoritesViewModel`.

We'll make a class and fill in its logic:
```swift
@Observable class FavoritesViewModel: ObservableObject {
    private var favoritedCourseCodes = Set<String>()
    
    init(favoritedCourseCodes: Set<String> = []) {
        self.favoritedCourseCodes = favoritedCourseCodes
    }
    
    func isFavorited(course: Course) -> Bool {
        return favoritedCourseCodes.contains(course.id)
    }
    
    func favorite(course: Course) {
        favoritedCourseCodes.insert(course.id)
    }
    
    func unfavorite(course: Course) {
        favoritedCourseCodes.remove(course.id)
    }
    
    var favoritedCourses: [Course] {
        Course.minicourses.filter { isFavorited(course: $0) }
    }
    
    var unfavoritedCourses: [Course] {
        Course.minicourses.filter { !isFavorited(course: $0) }
    }
}
```

You may need to `import SwiftUI` or `import Observation` for this to work.

We'll then create an instance of it in the `Minicourse_BrowserApp` struct and pass it down to our views via a `.environment` modifier:
```swift
@main
struct Minicourse_BrowserApp: App {
    @State var favoritesViewModel = FavoritesViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(favoritesViewModel)
        }
    }
}
```

Finally, we'll use this to display separate sections for favorited and unfavorited courses in the list view. First, we'll need to add an `@Environment` property to `RootView`, like this:
```swift
@Environment(FavoritesViewModel.self) var favoritesViewModel
```

This will fetch the view model from the `.environment` modifier we added earlier. With this, we can divide the list into two sections, like this:
```swift
List {
    Section("Favorites") {
        ForEach(favoritesViewModel.favoritedCourses) { course in
            CourseRowView(course: course)
        }
    }
    
    Section("Others") {
        ForEach(favoritesViewModel.unfavoritedCourses) { course in
            CourseRowView(course: course)
        }
    }
}
```

When you build and run the app, you'll notice the app now has two sections!

If your preview is crashing, you will need to add `.environment` to your `#Preview` as well. You won't have access to `Minicourse_BrowserApp`'s view model, so just instantiate a new one:
```swift
#Preview {
    @Previewable @State var favoritesViewModel = FavoritesViewModel()
    RootView()
        .environment(favoritesViewModel)
}
```

> The `@Previewable` macro lets you declare ad-hoc `@State` and `@Binding` values in a `#Preview` block.

## Step 6: Add a "favorite" button
View models are fun and all, but our `FavoritesViewModel` isn't doing anything useful quite yet. To fix that, we'll add a "Favorite" button to the top bar on the course detail view. We can use the `.toolbar` modifier on `FavoritesViewModel` to accomplish this:
```swift
// ...
.navigationTitle(course.code)
.navigationBarTitleDisplayMode(.inline)
.toolbar {
    ToolbarItem {
        if favoritesViewModel.isFavorited(course: course) {
            Button("Favorited", systemImage: "star.fill") {
                favoritesViewModel.unfavorite(course: course)
            }
        } else {
            Button("Add to Favorites", systemImage: "star") {
                favoritesViewModel.favorite(course: course)
            }
        }
    }
}
```

Of course, we'll need to have `CourseDetailView` read in `coursesViewModel` before we can actually use it. To do so, we'll add the same `@Environment` property to `CourseDetailView`:
```swift
@Environment(FavoritesViewModel.self) var favoritesViewModel
```

Don't forget to update the `#Preview` block like we did in step 5:
```swift
#Preview {
    @Previewable @State var favoritesViewModel = FavoritesViewModel()
    
    NavigationStack {
        CourseDetailView(course: Course.minicourses[0])
            .environment(favoritesViewModel)
    }
}
```

Now when we run the app, we can favorite and unfavorite courses!
