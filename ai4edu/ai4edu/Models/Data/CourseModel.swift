//
//  CourseModel.swift
//  ai4edu
//
//  Created by Sam Jin on 3/24/25.
//

import Foundation

struct Course: Identifiable, Codable, Equatable {
    let id: String
    let role: String
    let name: String
    
    static func == (lhs: Course, rhs: Course) -> Bool {
        return lhs.id == rhs.id
    }
}

class CourseManager {
    static let shared = CourseManager()
    private let coursesKey = "courses"
    private let selectedCourseKey = "selected_course"
    
    func saveCourses(_ courses: [Course]) {
        if let encoded = try? JSONEncoder().encode(courses) {
            UserDefaults.standard.set(encoded, forKey: coursesKey)
        }
    }
    
    func getCourses() -> [Course] {
        if let data = UserDefaults.standard.data(forKey: coursesKey),
           let courses = try? JSONDecoder().decode([Course].self, from: data) {
            
            let workspaceRoles = TokenManager.shared.getWorkspaceRoles()
            
            if !workspaceRoles.isEmpty {
                var updatedCourses = courses
                
                for (index, course) in courses.enumerated() {
                    if let roleFromToken = workspaceRoles[course.id] {
                        updatedCourses[index] = Course(id: course.id, role: roleFromToken, name: course.name)
                    }
                }
                
                saveCourses(updatedCourses)
                return updatedCourses
            }
            
            return courses
        }
        
        return getMockCoursesWithRoles()
    }
    
    func saveSelectedCourse(_ course: Course) {
        if let encoded = try? JSONEncoder().encode(course) {
            UserDefaults.standard.set(encoded, forKey: selectedCourseKey)
        }
    }
    
    func getSelectedCourse() -> Course? {
        if let data = UserDefaults.standard.data(forKey: selectedCourseKey),
           let course = try? JSONDecoder().decode(Course.self, from: data) {
            return course
        }
        return nil
    }
    
    private func getMockCourses() -> [Course] {
        return [
            Course(id: "ECON235.F24", role: "student", name: "The Future Me"),
            Course(id: "CSDS392.F25", role: "student", name: "iOS App Development"),
            Course(id: "CSDS344.S24", role: "admin", name: "Computer Security"),
            Course(id: "MATH380.S24", role: "student", name: "Probability")
        ]
    }
    
    private func getMockCoursesWithRoles() -> [Course] {
        let mockCourses = getMockCourses()
        let workspaceRoles = TokenManager.shared.getWorkspaceRoles()
        
        if workspaceRoles.isEmpty {
            return mockCourses
        }
        
        return mockCourses.map { course in
            if let roleFromToken = workspaceRoles[course.id] {
                return Course(id: course.id, role: roleFromToken, name: course.name)
            }
            return course
        }
    }
} 