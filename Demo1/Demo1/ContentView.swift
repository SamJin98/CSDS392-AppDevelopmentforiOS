//
//  ContentView.swift
//  Demo1
//
//  Created by Sam Jin on 1/16/25.
//

import SwiftUI

func countUp(to:Int?) {
    guard let maxCount = to, maxCount > 0 else {
        print("must be positive numbers")
        return
    }
    for number in 1...maxCount {
        print(number)
    }
}

func dogYears(humanYears:Int) -> Int {
    guard humanYears >= 0 else {
        print("must be positive numbers")
        return 0
    }
    return humanYears * 7
}




func swiftTesting() {
    let student = Student(firstName:"Sam", lastName:"Jin")
    student.setAge(26)
    
    print("Hello!")
    var x:Int = 5
    x = 20
    
    guard x >= 20 else {
        return
    }
    
    let z:Double = 10
    
    let greeting  = "Hello, world!"
    
    print("\(greeting) x is \(x) z is \(z)")
    
    var nums = [1, 2, 3]
    var noNums = [Int]()
    noNums.append(10)
    
    // Dictionay
    var dictionary = ["name": "Sam", "Major":"CS"]
    var distionay2 = [String:String]()
    
    for num in nums {
        if num > 2 {
            print("Big number \(num)")
        }
        else {
            print("Small number \(num)")
        }
    }
    
    for index in 1...5 {
        print(index)
    }
    
    var name:String?
    print(name?.count ?? 0)
    if let name = name {
        print("we have a name \(name)")
    }
    else {
        print("no name")
    }
    
    
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("click me") {
                swiftTesting()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
