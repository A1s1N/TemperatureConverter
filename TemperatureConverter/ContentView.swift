//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Никита Александров on 05.09.2022.
//

import SwiftUI

enum Temperature: String, CaseIterable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var temperature = 0.0
    @State private var tipTemperature = Temperature.celsius
    @State private var totalTipTemperature = Temperature.celsius
    
    var totalTempereture: Double {
        switch (tipTemperature, totalTipTemperature) {
        case (Temperature.celsius, Temperature.celsius), (Temperature.fahrenheit, Temperature.fahrenheit), (Temperature.kelvin, Temperature.kelvin):
            return temperature
        case (Temperature.celsius, Temperature.fahrenheit):
            return temperature * 9/5 + 32
        case (Temperature.celsius, Temperature.kelvin):
            return temperature + 273.15
        case (Temperature.fahrenheit, Temperature.celsius):
            return (temperature - 32) * 5/9
        case (Temperature.fahrenheit, Temperature.kelvin):
            return (temperature + 459.67) * 5/9
        case (Temperature.kelvin, Temperature.celsius):
            return temperature - 273.15
        case (Temperature.kelvin, Temperature.fahrenheit):
            return temperature * 9/5 - 459.67
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperature", value: $temperature, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()

                                Button("Done") {
                                    amountIsFocused = false
                                }
                            }
                        }
                    
                    Picker("Tip temperature", selection: $tipTemperature) {
                        ForEach(Temperature.allCases, id: \.self) {
                            Text($0.localizedName)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Enter the temperature")
                }
                
                Section {
                    Text(totalTempereture, format: .number)
                    
                    Picker("Total tip temperature", selection: $totalTipTemperature) {
                        ForEach(Temperature.allCases, id: \.self) {
                            Text($0.localizedName)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Temperature Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
