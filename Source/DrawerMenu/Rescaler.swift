//
//  Rescaler.swift
//  CFloat Value Rescale
//
//  Created by Ryan Kohl on 2/8/20.
//  Copyright © 2020 Kohl Development Group LLC. All rights reserved.
//

import UIKit

struct Rescale {
    typealias RescaleDomain = (lowerBound: CGFloat, upperBound: CGFloat)

    var fromDomain: RescaleDomain
    var toDomain: RescaleDomain

    init(from: RescaleDomain, to: RescaleDomain) {
        self.fromDomain = from
        self.toDomain = to
    }

    func interpolate(_ x: CGFloat ) -> CGFloat {
        return self.toDomain.lowerBound * (1 - x) + self.toDomain.upperBound * x;
    }

    func uninterpolate(_ x: CGFloat) -> CGFloat {
        let b = (self.fromDomain.upperBound - self.fromDomain.lowerBound) != 0 ? self.fromDomain.upperBound - self.fromDomain.lowerBound : 1 / self.fromDomain.upperBound;
        return (x - self.fromDomain.lowerBound) / b
    }

    func rescale(_ x: CGFloat )  -> CGFloat {
        return interpolate( uninterpolate(x) )
    }
}
