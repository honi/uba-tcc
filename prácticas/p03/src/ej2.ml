(*
val raiz : poly → float option
val linpoly_client : !poly.&[ Raiz: ?float | SinRaiz: end ] → poly → unit
val linpoly_server : ?poly.⊕[ Raiz: !float | SinRaiz: end ] → unit
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
    let ep = S.send p ep in

    match S.branch ep with
    | `Raiz ep    -> let v, ep = S.receive ep in
                     Printf.printf "%f\n" v;
                     S.close ep
    | `SinRaiz ep -> Printf.printf "no hay raíz\n";
                     S.close ep

let linpoly_server ep =
    let p, ep = S.receive ep in
    let r = raiz p in

    match r with
    | Some v -> let ep = S.select (fun x -> `Raiz x) ep in
                let ep = S.send v ep in
                S.close ep
    | None   -> let ep = S.select (fun x -> `SinRaiz x) ep in
                S.close ep

let _ =
    let a, b = S.create () in
    let _ = Thread.create linpoly_server a in
    linpoly_client b {a = 1.0; b = 2.0}
