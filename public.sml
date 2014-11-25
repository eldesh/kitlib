
(* comparison type *)
signature ORDER = ORDER

(* finite map *)
signature MONO_FINMAP  = MONO_FINMAP
structure IntFinMap    : MONO_FINMAP = IntFinMap
functor OrderFinMap = OrderFinMap
structure StringFinMap : MONO_FINMAP = StringFinMap

(* polymorphic hashtables *)
signature POLYHASH = POLYHASH
structure Polyhash : POLYHASH = Polyhash

(* Generic sorting *)
signature LISTSORT = LISTSORT
structure Listsort : LISTSORT = Listsort

(* MD5 Message-Digest Algorithm *)
signature MD5 = MD5
structure MD5 : MD5 = MD5

(* Generic pickle/serialization  *)
signature PICKLE = PICKLE
structure Pickle : PICKLE = Pickle

(* Pretty Printing *)
signature PPRINT = PPRINT
structure PPrint : PPRINT = PPrint

(* Pseudo random numbers *)
signature RANDOM = RANDOM
structure Random : RANDOM = Random

(* NFA implementation of regular expression matching by Ken Friis *)
signature REG_EXP = REG_EXP
structure RegExp : REG_EXP = RegExp

(* Finite sets using balanced AVL trees *)
signature MONO_SET  = MONO_SET
structure IntSet    : MONO_SET where type elem = int = IntSet
structure NatSet    : MONO_SET where type elem = word= NatSet
functor OrderSet = OrderSet
structure StringSet : MONO_SET = StringSet

(* Compatibility module for Standard ML 90. *) 
signature SML90 = SML90
structure SML90 : SML90 = SML90

(* Support for lazy evaluation *)
signature SUSP = SUSP
structure Susp : SUSP = Susp

(* Unifiable references with a ref-like interface *)
signature UREF = UREF
structure URef : UREF = URef

(* Generic functionality for running unit tests. *)
signature UTEST = UTEST
structure Utest : UTEST = Utest

