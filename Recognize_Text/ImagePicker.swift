//
//  ImagePicker.swift
//  Recognize_Text
//
//  Created by 神村亮佑 on 2020/09/09.
//  Copyright © 2020 神村亮佑. All rights reserved.
//

import SwiftUI


struct ImagePicker: UIViewControllerRepresentable{
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        let parent: ImagePicker
        
        init(_ parent: ImagePicker){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as?
            UIImage{
                    parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
            print("get image")
        }
        
        
    }
    
    
    @Environment (\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    
    func makeCoordinator() -> Coordinator{
        Coordinator(self)
    }
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    
        
    }
    
    
}
