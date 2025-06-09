//
//  ContentView.swift
//  DashButton
//
//  Created by Akhil Dakinedi on 6/8/25.
//

import SwiftUI

struct ContentView: View {
    private let basePositions: [SIMD2<Float>] = [
        .init(x: 0, y: 0), .init(x: 0.5, y: 0), .init(x: 1, y: 0),
        .init(x: 0, y: 0.5), .init(x: 0.5, y: 0.5), .init(x: 1, y: 0.5),
        .init(x: 0, y: 1), .init(x: 0.5, y: 1), .init(x: 1, y: 1)
    ]

    private let colors: [Color] = {
        var colorArray = [Color](repeating: Color(red: 238/255, green: 46/255, blue: 25/255), count: 9)
        colorArray[4] = Color(red: 250/255, green: 107/255, blue: 88/255)
        return colorArray
    }()

    private let newColors: [Color] = [
        // Row 1: #EE2E19
        Color(red: 238/255, green: 46/255, blue: 25/255),
        Color(red: 238/255, green: 46/255, blue: 25/255),
        Color(red: 238/255, green: 46/255, blue: 25/255),
        // Row 2: #F54323
        Color(red: 245/255, green: 67/255, blue: 35/255),
        Color(red: 245/255, green: 67/255, blue: 35/255),
        Color(red: 245/255, green: 67/255, blue: 35/255),
        // Row 3: #FA7463
        Color(red: 250/255, green: 116/255, blue: 99/255),
        Color(red: 250/255, green: 116/255, blue: 99/255),
        Color(red: 250/255, green: 116/255, blue: 99/255)
    ]

    var body: some View {
        VStack(spacing: 16) {
            /*
            Button(action: {
                print("Button tapped!")
            }) {
                HStack(alignment: .center, spacing: 0) {
                    Text("Dash")
                        .foregroundColor(Color.white)
                        .font(.custom("TTNorms-Bold", size: 24))
                }
                .padding(.leading, 8)
                .padding(.trailing, 8.00001)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(
                    Group {
                        if #available(iOS 18.0, *) {
                            TimelineView(.animation) { timeline in
                                MeshGradient(
                                    width: 3,
                                    height: 3,
                                    points: animatedPositions(for: timeline.date),
                                    colors: colors,
                                    smoothsColors: true
                                )
                            }
                        } else {
                            MeshGradient(width: 3, height: 3, points: basePositions, colors: colors)
                        }
                    }
                )
                .cornerRadius(9999)
            }
            */
            
            Button(action: {
                print("Button tapped!")
            }) {
                HStack(alignment: .center, spacing: 0) {
                    Text("Dash")
                        .foregroundColor(Color.white)
                        .font(.custom("TTNorms-Bold", size: 24))
                }
                .padding(.leading, 8)
                .padding(.trailing, 8.00001)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(
                    Group {
                        if #available(iOS 18.0, *) {
                            TimelineView(.animation) { timeline in
                                MeshGradient(
                                    width: 3,
                                    height: 3,
                                    locations: .points(basePositions),
                                    colors: .colors(animatedNewColors(for: timeline.date)),
                                    background: .black,
                                    smoothsColors: true
                                )
                            }
                        } else {
                            MeshGradient(width: 3, height: 3, points: basePositions, colors: newColors)
                        }
                    }
                )
                .cornerRadius(9999)
            }
        }
        .padding(.horizontal, 48)
    }
    
    private func animatedPositions(for date: Date) -> [SIMD2<Float>] {
        let phase = CGFloat(date.timeIntervalSince1970)
        var animatedPositions = basePositions
        
        // Animate the middle control points using cosine waves
        // This creates a flowing, organic animation
        animatedPositions[1].x = 0.5 + 0.4 * Float(cos(phase))
        animatedPositions[3].y = 0.5 + 0.3 * Float(cos(phase * 1.1))
        animatedPositions[4].y = 0.5 - 0.4 * Float(cos(phase * 0.9))
        animatedPositions[5].y = 0.5 - 0.2 * Float(cos(phase * 0.9))
        animatedPositions[7].x = 0.5 - 0.4 * Float(cos(phase * 1.2))
        
        return animatedPositions
    }
    
    private func animatedNewColors(for date: Date) -> [Color] {
        let phase = CGFloat(date.timeIntervalSince1970)
        
        return newColors.enumerated().map { index, color in
            let hueShift = cos(phase + Double(index) * 0.3) * 0.02
            return shiftHue(of: color, by: hueShift)
        }
    }
    
    private func shiftHue(of color: Color, by amount: Double) -> Color {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        UIColor(color).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        hue += CGFloat(amount)
        hue = hue.truncatingRemainder(dividingBy: 1.0)
        
        if hue < 0 {
            hue += 1
        }
        
        return Color(hue: Double(hue), saturation: Double(saturation), brightness: Double(brightness), opacity: Double(alpha))
    }
}

#Preview {
    VStack(spacing: 0) {
        VStack {
            Spacer()
            ContentView()
                .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)

        VStack {
            ContentView()
                .padding(.top, 24)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 36/255, green: 36/255, blue: 36/255))
    }
    .ignoresSafeArea()
}
