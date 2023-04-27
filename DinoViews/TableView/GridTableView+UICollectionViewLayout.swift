//
//  DinoTableViewLayout.swift
//  DinoViews
//
//  Created by Agustin Cepeda on 24/02/23.
//

import UIKit

public class GridTableViewLayout: UICollectionViewLayout {

  private var calculator: CellPositionCalculator

  private var cachedAttributes = [[UICollectionViewLayoutAttributes]]()
  private var cachedFrames = [[CGRect]]()
  private var stickyHeader: Bool
  private var showHeader: Bool

  init(columnWidths: [CGFloat], headerRowHeight: CGFloat, contentRowHeight: CGFloat, rowCount: Int, showHeader: Bool, stickyHeader: Bool) {
    self.stickyHeader = stickyHeader
    self.showHeader = showHeader
    self.calculator = CellPositionCalculatorImpl(columnWidths: columnWidths,
                                                 headerRowHeight: headerRowHeight,
                                                 contentRowHeight: contentRowHeight,
                                                 rowCount: rowCount, showHeader: showHeader)
    super.init()

    calculateAndSavePositions()
  }

  internal required init?(coder: NSCoder) {
    fatalError()
  }

  public override var collectionViewContentSize: CGSize {
    calculator.contentSize()
  }

  public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    cachedAttributes.flatMap { $0.filter { $0.frame.intersects(rect) }}
  }

  public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    cachedAttributes[indexPath.section][indexPath.item]
  }

  public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    true
  }

  public override func prepare() {
    super.prepare()
    updateItemsIfNeeded()
  }

  private func calculateAndSavePositions() {
    let frames = calculator.calculate()
    let attributes = frames.enumerated().map { (row, elements) in
      elements.enumerated().map { (column, rect) -> UICollectionViewLayoutAttributes in
        let attrs = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: column, section: row))
        attrs.frame = rect

        switch (row, column) {
        case (0, 0):
          attrs.zIndex = 5
        case (0, _):
          attrs.zIndex = 4
        case (_, 0):
          attrs.zIndex = 3
        default:
          attrs.zIndex = 2
        }

        return attrs
      }
    }

    cachedFrames = frames
    cachedAttributes = attributes
  }

  private func updateItemsIfNeeded() {
    guard let contentOffset = collectionView?.contentOffset else { return }

    if stickyHeader && showHeader {
      cachedAttributes[0].forEach { attributes in
        attributes.frame = CGRect(x: attributes.frame.origin.x,
                                  y: contentOffset.y,
                                  width: attributes.frame.size.width,
                                  height: attributes.frame.size.height)
      }
    }
  }
}
