//
//  UIImage+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/11/26.
//

import UIKit
import Accelerate
import QuartzCore

enum ImageFormat {
    case Unknow
    case JPEG
    case PNG
    case GIF
    case TIFF
    case WebP
    case HEIC
    case HEIF
}

extension UIImage {
    
    /// update image blur
    /// - Parameter blurOpacity: blur opacity
    /// - Returns: image with blur
    func imageBlur(blurOpacity: CGFloat) -> UIImage {
        
        var blur = blurOpacity
        if blurOpacity > 1.0 {
            blur = 1.0
        }
        if blurOpacity < 0.0 {
            blur = 0.0
        }
        
        blur = 1 - blur
        
        blur = blur * 40
        
        let size = blur - blur.truncatingRemainder(dividingBy: 2) + 1
        
        let img = self.cgImage
        
        let inProvide = img?.dataProvider
        let inBitmapData = inProvide?.data
        
        let imgWidth  = vImagePixelCount((img?.width)!)
        let imgHeight = vImagePixelCount((img?.height)!)
        let imgRowBytes = img?.bytesPerRow
        
        let inData = UnsafeMutableRawPointer(mutating: CFDataGetBytePtr(inBitmapData))
        let outData = malloc(img!.bytesPerRow * img!.height)
        
        var inBuffer  = vImage_Buffer(data:  inData, height: imgHeight, width: imgWidth, rowBytes: imgRowBytes!)
        var outBuffer = vImage_Buffer(data: outData, height: imgHeight, width: imgWidth, rowBytes: imgRowBytes!)
        
        var error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, UInt32(size), UInt32(size), nil, vImage_Flags(kvImageEdgeExtend))
        
        if error != kvImageNoError {
            error = vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, nil, 0, 0, UInt32(size), UInt32(size), nil, vImage_Flags(kvImageEdgeExtend))
            if error != kvImageNoError {
                error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, UInt32(size), UInt32(size), nil, vImage_Flags(kvImageEdgeExtend))
            }
        }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let context = CGContext.init(data: outBuffer.data, width: Int(outBuffer.width), height: Int(outBuffer.height), bitsPerComponent: 8, bytesPerRow: Int(outBuffer.rowBytes), space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        
        var imageRef = context?.makeImage()
        let bluredImage = UIImage.init(cgImage: imageRef!)
        imageRef = nil
        free(outData)
        return bluredImage
    }
    
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
    
    /// create image with image, set radius and size
    /// - Parameters:
    ///   - image: original image
    ///   - radius: radius
    ///   - size: size
    /// - Returns: new image
    class func imageCreated(image: UIImage, radius: CGFloat, size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
        context?.addPath(path.cgPath)
        context?.clip()
        image.draw(in: rect)
        context?.drawPath(using: .fillStroke)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// create image with image, set radius [size is image's size]
    /// - Parameters:
    ///   - image: image
    ///   - radius: radius
    /// - Returns: new image
    class func imageCreated(image: UIImage, radius: CGFloat) -> UIImage? {
        return imageCreated(image: image, radius: radius, size: image.size)
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
    
    /// image from data [which kind image : jpeg, jpg, png....]
    /// - Parameter data: data
    /// - Returns: return image tyep
    class func imageFormatData(data: Data) -> ImageFormat {
        var buffer = [UInt8](repeating: 0, count: 1)
        data.copyBytes(to: &buffer, count: 1)
        
        switch buffer {
        case [0xFF]:
            return .JPEG
        case [0x89]:
            return .PNG
        case [0x47]:
            return .GIF
        case [0x49],[0x4D]:
            return .TIFF
        case [0x52] where data.count >= 12:
            if let str = String(data: data[0...11],encoding: .ascii), str.hasPrefix("RIFF"), str.hasSuffix("WEBP") {
                return .WebP
            }
        case [0x00] where data.count >= 12:
            if let str = String(data: data[8...11], encoding: .ascii) {
                let HEICBitMaps = Set(["heic", "heis", "heix", "hevc", "hevx"])
                if HEICBitMaps.contains(str) {
                    return .HEIC
                }
                let HEIFBitMaps = Set(["mif1", "msf1"])
                if HEIFBitMaps.contains(str) {
                    return .HEIF
                }
            }
        default:
            break
        }
        return .Unknow
    }
    
    /// return image size from image url
    /// - Parameter url: url
    /// - Returns: width and height
    class func imageSizeFrom(url: String?) -> CGSize {
        guard url != nil else {
            return .zero
        }
        let imageSourceRef = CGImageSourceCreateWithURL(NSURL(string: url!)!, nil)
        var width: CGFloat = 0.0, height: CGFloat = 0.0
        if imageSourceRef != nil {
            let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef!, 0, nil)
            if let imageD = imageProperties {
                let imageDict = imageD as Dictionary
                width  = imageDict[kCGImagePropertyPixelWidth] as! CGFloat
                height = imageDict[kCGImagePropertyPixelHeight] as! CGFloat
            }
        }
        return CGSize(width: width, height: height)
    }
}

extension UIImage {
    /// resize image size [default left is 0.5, top is 0.5]
    /// - Parameter name: image name
    /// - Returns: image
    class func resizedImage(name: String) -> UIImage {
        return resizedImage(name: name, left: 0.5, top: 0.5)
    }
    /// resize image size
    /// - Parameters:
    ///   - name: image name
    ///   - left: left
    ///   - top: top
    /// - Returns: image
    class func resizedImage(name: String, left: CGFloat, top: CGFloat) -> UIImage {
        let image: UIImage = UIImage.init(named: name)!
        return image.stretchableImage(withLeftCapWidth: Int(image.size.width * left), topCapHeight: Int(image.size.height * top))
    }
}
