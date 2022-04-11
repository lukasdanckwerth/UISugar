//
//  PDFViewController.swift
//  UISugar
//
//  Created by Lukas Danckwerth on 10.12.18.
//  Copyright © 2018 Lukas Danckwerth. All rights reserved.
//
#if os(iOS)
import UIKit
import PDFKit


// MARK: - PDFViewController

@available(iOS 11.0, *)
class PDFViewController: UIViewController {
    
    
    // MARK: - Properties
    
    /// The underlying PDF view.
    lazy var pdfView = PDFView()
    
    
    /// Button item to present an `UIActivityViewController` to share the presented assignment.
    lazy var shareButtonItem = UIBarButtonItem(
        barButtonSystemItem: .action,
        target: self,
        action: #selector(shareAction(sender:))
    )
    
    
    // MARK: - Auxiliary properties
    
    /// Returns the `URL` of the presented PDF document or `nil`.
    var documentURL: URL? {
        return pdfView.document?.documentURL
    }
    
    /// Returns a Boolean value indicating wheather the presented document is available locally.
    var documentExists: Bool {
        guard let documentURL = self.documentURL else { return false }
        return FileManager.default.fileExists(atPath: documentURL.path)
    }
    
    /// Returns the file name of the presented PDF document or `nil`.
    var documentName: String? {
        return documentURL?.deletingPathExtension().lastPathComponent
    }
    
    
    // MARK: - Initialization
    
    /// Default initialization.
    init(documentURL: URL?) {
        super.init(nibName: nil, bundle: nil)
        
        if let documentURL = documentURL {
            pdfView.document = PDFDocument(url: documentURL)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Override UIViewController
    
    /// Loads the PDF view.
    override func loadView() {
        view = UIView()
        
        view.backgroundColor = .groupTableViewBackground
        view.addSubview(pdfView)
        
        pdfView.bindFrameToSuperviewBounds()
        pdfView.backgroundColor = .groupTableViewBackground
        pdfView.pageBreakMargins.top += 44 // +44 for second navigation bar.
        pdfView.pageBreakMargins.bottom += 88
        pdfView.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // items only enabled if the pdf view controller contains a valid pdf
        shareButtonItem.isEnabled = documentExists
        
        // configure navigation item
        title = documentName != nil ? (documentName! + ".pdf") : nil
        navigationItem.rightBarButtonItems = [dismissDoneButtonItem]
        navigationItem.leftBarButtonItems = [shareButtonItem]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pdfView.layoutDocumentView()
        
        // smooth fade in animation of PDF view
        UIView.animate(withDuration: 0.5, animations: {
            self.pdfView.alpha = 1
        })
    }
    
    
    // MARK: - Actions
    
    /// Triggered by the share button item.
    @objc func shareAction(sender: UIBarButtonItem?) {
        
        guard let documentURL = self.pdfView.document?.documentURL else {
            return
        }
        
        var fileData: Data? = nil
        
        do {
            fileData = try Data(contentsOf: documentURL)
        } catch let error {
            NSLog("\(self): Can't create data from document URL '\(documentURL.path)'.  \(error)")
        }
        
        if let fileData = fileData {
            let title = self.title ?? ""
            let activityItems: Array<Any>! = [title, fileData]
            
            let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            activityController.popoverPresentationController?.barButtonItem = sender
            
            present(activityController, animated: true, completion: nil)
        }
    }
}
#endif
