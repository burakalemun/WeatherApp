//
//  WeatherWidget.swift
//  WeatherApp
//
//  Created by Burak Kaya on 14.10.2024.
//

import SwiftUI

struct WeatherWidget: View {
    var forceast: Forecast
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Trapezoid()
                .fill(Color.weatherWidgetBackground)
                .frame(width: 342, height: 174)
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(forceast.temperature)°")
                        .font(.system(size: 64))
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("H:\(forceast.high)° L:\(forceast.low)°")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        Text(forceast.location)
                            .font(.body)
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 0) {
                    Image("\(forceast.icon) large")
                        .padding(.trailing, 4)
                    
                    Text(forceast.weather.rawValue)
                        .font(.footnote)
                        .padding(.trailing, 24)
                }
            }
            .foregroundColor(.white)
            .padding(.bottom, 20)
            .padding(.leading, 20)
        }
        .frame(width: 342, height: 184, alignment: .bottom)
    }
}

#Preview {
    WeatherWidget(forceast: Forecast.cities[0])
        .preferredColorScheme(.dark)
}
