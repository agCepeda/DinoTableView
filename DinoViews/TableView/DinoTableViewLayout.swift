//
//  DinoTableViewLayout.swift
//  DinoViews
//
//  Created by Agustin Cepeda on 24/02/23.
//

import UIKit

class LayoutAttributes: UICollectionViewLayoutAttributes {
}

public class DinoTableViewLayout: UICollectionViewLayout {

  public weak var dataSource: DinoTableViewDataSource? = nil

  public var settings: LayoutSettings? = nil
  private var positionCalculator: CellPositionCalculatorImpl!

  private var cachedFrames = [[CGRect]]()
  private var cachedAttributes = [[UICollectionViewLayoutAttributes]]()

  public override init() {
    super.init()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  public override var collectionViewContentSize: CGSize {
    return positionCalculator.contentSize()
  }

  public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return cachedAttributes.flatMap { $0.filter { $0.frame.intersects(rect) }}
  }

  public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cachedAttributes[indexPath.section][indexPath.item]
  }

  public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }

  private func setupForCalculate() {
    setupCalculator()
    calculateAndSavePositions()
  }

  private func calculateAndSavePositions() {
    let frames = positionCalculator.calculate()
    let attributes = frames.enumerated().map { (row, elements) in
      elements.enumerated().map { (column, rect) -> UICollectionViewLayoutAttributes in
        let attrs = LayoutAttributes(forCellWith: IndexPath(item: column, section: row))
        attrs.frame = rect
        return attrs
      }
    }

    cachedFrames = frames
    cachedAttributes = attributes
  }

  private func setupCalculator() {
    guard positionCalculator == nil, let settings = settings else { return }

    let columnWidths = settings.columns.map { $0.width }
    let headerRowHeight = settings.headerRowHeight
    let contentRowHeight = settings.contentRowHeight

    guard let rowCount = dataSource?.getRowCount() else { fatalError() }

    positionCalculator = CellPositionCalculatorImpl(columnWidths: columnWidths,
                                                    headerRowHeight: headerRowHeight,
                                                    contentRowHeight: contentRowHeight,
                                                    rowCount: rowCount)
  }

  public override func prepare() {
    super.prepare()
    setupForCalculate()
  }
}
