(*
val rec_echo_service : rec X.&[ End: end | Msg: ?α.!α.X ] → unit
val rec_echo_client : rec X.⊕[ End: end | Msg: !α.?β.X ] → α list → β list
*)

module S = Session.Bare

let rec rec_echo_service ep =
    match S.branch ep with
    | `Msg ep -> let x, ep = S.receive ep in
                 let ep = S.send x ep in
                 rec_echo_service ep
    | `End ep -> S.close ep

let rec rec_echo_client ep = function
    | []      -> let ep = S.select (fun x -> `End x) ep in
                 S.close ep;
                 []
    | x :: xs -> let ep = S.select (fun x -> `Msg x) ep in
                 let ep = S.send x ep in
                 let y, ep = S.receive ep in
                 y :: rec_echo_client ep xs

let _ =
    let a, b = S.create () in
    let _ = Thread.create rec_echo_service a in
    let res = rec_echo_client b ["uno"; "dos"; "tres"] in
    List.iter (Printf.printf "%s\n") res
