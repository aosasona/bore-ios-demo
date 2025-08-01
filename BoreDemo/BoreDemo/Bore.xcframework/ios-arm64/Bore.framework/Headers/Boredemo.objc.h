// Objective-C API for talking to bore-demo Go package.
//   gobind -lang=objc bore-demo
//
// File is generated by gobind. Do not edit.

#ifndef __Boredemo_H__
#define __Boredemo_H__

@import Foundation;
#include "ref.h"
#include "Universe.objc.h"


FOUNDATION_EXPORT NSString* _Nonnull BoredemoReadClipboard(NSError* _Nullable* _Nullable error);

FOUNDATION_EXPORT BOOL BoredemoWriteClipboard(NSString* _Nullable text, NSError* _Nullable* _Nullable error);

#endif
