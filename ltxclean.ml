  let extensions = [
      ".aux";
      ".bbl";
      ".blg";
      ".log";
      ".out";
      ".toc";
      ".fls";
      ".fdb_latexmk";
      ".synctex.gz";
      ".gz";
      ".dvi";
      ".lof";
      ".lot";
      ".nav";
      ".snm";
      ".vrb";
      ".xdv";
      ".lyx";
      ".texpadtmp";
      ".texpadlog";
      ".pyg";
      ".synctex(busy)";
    ]
  let check_extension filename =
    let file_ext = Filename.extension filename in
    List.exists (fun s -> s = file_ext) extensions

  let check_help arg =
    if String.starts_with ~prefix:"-h" arg then
    true
    else
    false

  let process targ =
  if check_help targ then
      print_endline "Usage: ltxclean [path]\n if [path] omitted, [.] is used as default."
  else
    let files = Sys.readdir targ in
    Array.iter (fun file ->
      let full_path = Filename.concat targ file in
    if Sys.is_regular_file full_path  && check_extension full_path then (
        print_endline ("Removed: " ^ full_path);
        Sys.remove full_path
      )
    ) files

let () =
    try
    match Array.length Sys.argv with
      | 1 -> process "."
      | 2 -> process Sys.argv.(1)
      | _ -> print_endline "Wrong arguments!"
    with
      | Arg.Bad msg -> print_endline ("Error: " ^ msg)
