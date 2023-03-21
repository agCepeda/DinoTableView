//
//  DinoTableView.swift
//  DinoTableView
//
//  Created by Agustin Cepeda on 24/02/23.
//

import UIKit

public protocol DinoTableViewDelegate: AnyObject {}

public protocol DinoTableViewDataSource: AnyObject {
  func getRowCount() -> Int
  func getRow(from index: Int) -> RowModel
}

public class DinoTableView: UIView {

  private var collectionView: UICollectionView!
  public var dataSource: DinoTableViewDataSource? {
    didSet { setupTableViewLayout() }
  }
  public var layoutSettings: Settings? {
    didSet { setupTableViewLayout() }
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

    collectionView.register(ContentCell.self, forCellWithReuseIdentifier: ContentCell.identifier)
    collectionView.register(ColumnHeaderCell.self, forCellWithReuseIdentifier: ColumnHeaderCell.identifier)

    collectionView.dataSource = self
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
    guard let settings = layoutSettings, let dataSource = dataSource else { return }
    collectionView.collectionViewLayout = DinoTableViewLayout(settings: settings, dataSource: dataSource)
  }
}

extension DinoTableView: UICollectionViewDataSource {
  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    (dataSource?.getRowCount() ?? 0) + 1
  }

  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    layoutSettings?.columns.count ?? 0
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.section == 0 {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColumnHeaderCell.identifier, for: indexPath) as? ColumnHeaderCell
        else { return UICollectionViewCell() }

      cell.textLabel.text = layoutSettings?.columns[indexPath.item].name

      return cell
    } else {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCell.identifier, for: indexPath) as? ContentCell
        else { return UICollectionViewCell() }

      cell.textLabel.text = "(\(indexPath.section), \(indexPath.item))"
      cell.applyStyle(indexPath: indexPath)

      return cell
    }
  }
}

extension DinoTableView: UICollectionViewDelegate {}
