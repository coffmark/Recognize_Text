//
//  ContentView.swift
//  Recognize_Text
//
//  Created by 神村亮佑 on 2020/09/03.
//  Copyright © 2020 神村亮佑. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    

    @State private var isShowing : Bool = false
    
    
    
    var body: some View {
        
        VStack{
            Image("logo")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)

            
            Button(action: {
                self.isShowing = true
            }, label: {
                Text("Start Recognized Text")
            })
            Spacer()
            
            if isShowing{
                RecognizedView()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
