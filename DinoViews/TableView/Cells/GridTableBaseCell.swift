//
// Created by Agustin Cepeda on 22/03/23.
//

import UIKit

public class GridTableBaseCell: UICollectionViewCell {
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
