//
//  ExtensionNumberFormatter.swift
//  UltraExpert-Go
//
//  Created by Lukas Danckwerth on 03.05.18.
//  Copyright © 2018 WinValue. All rights reserved.
//

import Foundation

/// Extends the `NumberFormatter` about some class variables for formatting currency, milage...
extension NumberFormatter {
   
   /// Number formatter for integer (whole number) currency values.
   ///
   /// e.g. `123 €` or `99 €`
   static var integerCurrency: NumberFormatter = {
      let f = NumberFormatter()
      f.locale = Locale.current
      f.numberStyle = .currency
      f.currencyCode = "EUR"
      f.currencySymbol = "€"
      f.maximumFractionDigits = 0
      return f
   }()
   
   /// Number formatter for decimal currency values with two fraction digits.
   ///
   /// e.g. `123,00 €` or `99,95 €`
   static var fractionCurrency: NumberFormatter = {
      let f = NumberFormatter()
      f.locale = Locale.current
      f.numberStyle = .currency
      f.roundingMode = .halfUp
      f.currencyCode = "EUR"
      f.currencySymbol = "€"
      f.maximumFractionDigits = 2
      return f
   }()
   
   /// Number formatter for integer values.
   ///
   /// e.g. `1.000` or `999.999`
   static var integer: NumberFormatter = {
      let f = NumberFormatter()
      f.locale = Locale.current
      f.numberStyle = .decimal
      f.maximumFractionDigits = 2
      return f
   }()
   
   /// Number formatter for decimal values with two fraction digits.
   ///
   /// e.g. `1.000,00` or `999.999,00`
   static var decimal: NumberFormatter = {
      let f = NumberFormatter()
      f.locale = Locale.current
      f.numberStyle = .decimal
      f.maximumFractionDigits = 2
      return f
   }()
   
   /// Number formatter for decimal values with two fraction digits.
   ///
   /// e.g. `1.000,00` or `999.999,00`
   static var mercantile: NumberFormatter = {
      let f = NumberFormatter()
      f.locale = Locale.current
      f.usesGroupingSeparator = false
      f.numberStyle = .decimal
      f.roundingMode = .halfUp
      f.minimumFractionDigits = 2
      f.maximumFractionDigits = 2
      return f
   }()
   
   /// Number formatter for decimal values with two fraction digits.
   ///
   /// e.g. `1.000,00` or `999.999,00`
   
   
   /// Returns the formatted version of the given currency value.
   ///
   /// - parameter integerCurrency:  The currency value to format.
   /// - parameter withSymbol:       A Boolean value indication whether to add a currency symbol.
   /// - parameter emptyValue:       A `String` to return if given value `currency` is `nil`.
   ///
   /// - returns:  A `String` in the form of `123 €` or `99 €`.
   public static func format(integerCurrency currency: Int?, withSymbol: Bool = false, emptyValue: String = EMPTY_STRING) -> String! {
      return currency != nil ? integerCurrency.string(from: NSNumber(value: currency!)) : EMPTY_STRING
   }
   
   public static func format(integerCurrency currency: Double?, withSymbol: Bool = false, emptyValue: String = EMPTY_STRING) -> String! {
      return currency != nil ? integerCurrency.string(from: NSNumber(value: currency!)) : EMPTY_STRING
   }
   
   /// Returns the formatted version of the given currency value.
   ///
   /// - parameter currency:    The currency value to format.
   /// - parameter emptyValue:  A `String` to return if given value `currency` is `nil`.
   ///
   /// - returns:  A `String` in the form of `123,00 €` or `99,95 €`.
   public static func format(currency: Double?, emptyValue: String = EMPTY_STRING) -> String! {
      return currency != nil ? fractionCurrency.string(from: NSNumber(value: currency!)) : EMPTY_STRING
   }
   
   /// Returns the formatted version of the given `Int` value.
   public static func formatInteger(_ value: Int?, alternative: String? = nil) -> String? {
      return value != nil ? integer.string(from: NSNumber(value: value!)) : alternative
   }
   
   /// Returns the formatted version of the given `Double` value.
   public static func formatInteger(_ value: Double?) -> String! {
      return value != nil ? integer.string(from: NSNumber(value: value!)) : EMPTY_STRING
   }
   
   /// Returns the formatted decimal version of the given `Int` value.
   public static func format(_ value: Int?) -> String! {
      return value != nil ? decimal.string(from: NSNumber(value: value!)) : EMPTY_STRING
   }
   
   /// Returns the formatted decimal version of the given `Double` value.
   public static func format(_ value: Double?) -> String! {
      return value != nil ? decimal.string(from: NSNumber(value: value!)) : EMPTY_STRING
   }
}
