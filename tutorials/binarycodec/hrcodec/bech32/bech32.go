// Package bech32 provides a (somewhat simplified) version of the standard
// Bech32 human readable binary codec for rendering hashes into a form that can
// be read and transcribed by humans
package bech32

import (
	"github.com/quanterall/GoMaterials/tutorials/binarycodec/hrcodec"
)

var Spec = hrcodec.Codec{}
