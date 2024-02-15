//
//  Course.swift
//  Minicourse Browser
//
//  Created by the CIS 1951 team on 2/15/24.
//

/// A minicourse.
struct Course: Hashable {
    /// The code for the minicourse, e.g. "CIS 1951".
    let code: String
    
    /// The full name of the minicourse, e.g. "iPhone App Development".
    let name: String
    
    /// The description of the course.
    let description: String
    
    /// The SF Symbol name for this course.
    let icon: String
}

extension Course: Identifiable {
    var id: String { code }
}
