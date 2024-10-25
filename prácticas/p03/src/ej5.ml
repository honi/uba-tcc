(*
val raiz : poly → float option
val linpoly_client : !(?float.?float.⊕[ Raiz: !float | SinRaiz: end ]) → poly → unit
val linpoly_server : ?(?float.?float.⊕[ Raiz: !float | SinRaiz: end ]) → unit
*)

module S = Session.Bare

type poly = {
    a: float; (* Coeficiente de x *)
    b: float; (* Termino constante *)
}

let raiz (p: poly): float option =
    if p.a = 0.0 then
        None
    else
        Some (-. p.b /. p.a)

let linpoly_client ep (p: poly) =
    let a, b = S.create () in
    let ep = S.send b ep in
    let _ = S.close ep in

    let a = S.send p.a a in
    let a = S.send p.b a in

    match S.branch a with
    | `Raiz a    -> let v, a = S.receive a in
                    Printf.printf "%f\n" v;
                    S.close a
    | `SinRaiz a -> Printf.printf "no hay raíz\n";
                    S.close a

let linpoly_server ep =
    let c, ep = S.receive ep in
    let _ = S.close ep in

    let a, c = S.receive c in
    let b, c = S.receive c in
    let r = raiz {a = a; b = b} in

    match r with
    | Some v -> let c = S.select (fun x -> `Raiz x) c in
                let c = S.send v c in
                S.close c
    | None   -> let c = S.select (fun x -> `SinRaiz x) c in
                S.close c

let _ =
    let a, b = S.create () in
    let _ = Thread.create linpoly_server a in
    linpoly_client b {a = 1.0; b = 2.0}
