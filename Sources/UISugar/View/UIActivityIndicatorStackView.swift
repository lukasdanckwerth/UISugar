//
//  UIActivityIndicatorStackView.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 12.12.17.
//

#if os(iOS)
import UIKit.UIStackView
import UIKit.UIActivityIndicatorView
import UIKit.UILabel

/// A vertical stack view containing a `UIActivityIndicatorView` (top) and a `UILabel` (bottom).  Activitay indicator
/// view is initially visible and animates.  The label has an initial text of the localized word of `"Load"`.
///
@available(iOS 13.0, *)
public class UIActivityIndicatorStackView: UIStackView {
    
    // MARK: - Properties
    
    /// The activity indicator view.  Default style is `.gray`.
    ///
    #if swift(>=4.2)
    public let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    #else
    public let activityIndicator = UIActivityIndicatorView(style: .gray)
    #endif
    
    /// The label displays the loading text.
    ///
    public let label = UILabel()
    
    /// A Boolean value indicating whether to capitalize the displayed text.  Default is `true`.
    ///
    var capitalizeText: Bool = true
    
    /// The current text that is displayed by this activity indicator stack view.
    ///
    /// NOTE: Label will be hidden when text is `nil`.
    ///
    var text: String? {
        didSet { updateLabel() }
    }
    
    // MARK: - Initialization
    
    /// Default initialization from given rectangle.
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    /// Default initialization.
    init() {
        self.init(arrangedSubviews: [])
        configure()
    }
    
    /// Default initialization in storyboards.
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    // MARK: - Auxiliary Functions
    
    /// Configures and sets up the view.
    ///
    private func configure() {
        
        addArrangedSubview(activityIndicator)
        addArrangedSubview(label)
        
        // configure stack view
        axis = .vertical
        spacing = 4
        alignment = .center
        distribution = .fill
        
        // configure label
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        
        // configure activity indicator view
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        // initially set label text
        text = NSLocalizedString("Load", comment: "")
    }
    
    /// Updates the label and text appereance dependand on text.  Label will be hidden if text is `nil`.  Text will be capitalized if property `capitalizeText` is set to `true`.
    ///
    private func updateLabel() {
        label.isHidden = text == nil
        label.text = capitalizeText ? text?.uppercased() : text
    }
}
#endif
