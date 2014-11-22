
structure PackWord32Little :> PACK_WORD =
struct
local
  structure V = Word8Vector
  structure A = Word8Array
  structure W = LargeWord
in
  val bytesPerElem = 4
  val isBigEndian  = false

  infix >> << ~>>
  val op>> = W.>>
  val op<< = W.<<
  val op~>> = W.~>>

  fun extract4 length sub (vec,i) =
    if i < 0 orelse length vec < bytesPerElem * (i+1)
    then raise Subscript
    else
      (sub(vec, bytesPerElem*i+0)
      ,sub(vec, bytesPerElem*i+1)
      ,sub(vec, bytesPerElem*i+2)
      ,sub(vec, bytesPerElem*i+3))

  fun subVec (vec,i) =
    let
      val (w0,w1,w2,w3) = extract4 V.length V.sub (vec, i)
    in
      W.orb (Word8.toLarge w3<<0w24,
      W.orb (Word8.toLarge w2<<0w16,
      W.orb (Word8.toLarge w1<<0w08,
             Word8.toLarge w0<<0w00)))
    end

  val subVecX = subVec

  fun subArr (arr,i) =
    let
      val (w0,w1,w2,w3) = extract4 A.length A.sub (arr, i)
    in
      W.orb (Word8.toLarge w3<<0w24,
      W.orb (Word8.toLarge w2<<0w16,
      W.orb (Word8.toLarge w1<<0w08,
             Word8.toLarge w0<<0w00)))
    end

  val subArrX = subArr

  fun update (arr, i, w) =
    if i < 0 orelse A.length arr < bytesPerElem * (i+1)
    then raise Subscript
    else
      (A.update (arr, bytesPerElem*i+0, Word8.fromLarge (w >> 0w00));
       A.update (arr, bytesPerElem*i+1, Word8.fromLarge (w >> 0w08));
       A.update (arr, bytesPerElem*i+2, Word8.fromLarge (w >> 0w16));
       A.update (arr, bytesPerElem*i+3, Word8.fromLarge (w >> 0w24)))
end (* local *)
end

