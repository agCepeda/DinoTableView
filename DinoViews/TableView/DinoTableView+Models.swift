//
//  DinoTableView+Models.swift
//  DinoViews
//
//  Created by Agustin Cepeda on 24/02/23.
//

import Foundation
import CoreGraphics

public struct ColumnModel {
  /// Column width
  public var name: String
  /// Column width
  public var width: CGFloat

  public init(name: String, width: CGFloat) {
    self.name = name
    self.width = width
  }
}

public struct RowModel {
  public init() {}
}

public struct LayoutSettings {
  public var columns: [ColumnModel]
  /// Column Header height
  public var headerRowHeight: CGFloat
  /// Row  height
  public var contentRowHeight: CGFloat

  public init(columns: [ColumnModel], headerRowHeight: CGFloat, contentRowHeight: CGFloat) {
    self.columns = columns
    self.headerRowHeight = headerRowHeight
    self.contentRowHeight = contentRowHeight
  }
}
