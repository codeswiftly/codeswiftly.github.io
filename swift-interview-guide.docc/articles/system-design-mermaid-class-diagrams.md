@PageImage(purpose: card, source: "system-design-mermaid-class-diagrams-card.codex", alt: "Placeholder card")
@Image(source: "system-design-mermaid-class-diagrams-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "system-design-mermaid-class-diagrams-icon.codex", alt: "Placeholder icon")
# Mermaid Class Diagrams (System Design)

@Metadata {
  @TitleHeading("Mermaid class diagrams reference")
  @PageColor(blue)
  @PageImage(purpose: icon, source: "system-design-icon.codex", alt: "System Design icon")
  @PageImage(purpose: card, source: "system-design-card.codex", alt: "System Design card")
}

Use this reference for Mermaid class diagrams when modeling object-oriented system design.

## Overview

Class diagrams show classes, attributes, methods, and relationships. Mermaid renders UML-style
class diagrams with a concise syntax.

## Basic Example

```mermaid
---
title: Animal example
---
classDiagram
    note "From Duck till Zebra"
    Animal <|-- Duck
    note for Duck "can fly\ncan swim\ncan dive\ncan help in debugging"
    Animal <|-- Fish
    Animal <|-- Zebra
    Animal : +int age
    Animal : +String gender
    Animal: +isMammal()
    Animal: +mate()
    class Duck{
        +String beakColor
        +swim()
        +quack()
    }
    class Fish{
        -int sizeInFeet
        -canEat()
    }
    class Zebra{
        +bool is_wild
        +run()
    }
```

@Image(source: "system-design-mermaid-class-diagrams-01-basic-example.codex.svg", alt: "Basic example diagram")



## Class Definition

Define classes either explicitly or via relationships.

```mermaid
classDiagram
    class Animal
    Vehicle <|-- Car
```

@Image(source: "system-design-mermaid-class-diagrams-02-class-definition.codex.svg", alt: "Class definition diagram")



Naming convention: use alphanumeric characters, underscores, and dashes.

## Class Labels

```mermaid
classDiagram
    class Animal["Animal with a label"]
    class Car["Car with *! symbols"]
    Animal --> Car
```

@Image(source: "system-design-mermaid-class-diagrams-03-class-labels.codex.svg", alt: "Class labels diagram")



Escape special characters with backticks:

```mermaid
classDiagram
    class `Animal Class!`
    class `Car Class`
    `Animal Class!` --> `Car Class`
```

@Image(source: "system-design-mermaid-class-diagrams-04-class-labels.codex.svg", alt: "Class labels diagram")



## Members

Use `:` for one member at a time:

```mermaid
classDiagram
class BankAccount
BankAccount : +String owner
BankAccount : +BigDecimal balance
BankAccount : +deposit(amount)
BankAccount : +withdrawal(amount)
```

@Image(source: "system-design-mermaid-class-diagrams-05-members.codex.svg", alt: "Members diagram")



Use `{}` to group members:

```mermaid
classDiagram
class BankAccount{
    +String owner
    +BigDecimal balance
    +deposit(amount)
    +withdrawal(amount)
}
```

@Image(source: "system-design-mermaid-class-diagrams-06-members.codex.svg", alt: "Members diagram")



### Return Types

```mermaid
classDiagram
class BankAccount{
    +String owner
    +BigDecimal balance
    +deposit(amount) bool
    +withdrawal(amount) int
}
```

@Image(source: "system-design-mermaid-class-diagrams-07-members.codex.svg", alt: "Members diagram")



### Generic Types

```mermaid
classDiagram
class Square~Shape~{
    int id
    List~int~ position
    setPoints(List~int~ points)
    getPoints() List~int~
}

Square : -List~string~ messages
Square : +setMessages(List~string~ messages)
Square : +getMessages() List~string~
Square : +getDistanceMatrix() List~List~int~~
```

@Image(source: "system-design-mermaid-class-diagrams-08-members.codex.svg", alt: "Members diagram")



## Visibility and Classifiers

Visibility:

- `+` Public
- `-` Private
- `#` Protected
- `~` Package/Internal

Classifiers:

- `*` Abstract
- `$` Static

## Relationships

```mermaid
classDiagram
classA <|-- classB
classC *-- classD
classE o-- classF
classG <-- classH
classI -- classJ
classK <.. classL
classM <|.. classN
classO .. classP
```

@Image(source: "system-design-mermaid-class-diagrams-09-relationships.codex.svg", alt: "Relationships diagram")



With labels:

```mermaid
classDiagram
classA --|> classB : Inheritance
classC --* classD : Composition
classE --o classF : Aggregation
classG --> classH : Association
classI -- classJ : Link(Solid)
classK ..> classL : Dependency
classM ..|> classN : Realization
classO .. classP : Link(Dashed)
```

@Image(source: "system-design-mermaid-class-diagrams-10-relationships.codex.svg", alt: "Relationships diagram")



### Lollipop Interfaces

```mermaid
classDiagram
  bar ()-- foo
```

@Image(source: "system-design-mermaid-class-diagrams-11-relationships.codex.svg", alt: "Relationships diagram")



## Namespaces

```mermaid
classDiagram
namespace BaseShapes {
    class Triangle
    class Rectangle {
      double width
      double height
    }
}
```

@Image(source: "system-design-mermaid-class-diagrams-12-namespaces.codex.svg", alt: "Namespaces diagram")



## Cardinality Multiplicity

```mermaid
classDiagram
    Customer "1" --> "*" Ticket
    Student "1" --> "1..*" Course
    Galaxy --> "many" Star : Contains
```

@Image(source: "system-design-mermaid-class-diagrams-13-cardinality-multiplicity.codex.svg", alt: "Cardinality / multiplicity diagram")



## Annotations

Inline annotations are not supported by every Mermaid renderer. Use the separate line form for
maximum compatibility:

```mermaid
classDiagram
  class Shape
  <<interface>> Shape
```

@Image(source: "system-design-mermaid-class-diagrams-14-annotations.codex.svg", alt: "Annotations diagram")



Nested:

```mermaid
classDiagram
class Shape{
    <<interface>>
    noOfVertices
    draw()
}
class Color{
    <<enumeration>>
    RED
    BLUE
    GREEN
    WHITE
    BLACK
}
```

@Image(source: "system-design-mermaid-class-diagrams-15-annotations.codex.svg", alt: "Annotations diagram")



## Notes

```mermaid
classDiagram
    note "This is a general note"
    note for MyClass "This is a note for a class"
    class MyClass{
    }
```

@Image(source: "system-design-mermaid-class-diagrams-16-notes.codex.svg", alt: "Notes diagram")



## Direction

```mermaid
classDiagram
  direction RL
  class Student {
    -idCard : IdCard
  }
  class IdCard{
    -id : int
    -name : string
  }
  Student "1" --o "1" IdCard : carries
```

@Image(source: "system-design-mermaid-class-diagrams-17-direction.codex.svg", alt: "Direction diagram")



## Interaction

```mermaid
classDiagram
class Shape
link Shape "https://www.github.com" "This is a tooltip for a link"
class Shape2
click Shape2 href "https://www.github.com" "This is a tooltip for a link"
```

@Image(source: "system-design-mermaid-class-diagrams-18-interaction.codex.svg", alt: "Interaction diagram")



## Styling

```mermaid
classDiagram
  class Animal
  class Mineral
  style Animal fill:#f9f,stroke:#333,stroke-width:4px
  style Mineral fill:#bbf,stroke:#f66,stroke-width:2px,color:#fff,stroke-dasharray: 5 5
```

@Image(source: "system-design-mermaid-class-diagrams-19-styling.codex.svg", alt: "Styling diagram")



```mermaid
classDiagram
    class Animal:::someclass
    classDef someclass fill:#f96
```

@Image(source: "system-design-mermaid-class-diagrams-20-styling.codex.svg", alt: "Styling diagram")



Default class:

```mermaid
classDiagram
  class Animal:::pink
  class Mineral

  classDef default fill:#f96,color:red
  classDef pink color:#f9f
```

@Image(source: "system-design-mermaid-class-diagrams-21-styling.codex.svg", alt: "Styling diagram")



## Configuration

Hide empty members box:

```mermaid
---
config:
  class:
    hideEmptyMembersBox: true
---
classDiagram
  class Duck
```

@Image(source: "system-design-mermaid-class-diagrams-22-configuration.codex.svg", alt: "Configuration diagram")

