
structure Test =
struct
  fun main (_,_) =
    let
      val () = Utest.tstStart "structure Listsort";
      val a_unsort = Random.randomlist (10000, Random.newgen ());
      val a_sort = Listsort.sort Real.compare a_unsort;
      val test1 = Utest.tst "test1"
        (not (Listsort.sorted Real.compare a_unsort
        orelse Listsort.sorted Real.compare [2.1, 1.0]))

      val test2 = Utest.tst "test2"
        (Listsort.sorted Real.compare a_sort
         andalso Listsort.sorted Real.compare []
         andalso Listsort.sorted Real.compare [1.0, 2.1])
    in
      Utest.tstEnd();
      OS.Process.success
    end
end

