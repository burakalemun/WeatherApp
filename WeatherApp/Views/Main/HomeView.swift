//  HomeView.swift
//  WeatherApp
//
//  Created by Burak Kaya on 28.09.2024.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83 // 702/844
    case middle = 0.490 // 325/844
}

struct HomeView: View {
    @State var isBottomSheetPresented: Bool = true
    @State var selectedDetent: BottomSheet.PresentationDetent = .medium
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    @State var hasDragged: Bool = false
    
    var bottomSheetPosition: BottomSheetPosition {
        if bottomSheetTranslation <= BottomSheetPosition.middle.rawValue {
            return .middle
        } else {
            return .top
        }
    }

    var bottomSheetTranslationProrated: CGFloat {
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffset = screenHeight + 36

                ZStack {
                    // Arka Plan Rengi
                    Color.background
                        .ignoresSafeArea()

                    // Arka Plan Görseli
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)

                    // Ev Görseli
                    Image("House")
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 257)
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)

                    VStack(spacing: -10 * (1 - bottomSheetTranslationProrated)) {
                        Text("Montreal")
                            .font(.largeTitle)
                        
                        VStack {
                            Text(attributedString)
                                
                            Text("H:24°   L:18°")
                                .font(.title3.weight(.semibold))
                                .opacity(1 - bottomSheetTranslationProrated)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 51)
                    .offset(y: -bottomSheetTranslationProrated * 46)
                    

                    // BottomSheet Görünümü
                    EmptyView()
                        .sheetPlus(
                            isPresented: Binding<Bool>(
                                get: {
                                    return isBottomSheetPresented
                                },
                                set: { newValue in
                                    if selectedDetent == .medium {
                                        isBottomSheetPresented = newValue
                                    }
                                }
                            ),
                            background: EmptyView(),
                            onDrag: { translation in
                                bottomSheetTranslation = translation / screenHeight
                                
                                withAnimation(.easeInOut) {
                                    if bottomSheetPosition == BottomSheetPosition.top {
                                        hasDragged = false
                                    } else {
                                        hasDragged = true
                                    }
                                }
                            },
                            main: {
                                ForecastView(bottomSheetTranslationProrated: bottomSheetTranslationProrated)
                                    .presentationDetentsPlus(
                                        [.medium, .large],
                                        selection: $selectedDetent
                                    )
                            }
                        )

                    // Tab Bar
                    TabBar(action: {
                        isBottomSheetPresented.toggle()
                        selectedDetent = .large
                    })
                    .offset(y: bottomSheetTranslationProrated * 115)
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + (hasDragged ? " | " : "\n") + "Mostly Clear")
        
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: (96 - (bottomSheetTranslationProrated * (96 - 33))), weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottomSheetTranslationProrated)
        }
        
        if let weather = string.range(of: "Mostly Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }

}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
