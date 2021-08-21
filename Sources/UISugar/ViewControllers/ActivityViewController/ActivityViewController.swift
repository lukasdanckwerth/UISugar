//
//  ActivityViewController.swift
//  
//
//  Created by Lukas Danckwerth on 20.08.21.
//

#if canImport(UIKit)
import UIKit

@available(iOS 13.0, *)
public class ActivityViewController: UIViewController {
    
    // ===---------------------------------------------------------------------------------------===
    //
    // MARK: - Properties
    
    let size = CGSize(width: 160, height: 160)
    
    private let containerView = UIView()
    lazy var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
    lazy var blurEffectView = UIVisualEffectView(effect: blurEffect)
    var contentView: UIView {
        blurEffectView.contentView
    }
    
    var label = UILabel()
    var activityView = UIActivityIndicatorView(style: .large)
    var cancelButton = UIButton()
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        activityView,
//        label
    ])
    
    // ===---------------------------------------------------------------------------------------===
    //
    // MARK: - Override `UIViewController`
    
    init(style: UIActivityIndicatorView.Style = .medium) {
        super.init(nibName: nil, bundle: nil)
        commonInitialization()
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInitialization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInitialization()
    }
    
    private func commonInitialization() {
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.text = "Some Title"
        label.textAlignment = .center
                
        activityView.startAnimating()
        
        containerView.layer.cornerRadius = 25
        containerView.layer.masksToBounds = true
        
        containerView.addSubview(blurEffectView)
        containerView.center(in: view)
        
        stackView.bind(to: contentView, insets: UIEdgeInsets(top: 40, left: 20, bottom: 40, right: 20))
        blurEffectView.bind(to: containerView)
        
        view.addSubview(containerView)
        view.addConstraints([
            containerView.heightAnchor.constraint(equalToConstant: size.height),
            containerView.widthAnchor.constraint(equalToConstant: size.width)
        ])
        
        blurEffectView.layer.cornerRadius = 15
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        blurEffectView.frame = containerView.frame
    }
    
    // ===---------------------------------------------------------------------------------------===
    //
    // MARK: - Actions
    
}
#endif
