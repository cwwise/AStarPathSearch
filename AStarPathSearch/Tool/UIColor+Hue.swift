import UIKit

// MARK: - Color Builders

public extension UIColor {
  /// Constructing color from hex string
  ///
  /// - Parameter hex: A hex string, can either contain # or not
  convenience init(hex string: String) {
    var hex = string.hasPrefix("#")
      ? String(string.characters.dropFirst())
      : string
    guard hex.characters.count == 3 || hex.characters.count == 6
      else {
        self.init(white: 1.0, alpha: 0.0)
        return
    }
    if hex.characters.count == 3 {
      for (index, char) in hex.characters.enumerated() {
        hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
      }
    }
    
    self.init(
      red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
      green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
      blue:  CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0, alpha: 1.0)
  }
  
  /// Convenient method to change alpha value
  ///
  /// - Parameter value: The alpha value
  /// - Returns: The alpha adjusted color
  public func alpha(_ value: CGFloat) -> UIColor {
    return withAlphaComponent(value)
  }
}
