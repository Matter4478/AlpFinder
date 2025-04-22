//
//  WebView.swift
//  AlpFinder
//
//  Created by M. De Vries on 16/03/2024.
//

import Foundation
import WebKit
import SwiftUI

#if os(iOS)
import UIKit
struct WebView: UIViewRepresentable{
    let url: URL
    
    func makeUIView(context: Context)->WKWebView{
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context){
        let req = URLRequest(url: self.url)
        webView.load(req)
    }
}

#elseif os(macOS)
import AppKit
struct WebView: NSViewRepresentable{
    
    let url: URL
    func makeNSView(context: Context) -> WKWebView{
        return WKWebView()
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        let req = URLRequest(url: self.url)
        nsView.load(req)
    }
}
#endif

