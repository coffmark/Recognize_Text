//
//  CameraView.swift
//  Recognize_Text
//
//  Created by 神村亮佑 on 2020/09/02.
//  Copyright © 2020 神村亮佑. All rights reserved.
//

import SwiftUI

struct CameraView: View {
    
    
    @State private var recognizedText = "Push Button"
    
    var body: some View {
        
        
        guard let img = UIImage(named: "logo") else {
            fatalError("Unable to load image")
        }
        
        return
            VStack{
                Image(uiImage: img).resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                
                Text("\(self.recognizedText)").foregroundColor(.black)
                    .fontWeight(.bold)
                Spacer()
                Button ("Let's Recognize Text"){
                
                }
        }
        
        
        
        
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
