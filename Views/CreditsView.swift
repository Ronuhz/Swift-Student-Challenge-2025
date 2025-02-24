//
//  CreditsView.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 14.02.2025.
//

import SwiftUI

struct CreditsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.audio) private var audio
    
    var body: some View {
        ZStack {
            GridBackgroundView()
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        Text("Credits")
                            .title()
                        
                        VStack(alignment: .leading, spacing: 24) {
                            Text("Design & Development")
                                .font(.title2.bold())
                                .foregroundStyle(.primary)
                            
                            Text("Created by Hunor Zoltáni")
                                .subtitle()
                        }
                        
                        VStack(alignment: .leading, spacing: 24) {
                            Text("Sound Effects")
                                .font(.title2.bold())
                                .foregroundStyle(.primary)
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Tap Sound")
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                Text("Created by me by recording the sound of suddenly putting tension on a tissue paper.")
                                    .subtitle()
                                
                                Text("Success, Failure & Waiting Sounds")
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                Text("""
Created by me using [BeepBox](https://www.beepbox.co). View them by tapping the links below:
[Success Sound](https://www.beepbox.co/#9n31s6k0l00e00t43a7g0fj07r0i0o432T1v1u52f0qwx10v311d08A1F2B4Q00b0Pf519E3b662876T1v1u39f0qwx10l611d08A0F0B0Q38e0Pa610E3b8618626T1v1u77f10o9q011d03A1F9B4Q1003Pfb94E262963bT2v1u15f10w4qw02d03w0E0b40000000000g0000000001010000000040s00000000p1lFDXibc_8d0ap-3NY00000)
[Failure Sound](https://www.beepbox.co/#9n31s6k0l00e00t43a7g0fj07r0i0o432T5v1u53f0qwx10h511d03H_RIBJAAAzrrrqhh0E1b4T1v1u39f0qwx10l611d08A0F0B0Q38e0Pa610E3b8618626T1v1u77f10o9q011d03A1F9B4Q1003Pfb94E262963bT2v1u15f10w4qw02d03w0E0b40000000000g0000000001010000000040s00000000p1hIOX1WCkOY7CE00000)
[Waiting Sound](https://www.beepbox.co/#9n31s6k0l00e03t2ma7g0fj07r2i0o432T1v1u35f0qwx10l611d08A6F0B0Q05c0Pa660E2bi626T1v1uacf0q011d03AbF6B0Q2580PfffaE501602612622636T5v1u81f10o5q011d03HOKF70605040200h0E0T2v1u15f10w4qw02d03w0E0b4h400000000h4g000000014h000000004h400000000p1EIP_sjfN9klgc3hlnpApBQSkplV5l6lmnpAk00000)
""")
                                    .subtitle()
                                    .tint(.accentColor)
                                
                                Text("BeepBox License")
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                Text("BeepBox is licensed under the MIT license. As stated on their website: \"BeepBox does not claim ownership over songs created with it, so original songs belong to their authors.\"")
                                    .subtitle()
                            }
                        }
                    }
                    .safeAreaPadding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer(minLength: 16)
                
                Button("Close") {
                    audio.play(.tap)
                    dismiss()
                }
                .buttonStyle(ActionButton(edgeToEdge: true))
                .safeAreaPadding()
            }
        }
    }
}

#Preview {
    CreditsView()
        .preview()
}
