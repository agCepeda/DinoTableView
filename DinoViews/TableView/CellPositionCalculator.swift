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
