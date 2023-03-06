//
// Created by Agustin Cepeda on 02/03/23.
//

import CoreGraphics

struct CalculateBounds : Equatable {
  var left: Int
  var top: Int
  var right: Int
  var bottom: Int
}

protocol CellPositionCalculator {
  func calculateRow(yPosition: CGFloat, rowIndex: Int) -> [CGRect]
  func calculate() -> [[CGRect]]
  func contentSize() -> CGSize
}

public class CellPositionCalculatorImpl: CellPositionCalculator {
  let columnWidths: [CGFloat]
  let headerRowHeight: CGFloat
  let contentRowHeight: CGFloat
  let rowCount: Int
  let fullWidth: CGFloat
  let incrementsX: [CGFloat]
  let incrementsY: [CGFloat]

  init(columnWidths: [CGFloat], headerRowHeight: CGFloat, contentRowHeight: CGFloat, rowCount: Int) {
    self.columnWidths = columnWidths
    self.headerRowHeight = headerRowHeight
    self.contentRowHeight = contentRowHeight
    self.rowCount = rowCount

    self.fullWidth = columnWidths.reduce(0, +)
    self.incrementsX = columnWidths.reduce([CGFloat]()) { $0 + [$1 + ($0.last ?? 0)] }
    self.incrementsY = ([headerRowHeight] + Array(repeating: contentRowHeight, count: rowCount))
                                             .reduce([CGFloat]()) { $0 + [$1 + ($0.last ?? 0)] }
  }

  func calculateRow(yPosition: CGFloat, rowIndex: Int) -> [CGRect] {
    var rowFrame: [CGRect] = []
    var xPosition: CGFloat = 0
    let rowHeight = getHeightBy(rowIndex: rowIndex)

    for (_, column) in columnWidths.enumerated() {
      rowFrame.append(CGRect(x: xPosition, y: yPosition, width: column, height: rowHeight))
      xPosition = xPosition + column
    }

    return rowFrame
  }

  func contentSize() -> CGSize {
    CGSize(width: incrementsX.last ?? 0.0, height: incrementsY.last ?? 0.0)
  }

  func calculate() -> [[CGRect]] {
    var frames = [[CGRect]]()
    var yPosition: CGFloat = 0
    var rowIndex: Int = 0

    frames.append(advanceCalculation(yPosition: &yPosition, rowIndex: &rowIndex))
    for _ in 0..<rowCount {
      frames.append(advanceCalculation(yPosition: &yPosition, rowIndex: &rowIndex))
    }

    return frames
  }

  func calculateBounds(by rect: CGRect) -> CalculateBounds {
    var left: Int?
    var right: Int?
    for idx in 0..<incrementsX.count {
      if left == nil, incrementsX[idx] >= rect.origin.x {
        left = idx
      }
      if right == nil, incrementsX[idx] >= rect.origin.x + rect.size.width {
        right = idx
      }
    }

    var top: Int?
    var bottom: Int?
    for idx in 0..<incrementsY.count {
      if top == nil, incrementsY[idx] >= rect.origin.y {
        top = idx
      }
      if bottom == nil, incrementsY[idx] >= rect.origin.y + rect.size.height {
        bottom = idx
      }
    }
    return CalculateBounds(left: left ?? 0,
                           top: top ?? 0,
                           right: right ?? incrementsX.count - 1,
                           bottom: bottom ?? incrementsY.count - 1)
  }

  private func advanceCalculation(yPosition: inout CGFloat, rowIndex: inout Int) -> [CGRect] {
    let rowFrame = calculateRow(yPosition: yPosition, rowIndex: rowIndex)
    yPosition = yPosition + getHeightBy(rowIndex: rowIndex)
    rowIndex = rowIndex + 1
    return rowFrame
  }

  private func getHeightBy(rowIndex: Int) -> CGFloat {
    rowIndex == 0 ? headerRowHeight : contentRowHeight
  }
}
