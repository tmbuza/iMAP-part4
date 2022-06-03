library(DiagrammeR)
library(DiagrammeRsvg)
library(rsvg)

# 1. Make a graph
graph <- DiagrammeR::grViz("
digraph {
graph [layout = dot, rankdir = TD]

node [
shape = box, 
style = filled, 
fillcolor = white, 
fontname = Helvetica,
penwidth = 2.0] 

edge [arrowhead = diamond]

A [label = 'Getting Started', fillcolor = white, penwidth = 5.0]
B [label = 'Basic Requirements']
C [label = 'Sample Metadata']
D [label = 'Software']
E [label = 'Sequencing Data']
F [label = 'Data Analysis Tools']
G [label = 'Preprocessing Tools']
H [label = 'Bioinformatics Pipelines']

{A}  -> B
{B}  -> C
{B}  -> D
{B}  -> E
{D}  -> F
{D}  -> G
{D}  -> H

}", height = 400, width = 600)

# 2. Convert to SVG, then save as png
part3 = DiagrammeRsvg::export_svg(graph)
part3 = charToRaw(part3) # flatten
rsvg::rsvg_png(part3, "img/part3.png")