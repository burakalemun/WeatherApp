//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Burak Kaya on 2.10.2024.
//

import SwiftUI

struct ForecastView: View {
    
    var bottomSheetTranslationProrated: CGFloat = 1
    @State private var selection = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                SegmentedControl(selection: $selection)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    if selection == 0 {
                        ForEach(Forecast.hourly) { forecast in
                            ForecastCard(forecast: forecast, forecastPeriod: .hourly)
                        }
                        .transition(.offset(x: -430))
                    } else {
                        ForEach(Forecast.daily) { forecast in
                            ForecastCard(forecast: forecast, forecastPeriod: .daily)
                        }
                        .transition(.offset(x: 430))
                    }
                }
                .padding(.vertical, 20)
            }
            .padding(.horizontal, 20)
            
            Image("Forecast Widgets")
                .opacity(bottomSheetTranslationProrated)
            }
        }
        .backgroundBlur(radius: 25, opaque: true)
        .innerShadow(shape: RoundedRectangle(cornerRadius: 44), color: Color.bottomSheetBackground, lineWidth: 1, offsetX: 0, offsetY: 1, blur: 0, blendMode: .overlay, opacity: 1 - bottomSheetTranslationProrated)
        .overlay {
            Divider()
                .blendMode(.overlay)
                .background(Color.bottomSheetBorderTop)
                .frame(maxHeight: .infinity, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.3))
                .frame(width: 48, height: 5)
                .frame(height: 20)
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    ForecastView()
        .background(Color.background)
        .preferredColorScheme(.dark)
}
