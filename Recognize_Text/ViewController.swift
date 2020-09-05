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
import Dispatch


struct RecognizedView : UIViewRepresentable {

    let recognizedlabel = UILabel()
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    // make UI View
    func makeUIView(context: Context) -> UILabel {
        var labelText: String! = nil
        
        labelText = Coordinator().recognizedTextFunc()
        
        self.recognizedlabel.text = labelText
        
        print("this is labelText -> \(labelText!)")

        return recognizedlabel
    }
    
    // update UI View
    func updateUIView(_ uiView: UILabel, context: Context) {
        // nothing to do
    }
    

    class Coordinator{
        // UI Image is argument.
        func recognizedTextFunc() -> String{
            
            var getTexts: [String] = []
            var text: String! = nil
            
            
            DispatchQueue.global().async {
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
                                
                                getTexts.append(elementText)
                                
                            }
                        }
                    }
                    
                    text = getTexts.joined(separator: ",")
                    print("debug \(text)")
                    
                }

            }
            // dataを取得するまで待ちます
            wait( { return text == nil } ) {
                // values got
                print("finish")
                //UIImage(data: imgData as Data)
            }
            return text
        }
        
        
        
        // wait method
        func wait(_ waitContinuation: @escaping (()->Bool), compleation: @escaping (()->Void)) {
            var wait = waitContinuation()
            // 0.01秒周期で待機条件をクリアするまで待ちます。
            let semaphore = DispatchSemaphore(value: 0)
            DispatchQueue.global().async {
                while wait {
                    DispatchQueue.main.async {
                        wait = waitContinuation()
                        semaphore.signal()
                    }
                    semaphore.wait()
                    Thread.sleep(forTimeInterval: 0.01)
                }
                // 待機条件をクリアしたので通過後の処理を行います。
                DispatchQueue.main.async {
                    compleation()
                }
            }
        }
    }
}
