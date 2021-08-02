# coreruleset_map
A map of the OWASP ModSecurity Core Rule Set

The original Graphviz DOT files are available, as well as spiced-up SVG and PDF files.

---

If working with the DOT files, use the label line wrapping script to format the labels nicely (Graphviz itself doesn't support line wrapping, so this needs to be handled separately):

```bash
./label_line_wrap.sh crs_3-3-2.dot
```

The resulting line-wrapped DOT file can then be used as desired.

```bash
# Interactively navigate the map
dot -Tx11 crs_3-3-2_labelwrap.dot

# Export the map to an SVG file
dot -Tsvg crs_3-3-2_labelwrap.dot > crs_map.svg
```
