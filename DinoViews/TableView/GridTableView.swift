//
//  DinoTableView.swift
//  DinoTableView
//
//  Created by Agustin Cepeda on 24/02/23.
//

import UIKit

public protocol DinoTableViewDelegate: AnyObject {}

public protocol GridTableViewDataProvider: AnyObject {
  func getRowCount() -> Int
  func getRow(from index: Int) -> Dictionary<String, NSObject>
}

public class GridTableView: UIView {

  public var columns: [ColumnModel] = [] {
    didSet { setupTableViewConfigs() }
  }
  /// Column Header height
  public var headerRowHeight: CGFloat = 50.0 {
    didSet { setupTableViewConfigs() }
  }
  /// Row  height
  public var contentRowHeight: CGFloat = 45.0 {
    didSet { setupTableViewConfigs() }
  }
  /// Row  height
  public var stickyHeader: Bool = true {
    didSet { setupTableViewConfigs() }
  }
  /// Row  height
  public var stickyColumn: Bool = false {
    didSet { setupTableViewConfigs() }
  }

  public weak var dataProvider: GridTableViewDataProvider? {
    didSet { setupTableViewConfigs() }
  }


  private var collectionView: UICollectionView!
  private var collectionViewDataSource: GridTableViewCollectionViewDataSource!
  public var showHeader: Bool = false {
    didSet { setupTableViewConfigs() }
  }


  public init() {
    super.init(frame: .zero)
    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  private func setup() {
    backgroundColor = UIColor(red: 0.212, green: 0.212, blue: 0.212, alpha: 1)

    setupCollectionView()
  }

  private func setupCollectionView() {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical

    collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
    collectionView.backgroundColor = .clear
    collectionView.bounces = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    collectionView.register(GridTableRowCell.self, forCellWithReuseIdentifier: GridTableRowCell.identifier)
    collectionView.register(GridTableColumnCell.self, forCellWithReuseIdentifier: GridTableColumnCell.identifier)

    collectionView.delegate = self

    addSubview(collectionView)

    NSLayoutConstraint.activate([
      collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
      collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
      collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
    ])
  }

  private func setupTableViewLayout() {
    guard let dataProvider = dataProvider else { return }

    let columnWidths = columns.map { $0.width }
    let rowCount = dataProvider.getRowCount()

    collectionView.collectionViewLayout = GridTableViewLayout(columnWidths: columnWidths,
                                                              headerRowHeight: headerRowHeight,
                                                              contentRowHeight: contentRowHeight,
                                                              rowCount: rowCount, showHeader: showHeader, stickyHeader: stickyHeader)
  }

  private func setupTableViewDataSource() {
    guard let dataProvider = dataProvider else { return }

    collectionViewDataSource = GridTableViewCollectionViewDataSource(dataProvider: dataProvider, columns: columns, showHeader: showHeader)
    collectionView.dataSource = collectionViewDataSource
  }

  private func setupTableViewConfigs() {
    setupTableViewLayout()
    setupTableViewDataSource()
  }
}

extension GridTableView: UICollectionViewDelegate {}
