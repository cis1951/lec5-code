//
//  CoursesViewModel.swift
//  Minicourse Browser
//
//  Created by Anthony Li on 2/15/24.
//

import SwiftUI

class CoursesViewModel: ObservableObject {
    @Published private var favoritedCourseCodes = Set<String>()
    
    func isFavorited(course: Course) -> Bool {
        return favoritedCourseCodes.contains(course.code)
    }
    
    func favorite(course: Course) {
        favoritedCourseCodes.insert(course.code)
    }
    
    func unfavorite(course: Course) {
        favoritedCourseCodes.remove(course.code)
    }
    
    var favoritedCourses: [Course] {
        return Course.minicourses.filter { isFavorited(course: $0) }
    }
    
    var unfavoritedCourses: [Course] {
        return Course.minicourses.filter { !isFavorited(course: $0) }
    }
}
