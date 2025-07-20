//
//  ContentView.swift
//  BoreDemo
//
//  Created by Ayodeji Osasona on 19/07/2025.
//

import Bore
import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    @State var pastedText: String = ""
    @State var showingAlert: Bool = false
    @State var errorMessage: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("Bore iOS Demo")
                .font(.title)
                .fontWeight(.bold)

            TextField("Enter text to copy", text: $text)
                .font(.body)
                .padding(.top, 8)
                .textFieldStyle(.roundedBorder)

            HStack {
                Spacer()

                // Copy
                Button(action: copy) {
                    Label("Copy", systemImage: "document.on.document")
                        .font(.caption)
                }
                .buttonStyle(.borderedProminent)

                Button(action: { text = "" }) {
                    Text("Clear")
                        .font(.caption)
                        .foregroundColor(.red)
                }
                .padding(.horizontal)
            }
            .padding(.top, 8)

            Divider()
                .padding(.vertical, 20)

            Text("Pasted text")
                .font(.title2)
                .fontWeight(.bold)

            if pastedText.isEmpty {
                Text("No text has been pasted yet.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                    .font(.caption2)
            } else {
                Text(pastedText)
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding(.top, 8)
                    .font(.caption)
            }

            HStack {
                Spacer()

                Button(action: paste) {
                    Label("Paste", systemImage: "clipboard")
                        .font(.caption)
                }
                .buttonStyle(.borderedProminent)

                Button(action: { pastedText = "" }) {
                    Text("Clear")
                        .font(.caption)
                        .foregroundColor(.red)
                }
                .padding(.horizontal)
            }

            Spacer()
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(errorMessage))
        }
    }

    func copy() {
        let error: NSErrorPointer = nil
        BoredemoWriteClipboard(text, error)

        if let error = unwrapNSErrorPointer(error) {
            print("Error copying to clipboard: \(error)")
            errorMessage = error.localizedDescription
            showingAlert = true
            return
        }
        
        print("Copied to clipboard!")
    }

    func paste() {
        let error: NSErrorPointer = nil
        let content = BoredemoReadClipboard(error)
        
        if let error = unwrapNSErrorPointer(error) {
            print("Error reading from clipboard: \(error)")
            errorMessage = error.localizedDescription
            showingAlert = true
            return
        }
        
        pastedText = content
        print("Content pasted from system clipboard!")
    }
}

func unwrapNSErrorPointer(_ rawError: NSErrorPointer?) -> Error? {
    guard let err = rawError else { return nil }
    return err?.pointee
}

#Preview {
    ContentView()
}
