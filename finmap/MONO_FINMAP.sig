(** Monomorphic finite maps.

The MONO_FINMAP signature is a generic interface to monomorphic finite maps.
*)

signature MONO_FINMAP = sig
  type dom
  type 'b map
          
  val empty      : 'b map
  val singleton  : dom * 'b -> 'b map
  val isEmpty    : 'b map -> bool
  val lookup     : 'b map -> dom -> 'b option
  val add        : dom * 'b * 'b map -> 'b map
  val plus       : 'b map * 'b map -> 'b map
  val remove     : dom * 'b map -> 'b map option      
  val dom        : 'b map -> dom list
  val range      : 'b map -> 'b list
  val list       : 'b map -> (dom * 'b) list
  val fromList   : (dom * 'b) list -> 'b map
  val composemap : ('b -> 'c) -> 'b map -> 'c map
  val ComposeMap : (dom * 'b -> 'c) -> 'b map -> 'c map
  val fold       : (('a * 'b) -> 'b) -> 'b -> 'a map -> 'b
  val Fold       : (((dom * 'b) * 'c) -> 'c)-> 'c -> 'b map -> 'c
  val filter     : (dom * 'b -> bool) -> 'b map -> 'b map
  val addList    : (dom * 'b) list -> 'b map -> 'b map
  val mergeMap   : (('b * 'b) -> 'b) -> 'b map -> 'b map -> 'b map

  exception Restrict of string
  val restrict   : (dom -> string) * 'b map * dom list -> 'b map
  val enrich     : ('b * 'b -> bool) -> ('b map * 'b map) -> bool
end

(**
[addList l m] adds a list of associations to a map.

[mergeMap f m1 m2] merges two finite maps, with a composition function
to apply to the codomains of domains which clash.

[restrict (f,m,d)] returns a map with domain d and values as in m.
Raises exception Restrict if an element of the list is not in the
domain of the map.

[enrich en (A, B)] returns true if for all a and b such that b \in B
and a \in (A \restrict dom(B)) we have en(a,b).

*)
