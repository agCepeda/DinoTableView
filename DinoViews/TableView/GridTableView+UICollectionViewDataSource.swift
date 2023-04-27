//
// Created by Agustin Cepeda on 22/03/23.
//

import UIKit

class GridTableViewCollectionViewDataSource: NSObject, UICollectionViewDataSource {
  private var dataProvider: GridTableViewDataProvider
  private var columns: [ColumnModel]
  private let showHeader: Bool

  init(dataProvider: GridTableViewDataProvider, columns: [ColumnModel], showHeader: Bool) {
    self.dataProvider = dataProvider
    self.columns = columns
    self.showHeader = showHeader
  }

  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    dataProvider.getRowCount() + 1
  }

  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    columns.count
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.section == 0 && showHeader {
      return configureHeaderRowCell(collectionView: collectionView, indexPath: indexPath)
    } else {
      return configureContentRowCell(collectionView: collectionView, indexPath: indexPath)
    }
  }

  private func configureContentRowCell(collectionView: UICollectionView, indexPath: IndexPath) -> GridTableRowCell {
    guard let cell = GridTableRowCell.dequeue(from: collectionView, for: indexPath) else { return GridTableRowCell() }

    let row = dataProvider.getRow(from: indexPath.section)
    let column = columns[indexPath.item].attributeKey

    cell.textLabel.text = "\(row[column])"
    cell.applyStyle(indexPath: indexPath)

    return cell
  }

  private func configureHeaderRowCell(collectionView: UICollectionView, indexPath: IndexPath) -> GridTableColumnCell {
    guard let cell = GridTableColumnCell.dequeue(from: collectionView, for: indexPath) else { return GridTableColumnCell() }

    cell.textLabel.text = columns[indexPath.item].name

    return cell
  }
}

extension UICollectionViewCell {
  public static var identifier: String {
    String(describing: self)
  }

  static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath) -> Self? {
    return collectionView.dequeueReusableCell(withReuseIdentifier: Self.identifier, for: indexPath) as? Self
  }
}