//
//  RootView.swift
//  Minicourse Browser
//
//  Created by the CIS 1951 team on 2/15/24.
//

import SwiftUI

struct RootView: View {
    @State var selectedCourse: Course? = nil
    @EnvironmentObject var coursesViewModel: CoursesViewModel
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            List {
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
            .navigationTitle("Minicourses")
            .navigationDestination(for: Course.self) { course in
                CourseDetailView(course: course)
            }
        }
    }
}

struct CourseRowView: View {
    let course: Course
    
    var body: some View {
        NavigationLink(
            value: course,
            label: {
                Label("**\(course.code)**: \(course.name)", systemImage: course.icon)
            }
        )
    }
}

#Preview {
    RootView()
        .environmentObject(CoursesViewModel())
        .environmentObject(NavigationManager())
}
