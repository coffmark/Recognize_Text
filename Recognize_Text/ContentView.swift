//
//  ContentView.swift
//  Recognize_Text
//
//  Created by 神村亮佑 on 2020/09/03.
//  Copyright © 2020 神村亮佑. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    
    @State private var image: Image?
    @State private var isfinished : Bool = false
    @State private var recognizedText : String = ""
    
    @State private var showingImagePicker: Bool = false
    @State private var inputImage: UIImage?
    
    
    @State private var isShowImage: Bool = false
    //画像の参照元を呼び出し
    let imageFileName = ImageFileName()

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    
    var body: some View {
        VStack{
            
            VStack{
                ZStack{
                    Rectangle().fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    }else{
                        Text("Loading Now")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
            }
            
            Button(action: {
                
                print(RecognizedText(recognizedText: self.$recognizedText, isfinished: self.$isfinished, inputImage: self.$inputImage).recognizedTextFunc())
                
                
            }, label: {
                Text("認識を開始")
                    .font(.headline)
                    .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    .padding(10)
                    .cornerRadius(20)
                    .background(Color(.gray))
            })
            
            Spacer(minLength: 0)
            
            //文字の取得が完了したら、表示する
            if isfinished{
                //RecognizedView()
                Text("\(self.recognizedText)")
                    .font(.body)
                    .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    .fontWeight(.heavy)
            }else{
                Text("🤔")
                    .font(.largeTitle)
            }
            
        }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
            ImagePicker(image: self.$inputImage)
            
        }
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

