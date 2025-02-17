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
        List(Course.minicourses) { course in
            CourseRowView(course: course)
        }
    }
}

struct CourseRowView: View {
    let course: Course
    
    var body: some View {
        Label("**\(course.code)**: \(course.name)", systemImage: course.icon)
    }
}

#Preview {
    RootView()
}
