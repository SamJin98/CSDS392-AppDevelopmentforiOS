//
//  Student.swift
//  Demo1
//
//  Created by Sam Jin on 1/16/25.
//

import Foundation

class Student : Describeable{
    
    let firstName:String
    let lastName:String
    private var age:Int?
    
    init(firstName:String, lastName:String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    public func setAge(_ age:Int) {
        self.age = age
    }
    
    func getDesciption() -> String {
        return firstName + " " + lastName
    }

}

protocol Describeable {
    func getDesciption() -> String
}


struct SimpleStudent : Describeable{
    let firstName:String
    let lastName:String
    private var age:Int?
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func getDesciption() -> String {
        return firstName + " " + lastName
    }
}
