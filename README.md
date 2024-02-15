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
        NavigationLink(
            destination: {
                CourseDetailView(course: course)
            },
            label: {
                Label("**\(course.code)**: \(course.name)", systemImage: course.icon)
            }
        )
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
NavigationLink(
    value: course,
    label: {
        Label("**\(course.code)**: \(course.name)", systemImage: course.icon)
    }
)
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

Now, let's swap out `NavigationStack` for `NavigationSplitView`. Note that the split view takes an extra parameter, the `detail` parameter, which tells SwiftUI what to show to the right of the sidebar. Let's have `detail` show the current course, or a placeholder if no course is selected:
```swift
NavigationSplitView {
    List(Course.minicourses) { course in
        CourseRowView(course: course)
    }
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

You might ask: What's that `detail:` doing there? That's actually a controversial feature called [multiple trailing closure syntax](https://github.com/apple/swift-evolution/blob/main/proposals/0279-multiple-trailing-closures.md). It was subject to some derision when it was initiaally proposed, but it's actually quite useful when dealing with SwiftUI.

If you build and run, you'll notice while the app behaves the same way as before on iPhone, it feels a lot more at home on iPad. That's the magic of `NavigationSplitView` - it automatically adapts to whatever device you're using.
