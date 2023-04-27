//
// Created by Agustin Cepeda on 22/03/23.
//

import CoreGraphics

public struct ColumnModel {

  /// Column width
  public var name: String
  /// Column width
  public var width: CGFloat
  /// Column width
  public var attributeKey: String

  public init(name: String, width: CGFloat, attributeKey: String = "") {
    self.name = name
    self.width = width
    self.attributeKey = attributeKey
  }
}
