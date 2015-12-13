//
//  AVFormatContext.swift
//  Tutorials
//
//  Created by Ryan Lovelett on 12/12/15.
//  Copyright © 2015 Tokuda Shusuke. All rights reserved.
//

import Foundation

extension AVFormatContext {
    var hasStreams: Bool {
        return self.streamsBuffer.count > 0
    }
    var streamsBuffer: UnsafeMutableBufferPointer<UnsafeMutablePointer<AVStream>> {
        let firstElement: UnsafeMutablePointer<UnsafeMutablePointer<AVStream>> = self.streams
        return UnsafeMutableBufferPointer(start: firstElement, count: Int(self.nb_streams))
    }
}