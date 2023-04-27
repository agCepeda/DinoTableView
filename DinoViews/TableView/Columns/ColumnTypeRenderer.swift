//
// Created by Agustin Cepeda on 22/03/23.
//

import Foundation

public protocol ColumnTypeRenderer: AnyObject {
  func render(_ value: NSObject) -> String
}

public class TextRenderer: ColumnTypeRenderer {
  public func render(_ value: NSObject) -> String {
    return "\(value)"
  }
}

public class MoneyRenderer: ColumnTypeRenderer {

  private let formatter: NumberFormatter

  public init(decimals: Int? = nil, currency: String) {
    formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.groupingSize = 3
    formatter.currencyCode = currency

    if let decimals = decimals {
      formatter.maximumFractionDigits = decimals
      formatter.minimumFractionDigits = decimals
    }
  }

  public func render(_ value: NSObject) -> String {
    switch value {
    case let number as NSNumber:
      return formatter.string(from: number) ?? "??"
    default:
      return formatter.string(from: 0.0) ?? "!!"
    }
  }
}