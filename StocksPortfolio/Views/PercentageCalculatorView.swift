//
//  PercentageCalculatorView.swift
//  StocksPortfolio
//
//  Created by RAMESH on 21/05/23.
//

import SwiftUI

struct EntityModel: Identifiable {
    let id = UUID()
    let name: String
    let initialValue: Double
    let finalValue: Double
    var returnsPercentage: Double = 0
    var percentage: Double {
        let value = (((finalValue - initialValue)/initialValue) * 100)
        return value
    }
}

struct PercentageCalculatorView: View {
    @State var entityName: String = ""
    @State var initialValue: String = ""
    @State var finalValue: String = ""
    @State var percentage: String = ""
    @State var isResultHidden = true
    @State var model: [EntityModel] = []
    
    func clearAllFields() {
        entityName = ""
        initialValue = ""
        finalValue =  ""
        percentage = ""
    }
    var body: some View {
        VStack(alignment:.leading,spacing: 20) {
            
            TextField("Entity Name", text: $entityName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.all)
                .font(.system(size: 20, weight: .heavy, design: .default))
                .background(.yellow)
                .cornerRadius(10)
                .accentColor(.blue)
            TextField("Initial Value", text: $initialValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.all)
                .font(.system(size: 20, weight: .heavy, design: .default))
                .background(.yellow)
                .cornerRadius(10)
                .accentColor(.blue)
            TextField("Final Value", text: $finalValue)
                .padding(.all)
                .font(.system(size: 20, weight: .heavy, design: .default))
                .background(.yellow)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(10)
                .accentColor(.yellow)
            TextField("Percentage", text: $percentage)
                .padding(.all)
                .font(.system(size: 20, weight: .heavy, design: .default))
                .background(.yellow)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(10)
                .accentColor(.yellow)
            HStack(alignment:.center ){
            Button("Calculate") {
                print("Button preseed")
                //                let result = computePercentage(initialValue: initialValue, finalValue: finalValue)
                //                result
                if isResultHidden {
                    //isResultHidden = false
                    //                    percentage = String(format: "%.2f", result)
                    guard let start = Double(initialValue), let end = Double(finalValue) else {
                        return
                    }
                    var entity = EntityModel(name: entityName, initialValue: start, finalValue: end)
                    entity.returnsPercentage =  entity.percentage
                    let returnsString = String(format: "%.2f", entity.returnsPercentage)
                    percentage = returnsString
                    model.append(entity)
                    EntityListView(model: $model)
                }
            } .padding(20)
                    .foregroundColor(.white)
                    .background(.blue)
                    .font(.system(size: 20, weight: .heavy, design: .default))
                    .cornerRadius(40)
        
            Button("Clear") {
                print("Clear Button preseed")
                if isResultHidden {
                    //isResultHidden = false
                }
                clearAllFields()
            }
            .padding(20)
            .foregroundColor(.white)
            .background(.blue)
            .font(.system(size: 20, weight: .heavy, design: .default))
            .cornerRadius(40)
        }
           
            Spacer()
        }.padding(20)
        
    }
}

struct EntityListView: View {
    
    @Binding var model: [EntityModel]
    var body: some View {
        List(model) { model in
            HStack {
                Text(model.name)
                Spacer()
                let returnsString = String(format: "%.2f", model.returnsPercentage)
                Text(returnsString)
            }
        }
    }
}
struct PercentageCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        PercentageCalculatorView()
    }
}
