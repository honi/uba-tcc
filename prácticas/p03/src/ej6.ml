(*
val max_service : rec X.&[ End: !int | Num: ?int.X ] → int → unit
val max_client : rec X.⊕[ End: ?int | Num: !int.X ] → int list → int
*)

module S = Session.Bare

let rec max_service ep (m: int) =
    match S.branch ep with
    | `Num ep -> let x, ep = S.receive ep in
                 max_service ep (if x > m then x else m)
    | `End ep -> let ep = S.send m ep in
                 S.close ep

let rec max_client ep (nums: int list): int =
    match nums with
    | []      -> let ep = S.select (fun x -> `End x) ep in
                 let max, ep = S.receive ep in
                 S.close ep;
                 max
    | x :: xs -> let ep = S.select (fun x -> `Num x) ep in
                 let ep = S.send x ep in
                 max_client ep xs

let _ =
    let a, b = S.create () in
    let _ = Thread.create (max_service a) 0 in
    let res = max_client b [1;5;2;8;10;3;0;4] in
    Printf.printf "%d\n" res
