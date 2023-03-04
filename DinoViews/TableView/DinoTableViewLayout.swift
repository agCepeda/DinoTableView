//
//  DinoTableViewLayout.swift
//  DinoViews
//
//  Created by Agustin Cepeda on 24/02/23.
//

import UIKit

public class DinoTableViewLayout: UICollectionViewLayout {

  public weak var dataSource: DinoTableViewDataSource? = nil
  public weak var delegate: DinoTableViewDelegate? = nil

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
    let originBound = IndexPath.init()
    let upperBound = IndexPath.init()

//    cachedAttributes[indexPath.section].map { $ }

    return super.layoutAttributesForElements(in: rect)
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
    let attributes = frames.map { $0.map { rect -> UICollectionViewLayoutAttributes in
      let attrs = UICollectionViewLayoutAttributes()
      attrs.frame = rect
      return attrs
    }}

    cachedFrames = frames
    cachedAttributes = attributes
  }

  private func setupCalculator() {
    guard positionCalculator == nil else { return }

    guard let columns = dataSource?.getColumns(),
          let rowCount = dataSource?.getRowCount(),
          let columnWidths = dataSource?.getLayoutSettings().columnWidths,
          let rowHeight = dataSource?.getLayoutSettings().rowHeight,
          let columnHeaderHeight = dataSource?.getLayoutSettings().columnHeaderHeight
    else { fatalError() }

    guard columnWidths.count == columns.count else { fatalError() }

    positionCalculator = CellPositionCalculatorImpl(columnWidths: columnWidths,
                                                    columnHeaderHeight: columnHeaderHeight,
                                                    rowHeight: rowHeight,
                                                    rowCount: rowCount)
  }

  public override func prepare() {
    super.prepare()
    setupForCalculate()
  }
}
