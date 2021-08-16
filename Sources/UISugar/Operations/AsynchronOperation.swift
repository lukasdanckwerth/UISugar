//
//  AsynchronOperation.swift
//  
//
//  Created by Lukas Danckwerth on 31.10.20.
//

import Foundation

open class AsynchronOperation: Operation {
    private let lockQueue = DispatchQueue(label: "\(Bundle(for: AsynchronOperation.self)).\(UUID().uuidString)", attributes: .concurrent)
    
    open override var isAsynchronous: Bool {
        return true
    }
    
    private var _isExecuting: Bool = false
    open override private(set) var isExecuting: Bool {
        get {
            return lockQueue.sync { () -> Bool in
                return _isExecuting
            }
        }
        set {
            willChangeValue(forKey: "isExecuting")
            lockQueue.sync(flags: [.barrier]) {
                _isExecuting = newValue
            }
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var _isFinished: Bool = false
    open override private(set) var isFinished: Bool {
        get {
            return lockQueue.sync { () -> Bool in
                return _isFinished
            }
        }
        set {
            willChangeValue(forKey: "isFinished")
            lockQueue.sync(flags: [.barrier]) {
                _isFinished = newValue
            }
            didChangeValue(forKey: "isFinished")
        }
    }
    
    open override func start() {
        print("Starting")
        guard !isCancelled else {
            finish()
            return
        }
        
        isFinished = false
        isExecuting = true
        main()
    }
    
    open override func main() {
        fatalError("Subclasses must implement `main` without overriding super.")
    }
    
    open func finish() {
        isExecuting = false
        isFinished = true
    }
}
