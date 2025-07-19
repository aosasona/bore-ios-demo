package boredemo

import (
	"context"

	"go.trulyao.dev/bore/v2/clipboard"
)

var clipboardInstance clipboard.NativeClipboard

func init() {
	cp, err := clipboard.NewNativeClipboard()
	if err != nil {
		panic("failed to initialize clipboard: " + err.Error())
	}

	clipboardInstance = cp
}

func ReadClipboard() (string, error) {
	ctx := context.Background()

	b, err := clipboardInstance.Read(ctx)
	if err != nil {
		return "", err
	}

	return string(b), nil
}

func WriteClipboard(text string) error {
	ctx := context.Background()
	err := clipboardInstance.Write(ctx, []byte(text))
	return err
}
