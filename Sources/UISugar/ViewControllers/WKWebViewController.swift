//
//  WKWebViewController.swift
//  RestwertBoerse
//
//  Created by Lukas Danckwerth on 09.08.17.
//
//  NOTE: Contains code from https://developer.apple.com/documentation/webkit/wkwebview

#if os(iOS)
import UIKit
import WebKit
#if canImport(Alamofire)
import Alamofire
#endif

/// View controller that controls a web view that can be used to display a static web page or for displaying files ['txt', 'pdf'].
///
/// - author: Lukas Danckwerth
@available(iOS 13.0, *)
class WKWebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    
    // MARK: - Fields
    
    /// The web view this view controller controls
    var webView: WKWebView!
    
    /// Reference to a view controller showing download progress / loading state.
    private var loadingViewController: UILoadingViewController?
    
    /// Reference to a `ProgressViewController` presented when downloading.
    private var progressViewController: ProgressViewController?
    
    
    /// Boolean value indicating whether a button to toggle fullscreen is visible.
    var isShowFullscreenButton = false
    
    /// Thr url for a website to display in the web view. NOTE: Set this url before
    /// the viewDidLoad() function is called for proper working.
    var webURL: URL?
    
    /// Thr url for a file to display in the web view. NOTE: Set this url before
    /// the viewDidLoad() function is called for proper working.
    var fileURL: URL?
    
    /// Reference to the local file (when downloaded).
    var localFileURL: URL?
    
    #if canImport(Alamofire)
    /// Reference to the current running download request. (Optional, only used for file downloads)
    var currentDownloadRequest: DownloadRequest?
    #endif
    
    
    // MARK: - Initialization
    
    /// Initialization with given file `URL`.
    ///
    /// - parameter fileURL: The `URL` of the file to request.
    /// - parameter localFileURL: The `URL` of a possible cached local file.
    init(fileURL: URL, localFileURL: URL?) {
        self.fileURL = fileURL
        self.localFileURL = localFileURL
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Initialization with given web `URL`.
    ///
    /// - parameter webURL: The `URL` of the website to request.
    init(webUrl: URL) {
        self.webURL = webUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Initialization without arguments
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    /// Default initialization from storyboard. NOTE: Not Implemented.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Load view
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        
        if fileURL != nil {
            
            // To avoid line wrapping and make the content fit in the webview we need some JavaScript which manipulates the style information
            // of the `pre` tag in which the text is. The style info word-wrap needs to be set to normal and the white-space info should be
            // removed. (Also we only give a URL of a textfile to the WKWebView it renders it to html and enclose the text in a pre tag)
            let javaScript = """
      document.getElementsByTagName('pre')[0].style.wordWrap = "normal";
      document.getElementsByTagName('pre')[0].style.whiteSpace = null;
      """
            let userScript = WKUserScript(source: javaScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
            let userContentController = WKUserContentController()
            userContentController.addUserScript(userScript)
            webConfiguration.userContentController = userContentController
        }
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.layer.masksToBounds = false
        
        view = webView
    }
    
    
    
    // MARK: - Additional view setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if webURL != nil {
            
            /*****************************************************************************************************************
             *
             * Web URL
             *****************************************************************************************************************/
            loadingViewController = UILoadingViewController()
            add(loadingViewController!)
            
            webView.load(URLRequest(url: webURL!))
            
        } else if fileURL != nil {
            
            /*****************************************************************************************************************
             *
             * File URL
             *****************************************************************************************************************/
            
            if let localFileURL = localFileURL, FileManager.default.fileExists(atPath: localFileURL.path) {
                
                // Use cached local file ...
                
                NSLog("Use cached file \(localFileURL)")
                requestFileUrl(url: localFileURL)
                
            } else {
                
                // requestFileUrl(url: fileURL!)
                
                // Download file ...
                
                //                let destination = WVAMAttachementDestination(for: fileURL!)
                //
                //                progressViewController = ProgressViewController()
                //                add(progressViewController!)
                //
                //                currentDownloadRequest = Alamofire.download(fileURL!, to: destination)
                //                    .downloadProgress {
                //
                //                        self.progressViewController?.progress = Float($0.fractionCompleted)
                //
                //                    }.responseData { response in
                //
                //                        if response.error == nil, let destinationURL = response.destinationURL {
                //                            self.requestFileUrl(url: destinationURL)
                //                        } else {
                //                            warning("Couldn't laod file from \(String(describing: self.fileURL))")
                //                        }
                //                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadingViewController?.view.frame = view.frame
        progressViewController?.view.frame = view.frame
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = title
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        guard isShowFullscreenButton else { return }
        
        if self.traitCollection.horizontalSizeClass == .regular {
            let buttonItem = navigationController?.splitViewController?.displayModeButtonItem
            navigationItem.setRightBarButton(buttonItem, animated: true)
        } else {
            navigationItem.setRightBarButton(nil, animated: true)
        }
    }
    
    #if swift(>=4.2)
    override func willMove(toParent parent: UIViewController?) {
        // If this view controller is dismissed the parent controller will bil nil.
        // In case there is a download request running stop it.
        guard parent == nil else { return }
        
        // Stop any existing loading request.
        webView.stopLoading()
        
        #if canImport(Alamofire)
        // Stop any existing downloading request.
        currentDownloadRequest?.cancel()
        #endif
        
        // In case this `WKWebViewController` is presented in a splitview controller show both master and details view when dismissing this controller.
        guard let splitVC = splitViewController else { return }
        UIView.animate(withDuration: 0.3, animations: {
            splitVC.preferredDisplayMode = .allVisible
        })
    }
    #else
    override func willMove(toParent parent: UIViewController?) {
        // If this view controller is dismissed the parent controller will bil nil.
        // In case there is a download request running stop it.
        guard parent == nil else { return }
        
        // Stop any existing loading request.
        webView.stopLoading()
        
        #if canImport(Alamofire)
        // Stop any existing downloading request.
        currentDownloadRequest?.cancel()
        #endif
        
        // In case this `WKWebViewController` is presented in a splitview controller show both master and details view when dismissing this controller.
        guard let splitVC = splitViewController else { return }
        UIView.animate(withDuration: 0.3, animations: {
            splitVC.preferredDisplayMode = .allVisible
        })
    }
    #endif
    
    
    
    
    // MARK: - Implement WKNavigationDelegate
    
    // Triggered for finished loading. Remove the view for displaying status.
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingViewController?.remove()
        progressViewController?.remove()
    }
    
    
    // MARK: - Private functions
    
    private func requestFileUrl(url: URL?) {
        if let url = url {
            localFileURL = url
            webView.loadFileURL(url, allowingReadAccessTo: url)
            
            if ["txt", "pdf"].contains((localFileURL?.pathExtension)!) {
                // Show a share button in the right of the navigation bar.
                let barButtonShare = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(barButtonShareAction))
                navigationItem.setRightBarButton(barButtonShare, animated: true)
            }
        }
    }
    
    @objc func barButtonShareAction() {
        if let localFileURL = localFileURL, let title = self.title {
            
            var activityItems: Array<Any>!
            switch localFileURL.pathExtension {
            case "txt":
                do {
                    let stringContent = try String(contentsOf: localFileURL, encoding: .utf8)
                    activityItems = [title, stringContent]
                } catch { NSLog("Can't read text file at URL: \(localFileURL)") }
            case "pdf":
                do {
                    let fileData = try Data(contentsOf: localFileURL)
                    activityItems = [title, fileData]
                } catch { NSLog("Can't read PDF data of URL: \(localFileURL)") }
            default:
                activityItems = nil
            }
            
            if activityItems != nil {
                let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
                present(activityController, animated: true, completion: nil)
            }
        }
    }
}
#endif
