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

public class RowModel: NSObject {}

public struct Settings {
  public var columns: [ColumnModel]
  /// Column Header height
  public var headerRowHeight: CGFloat
  /// Row  height
  public var contentRowHeight: CGFloat
  /// Row  height
  public var stickyHeader: Bool
  /// Row  height
  public var stickyColumn: Bool

  public init(columns: [ColumnModel], headerRowHeight: CGFloat, contentRowHeight: CGFloat, stickyHeader: Bool, stickyColumn: Bool) {
    self.columns = columns
    self.headerRowHeight = headerRowHeight
    self.contentRowHeight = contentRowHeight
    self.stickyHeader = stickyHeader
    self.stickyColumn = stickyColumn
  }
}
