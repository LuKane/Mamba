//
//  UIImage+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/11/26.
//

import UIKit

extension UIImage {
    
    /// create image with color (size: default is (1,1))
    /// - Parameter color: color
    /// - Returns: image
    class func imageCreated(fillColor color: UIColor) -> UIImage? {
        return imageCreated(fillColor: color, size: CGSize(width: 1, height: 1))
    }
    
    /// create image with color and size
    /// - Parameters:
    ///   - color: color
    ///   - size: size
    /// - Returns: image
    class func imageCreated(fillColor color: UIColor, size: CGSize) -> UIImage? {
        
        guard size.width > 0 || size.height > 0 else {
            return nil
        }
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// create image with size ,but although call back to finish it
    /// - Parameters:
    ///   - size: size
    ///   - callBack: callback
    /// - Returns: image
    class func imageCreated(size: CGSize, callBack: @escaping (_ context: CGContext) -> Void) -> UIImage? {
        guard size.width > 0 || size.height > 0 else {
            return nil
        }
        
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        guard context != nil else {
            return nil
        }
        
        callBack(context!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// create image with two image , the first image is the center of the baseImage
    /// - Parameters:
    ///   - image: imageUp
    ///   - baseImage: imageBase
    ///   - scale: scale
    /// - Returns: image
    class func imageCreated(image: UIImage, baseImage: UIImage, scale: CGFloat) -> UIImage? {
        var scal = scale
        if scale > 1 {
            scal = 1
        }
        if scale <= 0 {
            scal = 1
        }
        let x: CGFloat = baseImage.size.width * (1-scal) * 0.5
        let y: CGFloat = baseImage.size.height * (1-scal) * 0.5
        return imageCreated(image: image, baseImage: baseImage, scale: scale, origin: CGPoint(x: x, y: y))
    }
    
    /// create image with two image
    /// - Parameters:
    ///   - image: imageUp
    ///   - baseImage: imageBase
    ///   - scale: scale
    ///   - origin: origin
    /// - Returns: image
    class func imageCreated(image: UIImage, baseImage: UIImage, scale: CGFloat, origin: CGPoint) -> UIImage? {
        
        if UIScreen.main.scale == 2.0 {
            UIGraphicsBeginImageContextWithOptions(baseImage.size, false, 2.0)
        }else if UIScreen.main.scale == 3.0 {
            UIGraphicsBeginImageContextWithOptions(baseImage.size, false, 3.0)
        }else {
            UIGraphicsBeginImageContext(baseImage.size)
        }
        
        baseImage.draw(in: CGRect(x: 0, y: 0, width: baseImage.size.width, height: baseImage.size.height))
        
        var scal = scale
        if scale > 1 {
            scal = 1
        }
        if scale <= 0 {
            scal = 1
        }
        
        image.draw(in: CGRect(x: origin.x, y: origin.y, width: CGFloat(baseImage.size.width) * scal, height: CGFloat(baseImage.size.height) * scal))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    /// create QRCode image with content
    /// - Parameters:
    ///   - content: content
    ///   - width: size.width
    /// - Returns: qrcode image
    class func imageCreateQRCode(content: String?, width: CGFloat) -> UIImage? {
        guard content?.isEmpty == false else {
            return nil
        }
        guard width > 0 else {
            return nil
        }
        
        guard let filter = CIFilter.init(name: "CIQRCodeGenerator") else {
            return nil
        }
        
        filter.setValue(content!.data(using: .utf8, allowLossyConversion: false), forKey: "inputMessage")
        let outputImage = filter.outputImage
        
        guard let colorFilter = CIFilter.init(name: "CIFalseColor") else { return nil }
        colorFilter.setDefaults()
        colorFilter.setValue(outputImage, forKey: "inputImage")
        colorFilter.setValue(CIColor.black, forKey: "inputColor0")
        colorFilter.setValue(CIColor.white, forKey: "inputColor1")
        
        guard let outputImage1 = colorFilter.outputImage else { return nil }
        let scale = width / outputImage1.extent.size.width
        let image_str = outputImage1.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        return UIImage(ciImage: image_str)
    }
    
    /// create BarCode image with content
    /// - Parameters:
    ///   - content: content
    ///   - size: size
    /// - Returns: barcode image
    class func imageCreateBarCode(content: String?, size: CGSize) -> UIImage? {
        guard size.equalTo(.zero) == false else {
            return nil
        }
        guard size.width != 0 else {
            return nil
        }
        guard size.height != 0 else {
            return nil
        }
        
        guard content?.isEmpty == false else {
            return nil
        }
        
        guard let filter = CIFilter.init(name: "CICode128BarcodeGenerator") else {
            return nil
        }
        
        filter.setValue(content!.data(using: .utf8), forKeyPath: "inputMessage")
        
        guard (filter.outputImage != nil) else {
            return nil
        }
        
        var ciImage = filter.outputImage!
        
        let scaleX = size.width / ciImage.extent.size.width
        let scaleY = size.height / ciImage.extent.size.height
        
        ciImage = ciImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        return UIImage(ciImage: ciImage)
    }
}
