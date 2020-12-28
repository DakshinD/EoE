//
//  ImageCropper.swift
//  EoE
//
//  Created by Dakshin Devanand on 12/26/20.
//

import SwiftUI
import UIKit
import CropViewController

struct ImageCropper: UIViewControllerRepresentable{
  @Binding var image: UIImage?
  @Binding var visible: Bool
  var done: (UIImage) -> Void
  
  class Coordinator: NSObject, CropViewControllerDelegate{
    let parent: ImageCropper
    
    init(_ parent: ImageCropper){
      self.parent = parent
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        withAnimation{
            self.parent.visible = false
        }
      }
      parent.done(image)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
      withAnimation{
        parent.visible = false
      }
    }
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
  
  func makeUIViewController(context: Context) -> some UIViewController {
    let img = self.image ?? UIImage()
    let cropViewController = CropViewController(image: img)
    cropViewController.delegate = context.coordinator
    return cropViewController
  }
}


