//
//  VariousControls.swift
//  RemindMe
//
//  Created by Brian Krupp on 2/4/25.
//

import SwiftUI

struct VariousControls: View {
    @State var quantity = 0
    @State var priority:Double = 0
    @State var requireSignature:Bool = false
    @State var latestDeliveryDate:Date = .now
    @State var packingTape:Color = .blue
    @State var showAlert:Bool = false
    var body: some View {
        Form {
            Section {
                Stepper("Quantity \(quantity)", value: $quantity, in: 0...10)
                VStack {
                    HStack {
                        Text("Priority")
                        Spacer()
                    }
                    Slider(value:$priority, in: 0...100).tint(Color.green)

                }
            }
            
            Section{
                
                Text("\(Int(priority))")
                Toggle("Require Signature", isOn:$requireSignature)
                DatePicker("Latest Delivery Date",
                           selection:$latestDeliveryDate,
                           displayedComponents: .date)
                ColorPicker("Select Color", selection:$packingTape)
            }
            Section {
                Button("Complete") {
                    if (requireSignature){
                        showAlert.toggle()
                    }
                }
            }
        }
        .alert("Person required", isPresented:$showAlert){
            Button("Remove Requirement",
                   role: .destructive){
                requireSignature.toggle()
            }
            Button("Got it", role: .cancel){
                
            }
        }
    }
}

#Preview {
    VariousControls()
}
