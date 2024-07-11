{ path }: 
let
  inherit (builtins) concatMap readDir filter isAttrs attrValues toPath;

  findNixFilesRec = dir:
    builtins.mapAttrs
    (x: y:
      if y == "directory"
      then findNixFilesRec (toPath dir + "/" + x)
      else (toPath dir + "/" + x))
    (readDir dir);

  nixFilesList = set: let
    valueList = attrValues set;
  in
    concatMap nixFilesList (filter isAttrs valueList) ++ (filter (x: !isAttrs x) valueList);

in nixFilesList (findNixFilesRec path)
