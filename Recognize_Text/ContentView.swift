//
//  ContentView.swift
//  Recognize_Text
//
//  Created by 神村亮佑 on 2020/09/01.
//  Copyright © 2020 神村亮佑. All rights reserved.
//


import SwiftUI

struct ContentView: View {
    
    @State private var recognizedText = "Tap button to start scanning"
    
    
    @State private var isShowingCaptureView = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.gray.opacity(0.2))
                        
                        Text(recognizedText)
                            .padding()
                    }
                    .padding()
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.isShowingCaptureView = true
                    }) {
                        Text("Start Scanning")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Capsule().fill(Color.blue))
                }
                .padding()
            }
            .navigationBarTitle("Text Recognition")
                
                
           //.sheet(isPresented: $isShowingCaptureView) {
                
                
                //ScanDocumentView(recognizedText: self.$recognizedText)
            //}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
