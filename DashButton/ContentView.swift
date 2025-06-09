//
//  ContentView.swift
//  DashButton
//
//  Created by Akhil Dakinedi on 6/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
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
                  LinearGradient(
                    stops: [
                      Gradient.Stop(color: Color(red: 0.98, green: 0.42, blue: 0.35), location: 0.00),
                      Gradient.Stop(color: Color(red: 0.93, green: 0.18, blue: 0.1), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0, y: 0),
                    endPoint: UnitPoint(x: 0.64, y: 0.64)
                  )
                )
                .cornerRadius(9999)
            }
        }
        .padding(.horizontal, 48)
    }
}

#Preview {
    ContentView()
}
