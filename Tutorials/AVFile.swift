//
//  AVFile.swift
//  Tutorials
//
//  Created by Ryan Lovelett on 12/12/15.
//  Copyright © 2015 Tokuda Shusuke. All rights reserved.
//

import Foundation

enum AVFileError: ErrorType {
    case OpenFile
    case NoStreams
}

class AVFile {
    private var format: AVFormatContext
    private var fileName: String

    init(path filePath: String) throws {
        self.fileName = filePath
        var formatContext = UnsafeMutablePointer<AVFormatContext>()
        guard avformat_open_input(&formatContext, filePath, nil, nil) == 0 else {
            self.format = AVFormatContext()
            throw AVFileError.OpenFile
        }
        guard avformat_find_stream_info(formatContext, nil) >= 0 else {
            self.format = AVFormatContext()
            throw AVFileError.NoStreams
        }
        self.format = formatContext.memory
        for streamPointer in self.format.streamsBuffer {
            let stream = streamPointer.memory
            let currentStreamCodec = stream.codec.memory
            let currentStreamCodecType: AVMediaType = currentStreamCodec.codec_type
            switch currentStreamCodecType {
            case AVMEDIA_TYPE_UNKNOWN: break
            case AVMEDIA_TYPE_VIDEO: print("Video")
            case AVMEDIA_TYPE_AUDIO: print("Audio")
            case AVMEDIA_TYPE_DATA: break
            case AVMEDIA_TYPE_SUBTITLE: break
            case AVMEDIA_TYPE_ATTACHMENT: break
            case AVMEDIA_TYPE_NB: break
            default: break
            }
        }
    }

    deinit {
        withUnsafeMutablePointer(&self.format) { (pointer) in
            avformat_free_context(pointer)
        }
    }
}

extension AVFile: CustomStringConvertible {
    var description: String {
        guard format.hasStreams else {
            return ""
        }
        let str = "Input #0, \(format.oformat.memory.name), %s '%s':"
        return str
    }
}