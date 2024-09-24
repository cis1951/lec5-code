//
//  CourseDetailView.swift
//  Minicourse Browser
//
//  Created by the CIS 1951 team on 2/15/24.
//

import SwiftUI

struct CourseDetailView: View {
    @EnvironmentObject var coursesViewModel: CoursesViewModel
    @EnvironmentObject var navigationManager: NavigationManager
    
    @State var scaleEffect: CGFloat = 0
    @State var rotationEffect: Angle = .zero
    
    let course: Course
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: course.icon)
                .resizable()
                .scaledToFit()
                .scaleEffect(scaleEffect)
                .rotationEffect(rotationEffect)
                .foregroundStyle(.tint)
                .frame(height: 100)
            
            Text(course.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
            
            Text(course.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            HStack {
                Button(action: {
                    navigationManager.path = NavigationPath()
                }) {
                    Text("Go Home")
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink(
                    value: Course.minicourses.randomElement()!,
                    label: {
                        Text("Random Course")
                    }
                )
            }
        }
        .onAppear {
            withAnimation(.bouncy(duration: 0.5)) {
                scaleEffect = 1
                rotationEffect = .degrees(360)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .navigationTitle(course.code)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                if coursesViewModel.isFavorited(course: course) {
                    Button("Unfavorite", systemImage: "star.fill") {
                        coursesViewModel.unfavorite(course: course)
                    }
                } else {
                    Button("Favorite", systemImage: "star") {
                        coursesViewModel.favorite(course: course)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CourseDetailView(course: Course.minicourses[0])
            .environmentObject(CoursesViewModel())
            .environmentObject(NavigationManager())
    }
}
