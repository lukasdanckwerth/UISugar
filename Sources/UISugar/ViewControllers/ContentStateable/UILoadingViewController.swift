//
//  UILoadingViewController.swift
//  RestwertBoerse
//
//  Created by Lukas Danckwerth on 14.03.18.
//  Copyright © 2018 Lukas Danckwerth. All rights reserved.
//
#if os(iOS)
import UIKit

@available(iOS 13.0, *)
public class UIActivityPanel: UIVisualEffectView {
    
    
    // MARK: - Properties
    
    
    
    public let blurEffect = UIBlurEffect(style: .light)
    
    public let vibrancyEffect: UIVibrancyEffect
    
    
    
    public let vibrancyEffectView: UIVisualEffectView
    
    public let stackView = UIStackView()
    
    /// The activity indicator view.  Default style is `.gray`.
    #if swift(>=4.2)
    public let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    #else
    public let activityIndicator = UIActivityIndicatorView(style: .gray)
    #endif
    
    
    /// The label displays the loading text.
    public let label = UILabel()
    
    /// The label displays details text.
    public let detailLabel = UILabel()
    
    
    
    // MARK: - Initialize
    
    init() {
        
        self.vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        self.vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        
        super.init(effect: blurEffect)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Auxiliary Functions
    
    /// Configures and sets up the view.
    private func configure() {
        
        contentView.addSubview(vibrancyEffectView)
        vibrancyEffectView.bindFrameToSuperviewBounds()
        
        vibrancyEffectView.contentView.addSubview(stackView)
        stackView.bindFrameToSuperviewBounds(insets: .new(40))
        
        stackView.addArrangedSubview(activityIndicator)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(detailLabel)
        
        
        // configure stack view
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        
        
        // configure activity indicator view
        #if swift(>=4.2)
        activityIndicator.style = .whiteLarge
        #else
        activityIndicator.style = .whiteLarge
        #endif
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        
        // configure label
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = NSLocalizedString("Some Loading Text", comment: "")
        
        
        // configure detail label
        detailLabel.font = UIFont.preferredFont(forTextStyle: .body)
        detailLabel.textAlignment = .center
        detailLabel.numberOfLines = 0
        detailLabel.text = NSLocalizedString("Some details text for the current task", comment: "")
        
        
        //      contentView.clipsToBounds = false
        //      contentView.layer.cornerRadius = UISugar.defaultCornerRadius
        //      contentView.layer.masksToBounds = true
        //      contentView.layer.shadowColor = UIColor.red.cgColor
        //      contentView.layer.drawShadow()
        
        clipsToBounds = false
        
        layer.cornerRadius = UISugar.defaultCornerRadius
        layer.masksToBounds = true
        
    }
    
    /// Updates the label and text appereance dependand on text.  Label will be hidden if text is `nil`.  Text will be
    /// capitalized if property `capitalizeText` is set to `true`.
    //   private func updateLabel() {
    //      label.isHidden = text == nil
    //      label.text = capitalizeText ? text?.uppercased() : text
    //   }
    
}

@available(iOS 13.0, *)
class UIBackgroundImageLoadingViewController: UIImageViewController {
    
    lazy var activityPanel = UIActivityPanel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.addSubview(activityPanel)
        activityPanel.centerInSuperview()
        
        imageView.contentMode = .scaleAspectFill
    }
}

@available(iOS 13.0, *)
class UILoadingViewController: UIViewController {
    
    /// The stack view wich contains the activity indicator and a label.
    @available(iOS 13.0, *)
    lazy var stackView = UIActivityIndicatorStackView()
    
    /// A Boolean value indicating whether the view is presented with a delay or instantly.  (Delay is `0.1` sec)
    var isDelayed = true
    
    
    
    // MARK: - Initialization
    
    /// Creates a new instance.
    ///
    /// - parameter message:    A message to be presented under the activity indicator.
    /// - parameter withDelay:  A Boolean value indicating whether to present the view instantly or after a delay.  (Delay is `0.1` sec)
    convenience init(message: String? = nil, withDelay delay: Bool = true) {
        self.init(nibName: nil, bundle: nil)
        stackView.text = message
        isDelayed = delay
    }
    
    
    
    // MARK: - Override UIViewController
    
    override func loadView() {
        view = UINotTappableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        stackView.isHidden = true
        stackView.capitalizeText = false
        stackView.alpha = 0
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        view.addConstraints([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // We use a 0.1 second delay to not show an activity indicator in case the data loads very quickly.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            UIView.animate(withDuration: UISugar.fadeDuration, animations: {
                self?.stackView.isHidden = false
                self?.stackView.alpha = 1
            })
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stackView.sizeToFit()
    }
    
    #if swift(>=4.2)
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        if let parentFrame = parent?.view.frame {
            view.frame = parentFrame
        }
    }
    #else
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        if let parentFrame = parent?.view.frame {
            view.frame = parentFrame
        }
    }
    #endif
}
#endif
