//
//  ViewController.swift
//  Recognize_Text
//
//  Created by 神村亮佑 on 2020/09/03.
//  Copyright © 2020 神村亮佑. All rights reserved.
////
//
//import Foundation
//import Firebase
//import SwiftUI
//import Dispatch
//
//var isfinished : Bool = false
//
//final class RecognizedView : UIViewRepresentable {
//
//    let recognizedlabel = UILabel()
//
//    //var isfinished : Bool = false
//
//
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator()
//    }
//
//    // make UI View
//    func makeUIView(context: Context) -> UILabel {
//        var labelText : String
//
//        labelText = Coordinator().recognizedTextFunc(text: "Now Load", is: isfinished)
//
//        self.recognizedlabel.text = labelText
//
//        print("this is labelText -> \(labelText)")
//
//
//        return recognizedlabel
//    }
//
//    // update UI View
//    func updateUIView(_ uiView: UILabel, context: Context) {
//
//        print("update UI")
//        // nothing to do
//        if isfinished{
//            self.recognizedlabel.text = Coordinator().recognizedTextFunc(text: "Now Loaaaaading!", is: isfinished)
//
//        }
//        print("this is update text")
//    }
//    class Coordinator {
//        // UI Image is argument.
//        func recognizedTextFunc(text: String, is: Bool) -> String{
//
//            var getTexts: [String] = []
//            var textlines : String = ""
//
//
//            let vision = Vision.vision()
//
//            let options = VisionCloudTextRecognizerOptions()
//            options.languageHints = ["en", "ja"]
//            let textRecognizer = vision.cloudTextRecognizer(options: options)
//
//            let visionImage = VisionImage(image: UIImage(named: "logo")!)
//
//            textRecognizer.process(visionImage) { result, error in
//                guard error == nil, let result = result else {
//                    // ...
//                    return
//                }
//
//                let resultText = result.text
//                for block in result.blocks {
//                    let blockText = block.text
//                    let blockConfidence = block.confidence
//                    let blockLanguages = block.recognizedLanguages
//                    let blockCornerPoints = block.cornerPoints
//                    let blockFrame = block.frame
//                    for line in block.lines {
//                        let lineText = line.text
//                        let lineConfidence = line.confidence
//                        let lineLanguages = line.recognizedLanguages
//                        let lineCornerPoints = line.cornerPoints
//                        let lineFrame = line.frame
//                        for element in line.elements {
//                            let elementText = element.text
//                            let elementConfidence = element.confidence
//                            let elementLanguages = element.recognizedLanguages
//                            let elementCornerPoints = element.cornerPoints
//                            let elementFrame = element.frame
//
//                            //self.recognizedText.wrappedValue = elementText
//                            //self.text = elementText
//                            print("debug \(elementText)")
//
//                            getTexts.append(elementText)
//
//                        }
//                    }
//                }
//
//                textlines = getTexts.joined(separator: ",")
//                print("debug \(textlines)")
//
//            }
//
//            let text = textlines
//            isfinished = true
//            return text
//        }
//    }
//}
