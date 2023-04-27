//
// Created by Agustin Cepeda on 02/03/23.
//

import CoreGraphics

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
  let showHeader: Bool
  private let fullWidth: CGFloat
  private let fullHeight: CGFloat

  init(columnWidths: [CGFloat], headerRowHeight: CGFloat, contentRowHeight: CGFloat, rowCount: Int, showHeader: Bool) {
    self.columnWidths = columnWidths
    self.headerRowHeight = headerRowHeight
    self.contentRowHeight = contentRowHeight
    self.rowCount = rowCount
    self.showHeader = showHeader

    self.fullWidth = columnWidths.reduce(0, +)
    self.fullHeight = CGFloat(rowCount) * contentRowHeight + (showHeader ? headerRowHeight : 0)
  }

  func contentSize() -> CGSize {
    CGSize(width: fullWidth, height: fullHeight)
  }

  func calculate() -> [[CGRect]] {
    var frames = [[CGRect]]()
    var yPosition: CGFloat = 0
    var rowIndex: Int = 0

    if showHeader {
      frames.append(advanceCalculation(yPosition: &yPosition, rowIndex: &rowIndex))
    }

    for _ in 0..<rowCount {
      frames.append(advanceCalculation(yPosition: &yPosition, rowIndex: &rowIndex))
    }

    return frames
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

  private func advanceCalculation(yPosition: inout CGFloat, rowIndex: inout Int) -> [CGRect] {
    let rowFrame = calculateRow(yPosition: yPosition, rowIndex: rowIndex)
    yPosition = yPosition + getHeightBy(rowIndex: rowIndex)
    rowIndex = rowIndex + 1
    return rowFrame
  }

  private func getHeightBy(rowIndex: Int) -> CGFloat {
    rowIndex == 0 && showHeader ? headerRowHeight : contentRowHeight
  }
}
