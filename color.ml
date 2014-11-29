open Printf

let colors = [

  (* All binary RGB combinations *)
  (0., 0., 0.);
  (1., 0., 0.);
  (0., 1., 0.);
  (0., 0., 1.);
  (1., 1., 0.);
  (1., 0., 1.);
  (0., 1., 1.);
  (1., 1., 1.);

  (* Hand-crafted 6-color palette *)
  (0.000, 0.000, 0.000);
  (0.050, 0.200, 0.350);
  (0.550, 0.350, 0.600);
  (0.700, 0.750, 0.650);
  (0.750, 0.900, 0.950);
  (1.000, 1.000, 1.000);

  (*
    5-color palette using only 3 RGB levels (0, 1/2, 1),
    where any two colors have a different grayscale intensity
    (sum of RGB components) and differ by at least two components.
  *)
  (0.000, 0.000, 0.000);
  (0.000, 0.500, 0.500);
  (1.000, 0.500, 0.000);
  (0.500, 1.000, 0.500);
  (1.000, 1.000, 1.000);

  (*
    7-color palette using only 4 RGB levels (0, 1/3, 2/3, 1),
    where any two colors have a different grayscale intensity
    (sum of RGB components) and differ by at least two components.
  *)
  (0.000, 0.000, 0.000);
  (0.000, 0.333, 0.333);
  (0.667, 0.333, 0.000);
  (0.333, 0.667, 0.333);
  (1.000, 0.667, 0.000);
  (1.000, 0.333, 0.667);
  (1.000, 1.000, 1.000);
]

let cell buf (r, g, b) =
  let color =
    sprintf "rgb(%.0f,%.0f,%.0f)" (255. *. r) (255. *. g) (255. *. b)
  in
  bprintf buf "\
<div title=\"%s\" \
     style=\"display: inline-block; \
             background-color: %s; \
             width: 50px; \
             height: 50px; \
             border: dotted black 1px; \
\">
</div>
"
    color color

let row buf filter =
  List.iter (fun rgb ->
    cell buf (filter rgb)
  ) colors

let identity rgb = rgb

let no_red (r, g, b) = (0., g, b)
let no_green (r, g, b) = (r, 0., b)
let no_blue (r, g, b) = (r, g, 0.)

let red_green (r, g, b) =
  let x = (r +. g) /. 2. in
  (x, x, b)

let no_hue (r, g, b) =
  let x = (r +. g +. b) /. 3. in
  (x, x, x)

let palette filter buf name =
  bprintf buf "\
<div>
  <div style=\"width: 100px; \
               vertical-align: middle; \
               display: inline-block;
    \">%s</div>
  <div style=\"vertical-align: middle; \
               display: inline-block;
    \">%a</div>
</div>
"
    name
    row filter

let doc buf () =
  bprintf buf "
<!doctype html>
<html>
  <body>
      %a
      %a
      %a
      %a
      %a
      %a
  </body>
</html>
"
    (palette identity) "Original"
    (palette red_green) "Green = red"
    (palette no_red) "No red"
    (palette no_green) "No green"
    (palette no_blue) "No blue"
    (palette no_hue) "No hue"

let main () =
  let buf = Buffer.create 1000 in
  doc buf ();
  print_string (Buffer.contents buf)

let () = main ()
