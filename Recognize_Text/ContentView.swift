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
    
    @State private var isfinished : Bool = false
    @State private var recognizedText : String = "Now Loading"
    
    var body: some View {
        
        VStack{
            Image("swift")
                .resizable()
                .scaledToFit()
            
            
            Button(action: {
                
                print(RecognizedTextStruct(recognizedText: self.$recognizedText, isfinished: self.$isfinished).recognizedTextFunc())
                
            }, label: {
                Text("認識を開始")
                    .font(.headline)
                    .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    .padding(10)
                    .cornerRadius(20)
                    .background(Color(.gray))
                
            })
            
            Spacer(minLength: 0)
            
            
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
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct RecognizedTextStruct {
    
    @Binding var recognizedText : String
    @Binding var isfinished : Bool
    
    func recognizedTextFunc() -> String{
        
        var getTexts: [String] = []
        
        
        let vision = Vision.vision()
        
        let options = VisionCloudTextRecognizerOptions()
        options.languageHints = ["en", "ja"]
        let textRecognizer = vision.cloudTextRecognizer(options: options)
        
        let visionImage = VisionImage(image: UIImage(named: "swift")!)
        
        textRecognizer.process(visionImage) { result, error in
            guard error == nil, let result = result else {
                // ...
                return
            }
            
            //let resultText = result.text
            for block in result.blocks {
                //let blockText = block.text
                //let blockConfidence = block.confidence
                //let blockLanguages = block.recognizedLanguages
                //let blockCornerPoints = block.cornerPoints
                //let blockFrame = block.frame
                for line in block.lines {
                    //let lineText = line.text
                    //let lineConfidence = line.confidence
                    //let lineLanguages = line.recognizedLanguages
                    //let lineCornerPoints = line.cornerPoints
                    //let lineFrame = line.frame
                    for element in line.elements {
                        let elementText = element.text
                        //let elementConfidence = element.confidence
                        //let elementLanguages = element.recognizedLanguages
                        //let elementCornerPoints = element.cornerPoints
                        //let elementFrame = element.frame
                        
                        //self.recognizedText.wrappedValue = elementText
                        //self.text = elementText
                        print("debug \(elementText)")
                        
                        getTexts.append(elementText)
                        
                    }
                }
            }
            
            self.recognizedText = getTexts.joined(separator: "")
            print("debug \(self.recognizedText)")
            
        }
        self.isfinished.toggle()
        print("text -> \(self.recognizedText)")
        sleep(10)
        print("text -> \(self.recognizedText)")
        return self.recognizedText
        
        
    }
}
