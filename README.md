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

## Step 4: Switch to `NavigationSplitView`

If we run our app on the iPad, we might notice it's a bit lacking - there's a bunch of screen real estate that we're simply not using. Many iPad apps take advantage of the extra space by showing a sidebar, which lets users quickly jump between content. Let's implement that for our app with a `NavigationSplitView`.

First, we'll need to add a `@State` property to keep track of the currently selected course. Go ahead and add this to `RootView`:
```swift
@State var selectedCourse: Course? = nil
```

Next, we'll tell the list to update the `selectedCourse` property when a course is selected:
```swift
List(Course.minicourses, selection: $selectedCourse) { course in
    // ...
}
```

Now, let's swap out `NavigationStack` for `NavigationSplitView`. Note that the split view takes an extra parameter, the `detail` parameter, which tells SwiftUI what to show to the right of the sidebar. Let's have `detail` show the current course, or a placeholder if no course is selected:
```swift
NavigationSplitView {
    List(Course.minicourses, selection: $selectedCourse) { course in
        CourseRowView(course: course)
    }
    .navigationTitle("Minicourses")
} detail: {
    if let selectedCourse {
        CourseDetailView(course: selectedCourse)
    } else {
        Text("Choose a minicourse on the sidebar.")
            .foregroundStyle(.secondary)
            .padding()
            .navigationBarTitleDisplayMode(.inline)
    }
}
```

Notice how we got rid of the `.navigationDestination` modifier - that's because we're now telling the split view what to display in the `detail` closure.

> [!NOTE]
> You might ask: What's that `detail:` doing there? That's actually a controversial feature called [multiple trailing closure syntax](https://github.com/apple/swift-evolution/blob/main/proposals/0279-multiple-trailing-closures.md). It was subject to some derision when it was initiaally proposed, but it's actually quite useful when dealing with SwiftUI.

If you build and run, you'll notice while the app behaves the same way as before on iPhone, it feels a lot more at home on iPad. That's the magic of `NavigationSplitView` - it automatically adapts to whatever device you're using.

## Step 5: Favoriting Courses with a View Model

Now, let's implement the ability to favorite courses. To keep code clean, we'll implement the actual logic for this in a *view model* so we can separate it from the view itself. Let's make a new file in the "View Models" folder and call it `CoursesViewModel`.

We'll make a class and fill in its logic:
```swift
class CoursesViewModel: ObservableObject {
    @Published private var favoritedCourseCodes = Set<String>()
    
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

You may need to `import SwiftUI` for this to work.

We'll then create an instance of it in the `Minicourse_BrowserApp` struct and pass it down to our views via a `.environmentObject` modifier:
```swift
@main
struct Minicourse_BrowserApp: App {
    @StateObject var coursesViewModel = CoursesViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(coursesViewModel)
        }
    }
}
```

Finally, we'll use this to display separate sections for favorited and unfavorited courses in the list view. First, we'll need to add an `@EnvironmentObject` property to `RootView`, like this:
```swift
@EnvironmentObject var coursesViewModel: CoursesViewModel
```

This will fetch the view model from the `.environmentObject` modifier we added earlier. With this, we can divide the list into two sections, like this:
```swift
List(selection: $selectedCourse) {
    Section("Favorites") {
        ForEach(coursesViewModel.favoritedCourses) { course in
            CourseRowView(course: course)
        }
    }
    
    Section("Others") {
        ForEach(coursesViewModel.unfavoritedCourses) { course in
            CourseRowView(course: course)
        }
    }
}
```

When you build and run the app, you'll notice the app now has two sections!

If your preview is crashing, you might need to add `.environmentObject` to your `#Preview` as well. You won't have access to `Minicourse_BrowserApp`'s view model, so just instantiate a new one:
```swift
#Preview {
    RootView()
        .environmentObject(CoursesViewModel())
}
```

## Step 6: Add a "favorite" button
View models are fun and all, but our `CoursesViewModel` isn't doing anything useful quite yet. To fix that, we'll add a "Favorite" button to the top bar on the course detail view. We can use the `.toolbar` modifier on `CourseDetailView` to accomplish this:
```swift
// ...
.navigationTitle(course.code)
.navigationBarTitleDisplayMode(.inline)
.toolbar {
    ToolbarItem {
        if coursesViewModel.isFavorited(course: course) {
            Button("Favorited", systemImage: "star.fill") {
                coursesViewModel.unfavorite(course: course)
            }
        } else {
            Button("Add to Favorites", systemImage: "star") {
                coursesViewModel.favorite(course: course)
            }
        }
    }
}
```

Of course, we'll need to have `CourseDetailView` read in `coursesViewModel` before we can actually use it. To do so, we'll add the same `@EnvironmentObject` property to `CourseDetailView`:
```swift
@EnvironmentObject var coursesViewModel: CoursesViewModel
```

Now when we run the app, we can favorite and unfavorite courses!

## Step 7: Add an animation
To wrap things up, we'll add a fun animation when we navigate to the course detail view. Specifically, we'll make the icon do a 360° spin and scale up when we enter the screen. First, we'll need a few state variables to store the state of the animation. Add these to `CourseDetailView`:
```swift
@State var scaleEffect: CGFloat = 0
@State var rotationEffect: Angle = .zero
```

Now, apply the `.scaleEffect` and `.rotationEffect` modifiers to the icon:
```swift
Image(systemName: course.icon)
    .resizable()
    .scaledToFit()
    .foregroundStyle(.tint)
    .scaleEffect(scaleEffect)
    .rotationEffect(rotationEffect)
    .frame(height: 100)
```

Finally, we'll use `.onAppear` to trigger the animation when the view appears on screen. We'll update the state variables, and we'll use `withAnimation` to tell SwiftUI to animate our changes:
```swift
// ...
.toolbar {
    // ...
}
.onAppear {
    withAnimation(.bouncy) {
        scaleEffect = 1
        rotationEffect = .degrees(360)
    }
}
```

And we're done! Go ahead and run the app once more - you'll notice our fancy animation whenever you tap on a course.
