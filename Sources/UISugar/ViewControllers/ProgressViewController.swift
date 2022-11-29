//
//  ProgressViewController.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 22.03.18.
//  Copyright © 2018 Lukas Danckwerth. All rights reserved.
//

#if os(iOS)
import UIKit

public class ProgressViewController: UIViewController {
   
   
   // MARK: - Properties
   
   /// Progress indicator view.
   lazy var progressView: UIProgressView = {
      let progressView = UIProgressView()
      progressView.alpha = 0
      return progressView
   }()
   
   /// Label to display the progress or a message.
   lazy var label: UILabel = {
      let label = UILabel()
      label.contentMode = .center
      label.textColor = .lightGray
      label.font = .systemFont(ofSize: 14)
      label.alpha = 0
      return label
   }()
   
   /// The fraction to display in the progress view and in the label.
   var progress: Float? {
      didSet { progressDidChange() }
   }
   
   private func progressDidChange() {
      
      /// Set text of label dependant on progress value.
      if let progress = progress, progress >= 0, progress <= 1 {
         label.text = "\(String(format: "%.2f", 100.0 * progress)) %"
         progressView.progress = progress
      } else {
         label.text = nil
         progressView.progress = 0
      }
      
      view.setNeedsLayout()
   }
   
   // MARK: - Override UIViewController
   
    public override func viewDidLoad() {
      super.viewDidLoad()
      
      view.addSubview(progressView)
      view.addSubview(label)
      
      progressView.translatesAutoresizingMaskIntoConstraints = false
      label.translatesAutoresizingMaskIntoConstraints = false
      
      // Initially set a progress of 0 ...
      progress = 0
   }
   
   public override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      // We use a 0.5 second delay to not show an progress view in case the data loads very quickly.
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
         UIView.animate(withDuration: 0.5, animations: {
            self?.progressView.alpha = 1
            self?.label.alpha = 1
         })
      }
   }
   
   #if swift(>=4.2)
   public override func didMove(toParent parent: UIViewController?) {
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
   
   
   public override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      
      let centerX = view.bounds.size.width / 2
      let centerY = view.bounds.size.height / 2
      
      progressView.frame.size.width = 200
      progressView.center = CGPoint(x: centerX, y: centerY - 4 - progressView.frame.size.height)
      
      label.sizeToFit()
      label.center = CGPoint(x: centerX, y: centerY + 16)
   }
}
#endif
