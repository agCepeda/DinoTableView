//
// Created by Agustin Cepeda on 04/03/23.
//

import UIKit


@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}


extension UIView {

  @IBInspectable
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }

  @IBInspectable
  var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }

  @IBInspectable
  var borderColor: UIColor? {
    get {
      if let color = layer.borderColor {
        return UIColor(cgColor: color)
      }
      return nil
    }
    set {
      if let color = newValue {
        layer.borderColor = color.cgColor
      } else {
        layer.borderColor = nil
      }
    }
  }

  @IBInspectable
  var shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.shadowRadius = newValue
    }
  }

  @IBInspectable
  var shadowOpacity: Float {
    get {
      return layer.shadowOpacity
    }
    set {
      layer.shadowOpacity = newValue
    }
  }

  @IBInspectable
  var shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }

  @IBInspectable
  var shadowColor: UIColor? {
    get {
      if let color = layer.shadowColor {
        return UIColor(cgColor: color)
      }
      return nil
    }
    set {
      if let color = newValue {
        layer.shadowColor = color.cgColor
      } else {
        layer.shadowColor = nil
      }
    }
  }
}



class Styles {
}

class StyleableView: UIView {

  static let fillColor = UIColor.white
  static let lineColor = UIColor.from(hexString: "#d1d3d5")

  @IBInspectable var className: String? = nil
  @IBInspectable var identifier: String? = nil

  lazy var borderTopLayer: CAShapeLayer = StyleableView.makeBorderLayer()
  lazy var borderBottomLayer: CAShapeLayer = StyleableView.makeBorderLayer()
  lazy var borderRightLayer: CAShapeLayer = StyleableView.makeBorderLayer()
  lazy var borderLeftLayer: CAShapeLayer = StyleableView.makeBorderLayer()

  private static func makeBorderLayer() -> CAShapeLayer {
    let shapeLayer = CAShapeLayer()
    shapeLayer.fillColor = lineColor.cgColor
    return shapeLayer
  }


  var shouldApplyBorderLeft: Bool = false {
    didSet { self.setNeedsDisplay() }
  }
  var shouldApplyBorderRight: Bool = false {
    didSet { self.setNeedsDisplay() }
  }
  var shouldApplyBorderTop: Bool = false {
    didSet { self.setNeedsDisplay() }
  }
  var shouldApplyBorderBottom: Bool = false {
    didSet { self.setNeedsDisplay() }
  }

  init() {
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }

  private func setupView() {
    backgroundColor = Self.fillColor
  }

  override func draw(_ rect: CGRect) {
    super.draw(rect)
    updateThemeableLayer(frame: bounds)
  }

  override func layerWillDraw(_ layer: CALayer) {
    super.layerWillDraw(layer)
  }

  private func updateThemeableLayer(frame: CGRect) {
    updateBorderBottom(frame: frame)
    updateBorderRight(frame: frame)
  }

  private func updateBorderBottom(frame: CGRect) {
    guard shouldApplyBorderBottom else {
      borderBottomLayer.removeFromSuperlayer()
      return
    }

    let shape = UIBezierPath(rect: CGRect(origin: CGPoint(x: 0, y: frame.height - 1.5),
                                          size: CGSize(width: frame.width, height: 1.5)))

    borderBottomLayer.path = shape.cgPath
    borderBottomLayer.frame = frame

    layer.addSublayer(borderBottomLayer)
  }


  private func updateBorderRight(frame: CGRect) {
    guard shouldApplyBorderRight else {
      self.borderRightLayer.removeFromSuperlayer()
      return
    }

    let shape = UIBezierPath(rect: CGRect(origin: CGPoint(x: frame.width - 1.5, y: 0),
                                          size: CGSize(width: 1.5, height: frame.height)))

    borderRightLayer.path = shape.cgPath
    borderRightLayer.frame = frame

    self.layer.addSublayer(borderRightLayer)
  }
}

extension UIColor {
  static func from(hexString:String) -> UIColor {
    var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
      return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
}
