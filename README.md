safe-colors
===========

This is a simple program for testing small color palettes suitable
for different kinds of color-blindness.
We produced two palettes that look in theory satisfying. One has 5
colors, the other one has 8 colors. If you happen to be
colorblind, let me know if the colors in a row of
[palettes.html](http://htmlpreview.github.io/?https://github.com/mjambon/safe-colors/master/palettes.html)
look all different.

The 5-color palette uses only 3 RGB levels (0, 1/2, 1),
and any two colors have a different grayscale intensity
(sum of RGB components) and differ by at least two components.

The 8-color palette uses only 4 RGB levels (0, 1/3, 2/3, 1),
and any two colors have a different grayscale intensity
and differ by at least two components.

The program `color.ml` produces an HTML file with 4 different
palettes, each rendered in different ways.
The [result](http://htmlpreview.github.io/?https://github.com/mjambon/safe-colors/master/color.html) is generated using the following command:

```bash
$ ocaml color.ml > color.html
```
