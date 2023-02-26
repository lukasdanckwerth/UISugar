//
//  UIImageViewController.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 09.12.17.
//
#if os(iOS)
import UIKit

open class UIImageViewController: UIViewController {
    
    public static let fadeInDuration: TimeInterval = 0.5
    public static let fadeOutDuration: TimeInterval = 0.3
    
    
    // MARK: - Properties
    
    /// The underlying image view of this image view controller.
    ///
    open lazy var imageView = UIImageView()
    
    
    // MARK: - Initialization
    
    /// Initialization with given image.
    ///
    public init(image: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
        setup()
    }
    
    /// Initialization from storyboard.
    ///
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    /// Initialization from given image name.
    ///
    convenience public init(imageName name: String?) {
        self.init(image: name != nil ? UIImage(named: name!) : nil)
    }
    
    private func setup() {
        imageView.alpha = 0
        imageView.contentMode = .scaleAspectFill
    }
    
    
    // MARK: - Override UIViewController
    
    open override func loadView() {
        view = UIView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        imageView.bind(to: view)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if animated {
            alphaAnimation(to: 1, duration: UIImageViewController.fadeInDuration)
        } else {
            imageView.alpha = 1
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if animated {
            alphaAnimation(to: 0, duration: UIImageViewController.fadeOutDuration)
        } else {
            imageView.alpha = 0
        }
    }
    
    private func alphaAnimation(to alpha: CGFloat, duration: TimeInterval) {
        guard imageView.alpha != alpha else { return }
        
        UIView.animate(withDuration: duration, animations: {
            self.imageView.alpha = alpha
        })
    }
}
#endif
