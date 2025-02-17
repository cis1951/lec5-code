//
//  RootView.swift
//  Minicourse Browser
//
//  Created by the CIS 1951 team on 2/15/24.
//

import SwiftUI

struct RootView: View {
    @State var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List(Course.minicourses) { course in
                CourseRowView(course: course)
            }
            .navigationTitle("Minicourses")
            .navigationDestination(for: Course.self) { course in
                CourseDetailView(course: course)
            }
            .toolbar {
                ToolbarItem {
                    Button("Random Course", systemImage: "dice") {
                        navigationPath.append(Course.minicourses.randomElement()!)
                    }
                }
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
