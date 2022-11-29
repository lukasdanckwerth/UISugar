//
//  UIImageViewController.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 09.12.17.
//
#if os(iOS)
import UIKit

class UIImageViewController: UIViewController {
   
   
   // MARK: - Properties
   
   /// The underlying image view of this image view controller.
   open lazy var imageView = UIImageView()
   
   
   // MARK: - Initialization
   
   /// Initialization with given image.
   init(image: UIImage?) {
      super.init(nibName: nil, bundle: nil)
      imageView.image = image
   }
   
   /// Initialization from storyboard.
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
   }
   
   /// Initialization from given image name.
   convenience init(imageName name: String?) {
      self.init(image: name != nil ? UIImage(named: name!) : nil)
   }
   
   
   // MARK: - Override UIViewController
   
   override func loadView() {
      imageView.alpha = 0
      imageView.contentMode = .scaleAspectFill
      view = imageView
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      alphaAnimation(to: 1)
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      alphaAnimation(to: 0)
   }
   
   private func alphaAnimation(to alpha: CGFloat) {
      
      guard imageView.alpha != alpha else { return }
      
      UIView.animate(withDuration: UISugar.fadeDuration, animations: {
         self.imageView.alpha = alpha
      })
   }
}
#endif
