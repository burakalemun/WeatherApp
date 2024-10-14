//
//  TabBar.swift
//  WeatherApp
//
//  Created by Burak Kaya on 1.10.2024.
//

import SwiftUI

struct TabBar: View {
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Arc()
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color(UIColor(red: 0x3A/255, green: 0x3A/255, blue: 0x6A/255, alpha: 1)),
                                                Color(UIColor(red: 0x25/255, green: 0x24/255, blue: 0x4C/255, alpha: 1))]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .opacity(0.3)
                .frame(height: 88)
                .overlay {
                    Arc()
                        .stroke(Color.tabBarBorder, lineWidth: 0.5)
                }

            
            HStack {
                Button {
                    action()
                } label: {
                    Image(systemName: "mappin.and.ellipse")
                        .frame(width: 44, height: 44)
                }
                
                Spacer()
                
                NavigationLink {
                    WeatherView()
                } label: {
                    Image(systemName: "list.star")
                        .frame(width: 44, height: 44)
                }
            }
            .font(.title2)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 20, leading: 32, bottom: 24, trailing: 32))
        }
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
        .ignoresSafeArea()
    }
}

#Preview {
    TabBar(action: {})
        .preferredColorScheme(.dark)
}
