//
//  RootView.swift
//  Minicourse Browser
//
//  Created by the CIS 1951 team on 2/15/24.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
            List(Course.minicourses) { course in
                CourseRowView(course: course)
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
        NavigationLink(value: course) {
            Label("**\(course.code)**: \(course.name)", systemImage: course.icon)
        }
    }
}

#Preview {
    RootView()
}
