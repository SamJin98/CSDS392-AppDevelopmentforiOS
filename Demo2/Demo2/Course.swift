//
//  Course.swift
//  Demo2
//
//  Created by Sam Jin on 1/21/25.
//

import Foundation

class Course {
    let name: String
    let credits: Int
    var instructor: String?
    
    var students:[Student] = [Student]()
    
    init(name: String, credits: Int) {
        self.name = name
        self.credits = credits
    }
    
    public func addStudent(_ student:Student) {
        students.append(student)
    }
}

class Student {
    let firstName: String
    let lastName: String
    var age: Int?
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func setAge(age:Int) {
        self.age = age
        
    }
    
}
