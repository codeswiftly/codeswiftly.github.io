# Mermaid Flowcharts (System Design)


@Metadata {
  @TitleHeading("Mermaid flowcharts reference")
  @PageColor(blue)
}

Use this reference for the valid Mermaid flowchart shapes and syntax when building system design
interview diagrams.

## Flowcharts - Basic Syntax

Flowcharts are composed of nodes (geometric shapes) and edges (arrows or lines). Mermaid code
controls node shapes, edge types, and subgraph grouping.

### Warnings

- If you use the word "end" in a node label, capitalize it ("End" or "END") to avoid breaking the
  diagram.
- If a node label starts with "o" or "x", add a leading space or capitalize the letter (for
  example, " dev---ops" or "dev---Ops").
- Typing "A---oB" creates a circle edge. Typing "A---xB" creates a cross edge.

## Nodes

### Default Node

```mermaid
flowchart LR
    id
```




### Node with Text

```mermaid
flowchart LR
    id1[This is the text in the box]
```




### Unicode Text

Use double quotes around the label.

```mermaid
flowchart LR
    id["This <3 Unicode"]
```




### Markdown Formatting

```mermaid
---
config:
  flowchart:
    htmlLabels: false
---
flowchart LR
    markdown["`This **is** _Markdown_`"]
    newLines["`Line1
    Line 2
    Line 3`"]
    markdown --> newLines
```




## Direction

```mermaid
flowchart TD
    Start --> Stop
```




```mermaid
flowchart LR
    Start --> Stop
```




Valid orientations: `TB`, `TD`, `BT`, `RL`, `LR`.

## Classic Node Shapes

```mermaid
flowchart LR
    round(This is the text in the box)
    stadium([This is the text in the box])
    subroutine[[This is the text in the box]]
    database[(Database)]
    circle((This is the text in the circle))
    asymm>This is the text in the box]
    decision{This is the text in the box}
    hexagon{{This is the text in the box}}
    para[/This is the text in the box/]
    paraAlt[\This is the text in the box\]
    trap[/Christmas\]
    trapAlt[\Go shopping/]
    doubleCircle(((This is the text in the circle)))
```




## Expanded Node Shapes (Mermaid V11.3.0+)

Mermaid supports a general shape syntax for expanded shapes:

```mermaid
flowchart TD
    A@{ shape: rect, label: "This is a process" }
```




### Shape List (Short Names)

| Semantic name | Short name | Description | Aliases |
| --- | --- | --- | --- |
| Bang | bang | Bang | bang |
| Card | notch-rect | Notched rectangle | card, notched-rectangle |
| Cloud | cloud | Cloud | cloud |
| Collate | hourglass | Collate operation | collate, hourglass |
| Com Link | bolt | Communication link | com-link, lightning-bolt |
| Comment | brace-l | Comment (left) | brace-l, comment |
| Comment Right | brace-r | Comment (right) | brace-r |
| Comment Both | braces | Comment (both sides) | braces |
| Data In/Out | lean-r | Input or output | in-out, lean-right |
| Data Out/In | lean-l | Output or input | lean-left, out-in |
| Database | cyl | Database | cylinder, database, db |
| Decision | diam | Decision | decision, diamond, question |
| Delay | delay | Delay | half-rounded-rectangle |
| Direct Access Storage | h-cyl | Direct access storage | das, horizontal-cylinder |
| Disk Storage | lin-cyl | Disk storage | disk, lined-cylinder |
| Display | curv-trap | Display | curved-trapezoid, display |
| Divided Process | div-rect | Divided process | div-proc, divided-process |
| Document | doc | Document | doc, document |
| Event | rounded | Event | event |
| Extract | tri | Extract | extract, triangle |
| Fork/Join | fork | Fork or join | join |
| Internal Storage | win-pane | Internal storage | internal-storage, window-pane |
| Junction | f-circ | Junction | filled-circle, junction |
| Lined Document | lin-doc | Lined document | lined-document |
| Lined Process | lin-rect | Lined process | lin-proc, lined-process, shaded-process |
| Loop Limit | notch-pent | Loop limit | loop-limit, notched-pentagon |
| Manual File | flip-tri | Manual file | flipped-triangle, manual-file |
| Manual Input | sl-rect | Manual input | manual-input, sloped-rectangle |
| Manual Operation | trap-t | Manual operation | inv-trapezoid, manual |
| Multi-Document | docs | Multiple documents | documents, st-doc, stacked-document |
| Multi-Process | st-rect | Multiple processes | processes, procs, stacked-rectangle |
| Odd | odd | Odd shape | odd |
| Paper Tape | flag | Paper tape | paper-tape |
| Prepare Conditional | hex | Prepare conditional | hexagon, prepare |
| Priority Action | trap-b | Priority action | priority, trapezoid-bottom |
| Process | rect | Process | proc, process, rectangle |
| Start | circle | Start | circ |
| Start (small) | sm-circ | Small start | small-circle, start |
| Stop | dbl-circ | Stop | double-circle |
| Stop (framed) | fr-circ | Stop | framed-circle, stop |
| Stored Data | bow-rect | Stored data | bow-tie-rectangle, stored-data |
| Subprocess | fr-rect | Subprocess | framed-rectangle, subproc, subroutine |
| Summary | cross-circ | Summary | crossed-circle, summary |
| Tagged Document | tag-doc | Tagged document | tagged-document |
| Tagged Process | tag-rect | Tagged process | tag-proc, tagged-rectangle |
| Terminal Point | stadium | Terminal point | pill, terminal |
| Text Block | text | Text block | text |

## Special Shapes (Icon, Image)

### Icon

```mermaid
flowchart TD
    A@{ icon: "fa:user", form: "square", label: "User Icon", pos: "t", h: 60 }
```




Parameters: `icon`, `form` (square, circle, rounded), `label`, `pos` (t, b), `h`.

### Image

```mermaid
flowchart TD
    A@{ img: "https://mermaid.js.org/favicon.svg", label: "Image Label", pos: "t", h: 60, constraint: "on" }
```




Parameters: `img`, `label`, `pos`, `w`, `h`, `constraint` (on, off).

## Links Between Nodes

```mermaid
flowchart LR
    A-->B
    A --- B
    A-- text -->B
    A-.->B
    A ==> B
    A ~~~ B
```




Circle and cross edges:

```mermaid
flowchart LR
    A --o B
    A --x B
```




Multi-directional arrows:

```mermaid
flowchart LR
    A o--o B
    B <--> C
    C x--x D
```




### Edge IDs and Animation

```mermaid
flowchart LR
  A e1@--> B
  e1@{ animate: true }
```




```mermaid
flowchart LR
  A e1@--> B
  e1@{ animation: fast }
```




## Subgraphs

```mermaid
flowchart TB
    c1-->a2
    subgraph one
      a1-->a2
    end
    subgraph two
      b1-->b2
    end
```




Direction inside subgraphs:

```mermaid
flowchart LR
  subgraph TOP
    direction TB
    subgraph B1
        direction RL
        i1 --> f1
    end
  end
```




Note: if a subgraph has links to nodes outside it, it inherits the parent direction.

## Markdown Strings

```mermaid
---
config:
  flowchart:
    htmlLabels: false
---
flowchart LR
  subgraph "One"
    a("`The **cat**\n  in the hat`") -- "edge label" --> b{{"`The **dog** in the hog`"}}
  end
```




Disable auto wrapping:

```mermaid
---
config:
  markdownAutoWrap: false
---
graph LR
    Interaction
```




## Interaction

```mermaid
flowchart LR
    A-->B
    B-->C
    click A callback "Tooltip for a callback"
    click B "https://www.github.com" "This is a tooltip for a link"
```




Links open in the same tab by default. Use `_blank` to open new tabs.

## Styling and Classes

```mermaid
flowchart LR
    id1(Start)-->id2(Stop)
    style id1 fill:#f9f,stroke:#333,stroke-width:4px
    style id2 fill:#bbf,stroke:#f66,stroke-width:2px,color:#fff,stroke-dasharray: 5 5
```




```mermaid
flowchart LR
    A:::someclass --> B
    classDef someclass fill:#f96
```




## Configuration

Default renderer is `dagre`. Use `elk` for larger graphs (Mermaid 9.4+):

```yaml
config:
  flowchart:
    defaultRenderer: "elk"
```
