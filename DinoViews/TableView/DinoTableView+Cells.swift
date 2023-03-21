//
// Created by Agustin Cepeda on 07/03/23.
//

import UIKit

public class BaseTableCell: UICollectionViewCell {
  lazy var background = StyleableView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  func setupView() {
    self.backgroundColor = .white

    setupBackgroundView()
  }

  public override func prepareForReuse() {
    super.prepareForReuse()

    background.setNeedsDisplay()
  }

  private func setupBackgroundView() {
    contentView.addSubview(background)

    background.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      background.topAnchor.constraint(equalTo: contentView.topAnchor),
      background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      background.widthAnchor.constraint(equalTo: contentView.widthAnchor),
      background.heightAnchor.constraint(equalTo: contentView.heightAnchor)
    ])
  }
}

public class ContentCell: BaseTableCell {

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

class ColumnHeaderCell: BaseTableCell {

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

extension UICollectionViewCell {
  public static var identifier: String {
    String(describing: self)
  }
}