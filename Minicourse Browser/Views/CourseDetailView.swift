//
//  CourseDetailView.swift
//  Minicourse Browser
//
//  Created by the CIS 1951 team on 2/15/24.
//

import SwiftUI

struct CourseDetailView: View {
    let course: Course
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: course.icon)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.tint)
                .frame(height: 100)
            
            Text(course.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
            
            Text(course.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

#Preview {
    CourseDetailView(course: Course.minicourses[0])
}
