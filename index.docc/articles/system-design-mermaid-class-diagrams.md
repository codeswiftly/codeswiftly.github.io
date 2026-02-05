# Mermaid Class Diagrams (System Design)


@Metadata {
  @TitleHeading("Mermaid class diagrams reference")
  @PageColor(blue)
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




## Class Definition

Define classes either explicitly or via relationships.

```mermaid
classDiagram
    class Animal
    Vehicle <|-- Car
```




Naming convention: use alphanumeric characters, underscores, and dashes.

## Class Labels

```mermaid
classDiagram
    class Animal["Animal with a label"]
    class Car["Car with *! symbols"]
    Animal --> Car
```




Escape special characters with backticks:

```mermaid
classDiagram
    class `Animal Class!`
    class `Car Class`
    `Animal Class!` --> `Car Class`
```




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




### Lollipop Interfaces

```mermaid
classDiagram
  bar ()-- foo
```




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




## Cardinality Multiplicity

```mermaid
classDiagram
    Customer "1" --> "*" Ticket
    Student "1" --> "1..*" Course
    Galaxy --> "many" Star : Contains
```




## Annotations

Inline annotations are not supported by every Mermaid renderer. Use the separate line form for
maximum compatibility:

```mermaid
classDiagram
  class Shape
  <<interface>> Shape
```




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




## Notes

```mermaid
classDiagram
    note "This is a general note"
    note for MyClass "This is a note for a class"
    class MyClass{
    }
```




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




## Interaction

```mermaid
classDiagram
class Shape
link Shape "https://www.github.com" "This is a tooltip for a link"
class Shape2
click Shape2 href "https://www.github.com" "This is a tooltip for a link"
```




## Styling

```mermaid
classDiagram
  class Animal
  class Mineral
  style Animal fill:#f9f,stroke:#333,stroke-width:4px
  style Mineral fill:#bbf,stroke:#f66,stroke-width:2px,color:#fff,stroke-dasharray: 5 5
```




```mermaid
classDiagram
    class Animal:::someclass
    classDef someclass fill:#f96
```




Default class:

```mermaid
classDiagram
  class Animal:::pink
  class Mineral

  classDef default fill:#f96,color:red
  classDef pink color:#f9f
```




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


