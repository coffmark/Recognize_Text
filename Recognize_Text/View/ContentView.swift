//
//  ContentView.swift
//  Recognize_Text
//
//  Created by 神村亮佑 on 2020/09/03.
//  Copyright © 2020 神村亮佑. All rights reserved.
//

import SwiftUI
import Firebase
import Foundation


struct ContentView: View {
    
    
    @State private var image: Image?
    //終わったか返す変数
    @State private var isfinished : Bool = false
    //認識するテキスト
    @State private var recognizedText : String = ""
    
    @State private var showingImagePicker: Bool = false
    @State private var inputImage: UIImage?
    
    //Copy Button の色を変える変数
    @State private var isCopyText: Bool = false
    
    @State private var isShowImage: Bool = false
    
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
            
            HStack {
                Spacer(minLength: 0)
                
                Button(action: {
                    
                    print(RecognizedText(recognizedText: self.$recognizedText, isfinished: self.$isfinished, inputImage: self.$inputImage).recognizedTextFunc())
                    self.isCopyText = true
                    
                }, label: {
                    Text("認識を開始")
                        .font(.headline)
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .padding(10)
                        .cornerRadius(20)
                        .background(Color(#colorLiteral(red: 1, green: 0.7496010065, blue: 0, alpha: 1)))
                })
                Spacer(minLength: 0)
                Button(action: {
                    if self.isfinished{
                        UIPasteboard.general.string = "\(self.recognizedText)"
                    }else{
                        self.isCopyText = false
                        UIPasteboard.general.string = ""
                    }
                    
                }, label: {
                    Text("コピー")
                        .font(.headline)
                        .foregroundColor(self.isCopyText ?  Color(#colorLiteral(red: 0.1247209385, green: 0.29296875, blue: 0.6007090807, alpha: 1)) : Color(#colorLiteral(red: 0.5254421234, green: 0.5255209804, blue: 0.5254250169, alpha: 1)))
                        .padding(10)
                        .cornerRadius(20)
                        .background(self.isCopyText ?  Color(#colorLiteral(red: 1, green: 0.7983970642, blue: 0.007040084805, alpha: 1)) : Color(#colorLiteral(red: 0.6666070223, green: 0.6667050123, blue: 0.6665856242, alpha: 1)))
                })
                Spacer(minLength: 0)
            }
            
            Spacer(minLength: 0)
            
            //文字の取得が完了したら、表示する
            if isfinished{
                //RecognizedView()
                Text("\(self.recognizedText)")
                    .font(.body)
                    .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    .fontWeight(.heavy)
            }else{
                //MARK: - Represent Loading Image
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

