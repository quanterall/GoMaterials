
- [Binary Codec Tutorial](#binary-codec-tutorial)

# Binary Codec Tutorial

In this tutorial we will walk you through the creation from scratch of a 
human readable encoding system, and to make it more interesting, give the 
option of varying the details of the scheme produced.

In the base58 and bech32 directories are copies of the encoders used by 
`btcd`, the Go implementation of the Bitcoin full node. *todo* put the 
stupid ethereum check-as-capitalised-bytes library in there too and make 
notes about using it with also base32, instead of terminal check bytes.

The idea here is to make a tutorial that lets you go a lot deeper into the 
task while giving a simple base to understand encoding bytes in forms that 
humans can transcribe (theoretically)
