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
    
    let size = CGSize(width: 180, height: 180)
    
    private let containerView = UIView()
    
    private(set) public lazy var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.prominent)
    private(set) public lazy var blurEffectView = UIVisualEffectView(effect: blurEffect)
    
    public final var contentView: UIView {
        blurEffectView.contentView
    }
    
    public var label = UILabel()
    public var activityView = UIActivityIndicatorView(style: .large)
    public var cancelButton = UIButton()
    
    private(set) public lazy var stackView = UIStackView(arrangedSubviews: [
        activityView,
        label
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
        
        label.textAlignment = .center
        label.numberOfLines = 0
                
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
