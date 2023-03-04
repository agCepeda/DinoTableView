//
//  DinoTableView+Models.swift
//  DinoViews
//
//  Created by Agustin Cepeda on 24/02/23.
//

import Foundation
import CoreGraphics

public protocol ColumnModel where Self: Codable {}

public protocol RowModel where Self: Codable {
  
}

public struct LayoutSettings {
  /// Column Header height
  public var columnHeaderHeight: CGFloat
  /// Column  widths
  public var columnWidths: [CGFloat]
  /// Row  height
  public var rowHeight: CGFloat
}
