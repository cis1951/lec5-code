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
    
    var body: some View {
        NavigationSplitView {
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
            .navigationTitle("Minicourses")
        } detail: {
            if let selectedCourse {
                CourseDetailView(course: selectedCourse)
            } else {
                Text("Choose a minicourse on the sidebar.")
                    .foregroundStyle(.secondary)
                    .padding()
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
}
