//
//  DinoTableView.swift
//  DinoTableView
//
//  Created by Agustin Cepeda on 24/02/23.
//

import UIKit



public class TestCell: UICollectionViewCell {

  lazy var textLabel: UILabel = {
    let label = UILabel()

    addSubview(label)

    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .red

    label

    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: self.topAnchor),
      label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])

    return label
  }()

}

public protocol DinoTableViewDelegate: AnyObject {
}

public protocol DinoTableViewDataSource: AnyObject {
  func getRowCount() -> Int
  func getRow(from index: Int) -> RowModel
}

public class DinoTableView: UIView {
  
  let layout = DinoTableViewLayout()

  lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical

    let view = UICollectionView(frame: frame, collectionViewLayout: layout)
    addSubview(view)

    view.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      view.widthAnchor.constraint(equalTo: self.widthAnchor),
      view.heightAnchor.constraint(equalTo: self.heightAnchor),
    ])

    return view
  }()
  
  public var dataSource: DinoTableViewDataSource? {
    get { layout.dataSource }
    set { layout.dataSource = newValue }
  }
  public var layoutSettings: LayoutSettings? {
    get { layout.settings }
    set { layout.settings = newValue }
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
    backgroundColor = .systemIndigo
    collectionView.backgroundColor = .systemGreen


    collectionView.register(TestCell.self, forCellWithReuseIdentifier: "TestCell")

    collectionView.dataSource = self
    collectionView.delegate = self

  }

  // Only override draw() if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  public override func draw(_ rect: CGRect) {
    // Drawing code
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
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath) as? TestCell
      else { return UICollectionViewCell() }

    cell.textLabel.text = layoutSettings?.columns[indexPath.item].name
    cell.backgroundColor = indexPath.section == 0 ? .red : .white
    cell.textLabel.textColor = indexPath.section == 0 ? .white : .lightGray
    cell.borderColor = .darkGray
    cell.borderWidth = 0.5

    return cell
  }
}

extension DinoTableView: UICollectionViewDelegate {}
