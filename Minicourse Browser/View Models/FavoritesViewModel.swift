import Observation

@Observable class FavoritesViewModel {
    private var favoritedCourseCodes = Set<String>()
    
    init(favoritedCourseCodes: Set<String> = []) {
        self.favoritedCourseCodes = favoritedCourseCodes
    }
    
    func isFavorited(course: Course) -> Bool {
        return favoritedCourseCodes.contains(course.id)
    }
    
    func favorite(course: Course) {
        favoritedCourseCodes.insert(course.id)
    }
    
    func unfavorite(course: Course) {
        favoritedCourseCodes.remove(course.id)
    }
    
    var favoritedCourses: [Course] {
        Course.minicourses.filter { isFavorited(course: $0) }
    }
    
    var unfavoritedCourses: [Course] {
        Course.minicourses.filter { !isFavorited(course: $0) }
    }
}
