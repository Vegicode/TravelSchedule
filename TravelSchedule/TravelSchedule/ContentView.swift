//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Mac on 10.02.2025.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView{
            VStack{
                Color.gray.edgesIgnoringSafeArea(.top)
                Text("Красная вкладка")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
            }
            .tabItem{
                Label("Красный",systemImage: "1.square.fill")
            }
            VStack{
                Color.blue.edgesIgnoringSafeArea(.top)
                Text("Синяя вкладка")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
            }
            .tabItem{
                Label("Синий",systemImage: "2.square.fill")
            }
        }
    }
     
}

#Preview {
    ContentView()
}

