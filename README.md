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


