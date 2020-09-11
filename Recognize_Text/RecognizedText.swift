//
//  RecognizedText.swift
//  Recognize_Text
//
//  Created by 神村亮佑 on 2020/09/09.
//  Copyright © 2020 神村亮佑. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase


struct RecognizedText {
    
    @Binding var recognizedText : String
    @Binding var isfinished : Bool
    
    @Binding var inputImage: UIImage?

    
    let imageFileName = ImageFileName()
     
    func recognizedTextFunc() -> String{
        //取得したテキストを一時的に入れる
        var getTexts: [String] = []
        
        
        let vision = Vision.vision()
        
        let options = VisionCloudTextRecognizerOptions()
        options.languageHints = ["en", "ja"]
        let textRecognizer = vision.cloudTextRecognizer(options: options)
        
        let visionImage = VisionImage(image: (inputImage!))
        
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
        
        return self.recognizedText
          
    }
}


