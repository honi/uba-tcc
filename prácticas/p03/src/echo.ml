module S = Session.Bare

let echo_client ep x =
    let ep = S.send x ep in
    let res, ep = S.receive ep in
    S.close ep;
    res

let echo_service ep =
    let x, ep = S.receive ep in
    let ep = S.send x ep in
    S.close ep

let _ =
    let a, b = S.create () in
    let _ = Thread.create echo_service a in
    print_endline (echo_client b "Hello, world!")
