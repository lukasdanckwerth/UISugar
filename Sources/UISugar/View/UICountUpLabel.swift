//
//  UICountUpLabel.swift
//  RestwertBoerse
//
//  Created by Lukas Danckwerth on 01.08.17.
//
#if os(iOS)
import UIKit

/** Label that displays a number. When the number is set it 'animates' a count up to the number.
 - author: Lukas Danckwerth */
class UICountUpLabel: UILabel {
  
  
  
  /// Constant of displayed numbers below the actual number
  private static let numberOfCountUps = 10
  /// Constant for the time intervall wich is added to the time for next timer execution.
  private static let timeIntervallIntervall = 0.02
  
  
  
  /// Reference to the used timer.
  private var timer: Timer?
  /// Reference to the time intervall when the timer is executed next.
  private var nextTimerExecutionIntervall = 0.02
  
  /// Number for buffering.
  private var tempNumber: Int?
  /// Value when increased.
  private var step: Int = 1 {
    didSet {
      if step <= 0 {
        step = 1
      }
    }
  }
  
  
  /// The displayed number. When set a count up from 10 numbers below this number is started.
  public var number: Int? {
    didSet {
      if let number = number {
        if let oldValue = oldValue {
          if number != oldValue {
            // We have an old value and a new one here so we need to check whether the new value is higher or lower the old one and start
            // the 'animation' depending on that.
            nextTimerExecutionIntervall = UICountUpLabel.timeIntervallIntervall
            tempNumber = oldValue
            if oldValue > number {
              step = Int((oldValue - number) / UICountUpLabel.numberOfCountUps)
              countDown()
            } else {
              step = Int((number - oldValue) / UICountUpLabel.numberOfCountUps)
              countUp()
            }
          }
        } else {
          step = 1
          nextTimerExecutionIntervall = UICountUpLabel.timeIntervallIntervall
          if number > UICountUpLabel.numberOfCountUps {
            tempNumber = number - UICountUpLabel.numberOfCountUps
          } else {
            tempNumber = 0
          }
          countUp()
        }
      } else {
        // Number is nil so lets set the text to nil also.
        text = nil
      }
    }
  }
  
  
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    text = "0"
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    text = "0"
  }
  
  
  
  // MARK: - Functions
  
  @objc private func countDown() {
    
    if let tempNumber = tempNumber {
      if tempNumber <= number! {
        
        text = "+ \(number ?? 0)"
        timer?.invalidate()
        timer = nil
        self.tempNumber = nil
        
      } else {
        
        text = "+ \(tempNumber)"
        self.tempNumber! -= step
        nextTimerExecutionIntervall += UICountUpLabel.timeIntervallIntervall
        timer = Timer.scheduledTimer(timeInterval: nextTimerExecutionIntervall, target: self,
                                     selector: #selector(self.countDown), userInfo: nil, repeats: false)
      }
    }
  }
  
  @objc private func countUp() {
    
    if let tempNumber = tempNumber {
      if tempNumber >= number! {
        
        text = "+ \(number ?? 0)"
        timer?.invalidate()
        timer = nil
        self.tempNumber = nil
        
      } else {
        
        text = "+ \(tempNumber)"
        self.tempNumber! += step
        nextTimerExecutionIntervall += UICountUpLabel.timeIntervallIntervall
        timer = Timer.scheduledTimer(timeInterval: nextTimerExecutionIntervall, target: self,
                                     selector: #selector(self.countUp), userInfo: nil, repeats: false)
      }
    }
  }
}
#endif
