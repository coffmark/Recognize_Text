//
//  ViewController.swift
//  Recognize_Text
//
//  Created by 神村亮佑 on 2020/09/03.
//  Copyright © 2020 神村亮佑. All rights reserved.
//

import Foundation
import Firebase
import SwiftUI


final class RecognizedView : UIViewRepresentable {

    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    // make UI View
    func makeUIView(context: Context) -> UILabel {
        
        var get_text: String = Coordinator().recognizedTextFunc()
        
        let label = UILabel()
        label.text = get_text
        return label
    }
    
    
    // update UI View
    func updateUIView(_ uiView: UILabel, context: Context) {
       
    }
    
    
    
    class Coordinator{
        
        var getTexts: [String] = []
        var text: String = "Now Loading"
        
        var isCompleted: Bool = false
        
        // UI Image is argument.
        func recognizedTextFunc() -> String{
            
            let vision = Vision.vision()
            
            let options = VisionCloudTextRecognizerOptions()
            options.languageHints = ["en", "ja"]
            let textRecognizer = vision.cloudTextRecognizer(options: options)
            
            let visionImage = VisionImage(image: UIImage(named: "logo")!)
            
            
            textRecognizer.process(visionImage) { result, error in
                guard error == nil, let result = result else {
                    // ...
                    return
                }
                
                let resultText = result.text
                for block in result.blocks {
                    let blockText = block.text
                    let blockConfidence = block.confidence
                    let blockLanguages = block.recognizedLanguages
                    let blockCornerPoints = block.cornerPoints
                    let blockFrame = block.frame
                    for line in block.lines {
                        let lineText = line.text
                        let lineConfidence = line.confidence
                        let lineLanguages = line.recognizedLanguages
                        let lineCornerPoints = line.cornerPoints
                        let lineFrame = line.frame
                        for element in line.elements {
                            let elementText = element.text
                            let elementConfidence = element.confidence
                            let elementLanguages = element.recognizedLanguages
                            let elementCornerPoints = element.cornerPoints
                            let elementFrame = element.frame
                            
                            //self.recognizedText.wrappedValue = elementText
                            //self.text = elementText
                            print("debug \(elementText)")
                            
                            self.getTexts.append(elementText)
                            
                        }
                    }
                }
                
                self.text = self.getTexts.joined(separator: ",")
                print("debug \(self.text)")
                
            }
            
            return text
        }
        
    }
    
    
    
    
}
