//
// Created by Agustin Cepeda on 22/03/23.
//

import UIKit

class GridTableColumnCell: GridTableBaseCell {

  lazy var textLabel = UILabel()

  override func setupView() {
    super.setupView()
    setupdd()

    background.backgroundColor = UIColor(red: 0.212, green: 0.212, blue: 0.212, alpha: 1)
  }

  func setupdd () {
    addSubview(textLabel)

    textLabel.textAlignment = .center
    textLabel.textColor = .systemGray6
    textLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
    textLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      textLabel.topAnchor.constraint(equalTo: self.topAnchor),
      textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])
  }
}
