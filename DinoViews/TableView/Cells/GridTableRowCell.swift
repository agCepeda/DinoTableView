//
// Created by Agustin Cepeda on 22/03/23.
//

import UIKit

class GridTableRowCell: GridTableBaseCell {

  lazy var textLabel = UILabel()

  override func setupView() {
    super.setupView()
    self.backgroundColor = UIColor(red: 0.984, green: 0.984, blue: 0.988, alpha: 1.0)
    background.shouldApplyBorderBottom = true
    setupTextLabel()
  }

  private func setupTextLabel() {
    addSubview(textLabel)

    textLabel.textAlignment = .center
    textLabel.textColor = .darkGray
    textLabel.font = .systemFont(ofSize: 14.0, weight: .medium)
    textLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      textLabel.topAnchor.constraint(equalTo: self.topAnchor),
      textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])
  }
  func applyStyle(indexPath: IndexPath) {
    if indexPath.item == 0 {
      background.shouldApplyBorderRight = true
    } else {
      background.shouldApplyBorderRight = false
    }
//    background.backgroundColor = indexPath.section % 2 == 1 ? .white : UIColor(red: 0.976, green: 0.98, blue: 0.984, alpha: 1)
  }
}