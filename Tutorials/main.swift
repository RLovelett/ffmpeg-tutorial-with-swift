//
//  main.swift
//  Tutorials
//
//  Created by Tokuda Shusuke on 2015/01/22.
//  Copyright (c) 2015年 Tokuda Shusuke. All rights reserved.
//

import Foundation

guard let filePath = Process.arguments.reverse().first else {
    print("No path to a video file was provided.")
    exit(1)
}

// ¯\_(ツ)_/¯
av_register_all()

let file = try? AVFile(path: filePath)

/**
Input #0, mpegts, from '/Users/ryan/Desktop/test.ts':
  Duration: 00:00:22.25, start: 58812.807589, bitrate: 7774 kb/s
    Stream #0:0[0x31]: Video: mpeg2video (Main), yuv420p(tv), 1920x1080 [SAR 1:1 DAR 16:9], Closed Captions, max. 19392 kb/s, 29.97 fps, 29.97 tbr, 90k tbn, 59.94 tbc
    Stream #0:1[0x34]: Audio: ac3, 48000 Hz, 5.1(side), fltp, 384 kb/s
*/
print(file)