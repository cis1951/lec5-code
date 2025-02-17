//
//  CourseDetailView.swift
//  Minicourse Browser
//
//  Created by the CIS 1951 team on 2/15/24.
//

import SwiftUI

struct CourseDetailView: View {
    @State var scaleEffect: CGFloat = 0
    @State var rotationEffect: Angle = .zero
    
    @Environment(FavoritesViewModel.self) var favoritesViewModel
    
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
                if favoritesViewModel.isFavorited(course: course) {
                    Button("Favorited", systemImage: "star.fill") {
                        favoritesViewModel.unfavorite(course: course)
                    }
                } else {
                    Button("Add to Favorites", systemImage: "star") {
                        favoritesViewModel.favorite(course: course)
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var favoritesViewModel = FavoritesViewModel()
    
    NavigationStack {
        CourseDetailView(course: Course.minicourses[0])
            .environment(favoritesViewModel)
    }
}
