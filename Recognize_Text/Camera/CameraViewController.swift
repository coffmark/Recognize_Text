//
//  CameraViewController.swift
//  Recognize_Text
//
//  Created by 神村亮佑 on 2020/09/02.
//  Copyright © 2020 神村亮佑. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import Firebase



final class RecognizedTextViewController: UIViewController {
    
    @Binding var recognizedText: String
    
    init(){
        self.recognizedText = recognizedText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeLabel(text: self.$recognizedText)
    }
    
    func makeLabel() {// 一番上のlabelを作る
        
        var text: String
        
        let copyLabel = UILabel(frame: CGRect(x: 101, y: 20, width: 100, height: 20))
        // labelの大きさ、座標を指定してる
        
        copyLabel.text = "\(self.text)"
        // 文字を変更
        
        copyLabel.backgroundColor = UIColor.blue
        //　背景色を指定
        
        copyLabel.font = UIFont.systemFont(ofSize: 17)
        // フォントの大きさを指定
        
        copyLabel.textColor = UIColor.white
        // 文字の色を指定
        
        copyLabel.sizeToFit()
        // 文字数に合わせてlabelの大きさを変更（サイズが文字にフィットする）
        
        self.view.addSubview(copyLabel)
        // 実際にviewに目に見える形でlabelが出現する
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}




extension RecognizedTextViewController : UIViewControllerRepresentable{
    
    public typealias UIViewControllerType = RecognizedTextViewController
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedText: $recognizedText)
    }
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<RecognizedTextViewController>) -> RecognizedTextViewController {
        
    }
    
    func updateUIViewController(_ uiViewController: RecognizedTextViewController
        , context: UIViewControllerREpresentableContext<RecognizedTextViewController>) {
        //
    }
    
    // TODO : - 本当にVisionImageであってる？
    class Coordinator {
    
        var imageName = "logo"
        
        func recognizeTextInCloud(image: UIImage?) {
            guard let uiImage = UIImage(named: "logo") else {return}
            
            let vision = Vision.vision()
            
            // Or, to provide language hints to assist with language detection:
            // See https://cloud.google.com/vision/docs/languages for supported languages
            let options = VisionCloudTextRecognizerOptions()
            
            options.languageHints = ["en", "ja"]
            let textRecognizer = vision.cloudTextRecognizer(options: options)
            
            
            let visionImage = VisionImage(image: uiImage)
            
            textRecognizer.process(visionImage) { result, error in
                guard error == nil, let result = result else {
                    // ...
                    return
                }
                
                // Text recognition results
                guard let resultText = result.text else { return }
                // `VisionText` is made of `VisionTextBlock`s...
                for block in resultText.blocks {
                    // ...and each `VisionTextBlock` has
                    // text, confidence level, list of recognized languages and corner points and frame in which the text was detected...
                    let blockText = block.text
                    let blockConfidence = block.confidence
                    let blockLanguages = block.recognizedLanguages
                    let blockCornerPoints = block.cornerPoints
                    let blockFrame = block.frame
                    // ...and each `VisionTextBlock` is made of `VisionTextLine`s...
                    for line in block.lines {
                        // ...which again have text, confidence level, list of recognized languages, corner points and the frame in which the text was detected...
                        let lineText = line.text
                        let lineConfidence = line.confidence
                        let lineLanguages = line.recognizedLanguages
                        let lineCornerPoints = line.cornerPoints
                        let lineFrame = line.frame
                        // ... and each `VisionTextLine` is further made of `VisionTextElement`s...
                        for element in line.elements {
                            // ...and each `VisionTextElement` has
                            // text, confidence level, list of recognized languages, corner points and the frame in which the text was detected.
                            let elementText = element.text
                            let elementConfidence = element.confidence
                            let elementLanguages = element.recognizedLanguages
                            let elementCornerPoints = element.cornerPoints
                            let elementFrame = element.frame
                            
                            return elementText
                        }
                    }
                }
            }
        }
        
    }
}

