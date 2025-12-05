#import "@local/dtu-template:0.5.1":*
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot, chart
#import "@preview/cetz-venn:0.1.4"
#import "@preview/auto-div:0.1.0": poly-div, poly-div-working

// ═══════════════════════════════════════════════════════════════════════════
// POLYNOMIAL DIVISION DISPLAY FUNCTION (LEGACY)
// ═══════════════════════════════════════════════════════════════════════════
// NOTE: This function is kept for backwards compatibility with other lecture files.
// For new code, use the `auto-div` package instead:
//   $ #poly-div-working((koefficienter), (1, -rod), var: $Z$) $
// ═══════════════════════════════════════════════════════════════════════════

/// DEPRECATED: Use poly-div-working from auto-div package instead.
/// Renders polynomial long division in a clean, readable format.
/// - base: array of terms in the dividend, e.g. ($x^3$, $-5x^2$, $-4x$, $+20$)
/// - steps: array of step tuples: (indent, quotient-term, products, is-subtraction)
///   - indent: how many columns to skip
///   - quotient-term: the term added to quotient (or none)
///   - products: array of terms being multiplied/brought down
///   - is-subtraction: true if this row shows subtraction with hline
/// - divisor: the divisor expression, e.g. $(x - 2)$
#let polynomial-division(base, steps, divisor) = {
  let children = ()
  let results = ()
  for step in steps {
    let indent = step.at(0)
    results.push(step.at(1))
    let products = step.at(2)
    let subtracted = step.at(3)

    children += range(if subtracted { calc.max(0, indent - 1) } else {
      indent
    }).map(_ => [])
    children.push(if subtracted {
      grid.cell(align: right + horizon, inset: 0em, $-($)
    } else { [] })
    children += products.map(x => grid.cell(align: right, x))

    if subtracted {
      children.push(grid.cell(align: left + horizon, inset: 0em, $)$))
      children += range(base.len() - 2 - indent).map(_ => [])
      children.push(grid.hline(start: indent + 1, end: indent + 1 + products.len()))
    } else {
      children += range(base.len() - indent).map(_ => [])
    }
  }
  set grid.cell(inset: (bottom: .3em, top: .3em))
  grid(
    columns: base.len() + 2,
    column-gutter: .3em,
    [],
    ..base,
    [: #divisor = #results.filter(r => r != none).reduce((a, b) => {
        a
        b
      })],
    ..children,
  )
}

#show: dtu-note.with(
  course: "01001",
  course-name: "Mathematics 1a (Polytechnical Foundation)",
  title: "Seb's collection of Mathematical procedures",
  date: datetime.today(),
  author: "Sebastian Faber Steffensen (s255609)",
  semester: "2025 Fall",
)

#set math.mat(delim: "[")
#set math.vec(delim: "[")

#outline()

// ═══════════════════════════════════════════════════════════════════════════
// PART 1: FUNDAMENTAL METHODS & REFERENCE TABLES
// ═══════════════════════════════════════════════════════════════════════════

= Definitioner

== Notation og Symboler

#definition(title: [Spor (Trace)])[
  *Sporet* af en kvadratisk matrix $bold(A) in FF^(n times n)$ er summen af diagonalelementerne:
  $ "tr"(bold(A)) = sum_(i=1)^n a_(i i) = a_(1 1) + a_(2 2) + ... + a_(n n) $

  For $2 times 2$: $"tr"mat(a, b;c, d) = a + d$
]

#definition(title: [Legemer (Fields)])[
  $FF$ betegner et *legeme* (field) — typisk $RR$ (reelle tal) eller $CC$ (komplekse tal).

  $ZZ$ betegner de hele tal, $NN$ betegner de naturlige tal (på DTU: $NN = {1, 2, 3, ...}$, altså *uden* 0).
]


== Udsagnslogik

#definition(title: [Udsagn (Proposition/Statement)])[
  Et *udsagn* er en påstand der enten er sand (S/T) eller falsk (F).
]

#definition(title: [Negation])[
  *Negationen* af $P$, skrevet $not P$ eller $overline(P)$, er sand præcis når $P$ er falsk.
]

#definition(title: [Konjunktion (Conjunction)])[
  *Konjunktionen* $P and Q$ ("$P$ og $Q$") er sand præcis når *både* $P$ og $Q$ er sande.
]

#definition(title: [Disjunktion (Disjunction)])[
  *Disjunktionen* $P or Q$ ("$P$ eller $Q$") er sand præcis når *mindst én* af $P$ eller $Q$ er sand.
]

#definition(title: [Implikation (Implication)])[
  *Implikationen* $P => Q$ ("$P$ medfører $Q$") er falsk *kun* når $P$ er sand og $Q$ er falsk.

  Ækvivalent: $P => Q equiv not P or Q$
]

#definition(
  title: [Biimplikation / Ækvivalens (Biconditional)],
)[
  *Biimplikationen* $P <=> Q$ ("$P$ hvis og kun hvis $Q$") er sand præcis når $P$ og $Q$ har samme sandhedsværdi.
]

#definition(title: [Tautologi (Tautology)])[
  En *tautologi* er et sammensat udsagn der *altid* er sandt, uanset sandhedsværdierne af de atomare udsagn.
]

#definition(title: [Kontradiktion (Contradiction)])[
  En *kontradiktion* er et sammensat udsagn der *altid* er falsk.
]

== Mængder

#definition(title: [Mængde (Set)])[
  En *mængde* er en samling af distinkte objekter kaldet *elementer*.

  $x in A$ betyder "$x$ er element i $A$". $x in.not A$ betyder "$x$ er ikke element i $A$".
]

#definition(title: [Delmængde (Subset)])[
  $A subset.eq B$ betyder at *alle* elementer i $A$ også er i $B$.

  $A subset B$ betyder $A subset.eq B$ og $A eq.not B$ (ægte delmængde).
]

#definition(title: [Fællesmængde / Snit (Intersection)])[
  $ A inter B = {x | x in A "og" x in B} $
  Elementer der er i *både* $A$ og $B$.
]

#definition(title: [Foreningsmængde (Union)])[
  $ A union B = {x | x in A "eller" x in B} $
  Elementer der er i *mindst én* af mængderne.
]

#definition(title: [Differensmængde (Set Difference)])[
  $ A without B = A backslash B = {x | x in A "og" x in.not B} $
  Elementer i $A$ som *ikke* er i $B$.
]

#definition(title: [Tom mængde (Empty Set)])[
  Den *tomme mængde* $emptyset = {}$ indeholder ingen elementer.
]

== Funktioner

#definition(title: [Funktion (Function)])[
  En *funktion* $f: A -> B$ er en regel der til hvert element $a in A$ tildeler præcis ét element $f(a) in B$.
]

#definition(title: [Definitionsmængde / Domæne (Domain)])[
  *Definitionsmængden* (domænet) er mængden $A$ af input-værdier for funktionen $f: A -> B$.
]

#definition(title: [Dispositionsmængde / Kodomæne (Codomain)])[
  *Dispositionsmængden* (kodomænet) er mængden $B$ af *mulige* output-værdier for $f: A -> B$.

  *Bemærk:* På dansk bruges også "værdimængde" for kodomæne, men dette kan forveksles med billedmængden.
]

#definition(title: [Billedmængde (Image/Range)])[
  *Billedmængden* af $f: A -> B$ er mængden af *faktiske* output-værdier:
  $ f(A) = "im"(f) = {f(a) | a in A} subset.eq B $
]

#definition(title: [Injektiv (Injective / One-to-One)])[
  $f: A -> B$ er *injektiv* hvis forskellige input giver forskellige output:
  $ f(a_1) = f(a_2) => a_1 = a_2 $
  Ækvivalent: Hver værdi i $B$ rammes af *højst* ét element fra $A$.
]

#definition(title: [Surjektiv (Surjective / Onto)])[
  $f: A -> B$ er *surjektiv* hvis $f(A) = B$, dvs. *alle* elementer i $B$ rammes.

  Ækvivalent: Hver værdi i $B$ rammes af *mindst* ét element fra $A$.
]

#definition(title: [Bijektiv (Bijective)])[
  $f: A -> B$ er *bijektiv* hvis $f$ er både injektiv og surjektiv.

  Ækvivalent: Hver værdi i $B$ rammes af *præcis* ét element fra $A$.
]

#definition(title: [Invers funktion (Inverse Function)])[
  Hvis $f: A -> B$ er bijektiv, eksisterer den *inverse funktion* $f^(-1): B -> A$ hvor:
  $ f^(-1)(f(a)) = a quad "og" quad f(f^(-1)(b)) = b $
]

== Komplekse Tal

#definition(title: [Komplekst tal (Complex Number)])[
  Et *komplekst tal* har formen $z = a + b i$ hvor $a, b in RR$ og $i^2 = -1$.

  Mængden af komplekse tal betegnes $CC$.
]

#definition(title: [Reel og imaginær del (Real and Imaginary Part)])[
  For $z = a + b i$:
  - *Realdelen*: $"Re"(z) = a$
  - *Imaginærdelen*: $"Im"(z) = b$ (bemærk: $b$, ikke $b i$)
]

#definition(title: [Kompleks konjugeret (Complex Conjugate)])[
  Den *kompleks konjugerede* af $z = a + b i$ er:
  $ overline(z) = a - b i $
  Spejling i den reelle akse.
]

#definition(title: [Modulus / Absolut værdi (Modulus)])[
  *Modulus* af $z = a + b i$ er afstanden fra $0$:
  $ |z| = sqrt(a^2 + b^2) = sqrt(z dot overline(z)) $
]

#definition(title: [Argument (Argument)])[
  *Argumentet* af $z eq.not 0$ er vinklen fra den positive reelle akse:
  $ arg(z) = theta quad "hvor" quad z = |z| e^(i theta) $
  Argumentet er *ikke* entydigt — det er bestemt modulo $2 pi$.
]

#definition(title: [Hovedargument (Principal Argument)])[
  *Hovedargumentet* $"Arg"(z)$ er det unikke argument i intervallet $]-pi, pi]$.
]

#definition(title: [Polær form (Polar Form)])[
  Et komplekst tal på *polær form*:
  $ z = r e^(i theta) = r(cos(theta) + i sin(theta)) $
  hvor $r = |z|$ og $theta = arg(z)$.
]

#definition(title: [Rektangulær form (Rectangular/Cartesian Form)])[
  Et komplekst tal på *rektangulær form*: $z = a + b i$ hvor $a, b in RR$.
]

// ═══════════════════════════════════════════════════════════════════════════
// KOMPLEKSE TAL - UDVIDET SEKTION (FRA GENNEMGANG)
// ═══════════════════════════════════════════════════════════════════════════

== Komplekse Tal - Visualisering og Beregning

#important[
  *De tre vigtigste ting at huske om komplekse tal:*
  1. $i^2 = -1$ (definition af den imaginære enhed)
  2. $e^(i theta) = cos(theta) + i sin(theta)$ (Eulers formel)
  3. Argumentet $arg(z)$ er vinklen fra den positive reelle akse
]

=== Det komplekse plan

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    let scale = 1.5

    // Axes
    line((-3 * scale, 0), (3 * scale, 0), stroke: gray + 1pt, mark: (end: ">", fill: gray))
    line((0, -2.5 * scale), (0, 2.5 * scale), stroke: gray + 1pt, mark: (end: ">", fill: gray))

    content((3 * scale + 0.3, 0), text(size: 10pt)[$"Re"$], anchor: "west")
    content((0, 2.5 * scale + 0.3), text(size: 10pt)[$"Im"$], anchor: "south")

    let a = 2
    let b = 1.5
    let ax = a * scale
    let by = b * scale

    // Point z
    circle((ax, by), radius: 0.1, fill: blue, stroke: black + 1pt)
    content((ax + 0.3, by + 0.3), text(size: 10pt, fill: blue)[$z = a + i b$])

    // Projections
    line((ax, 0), (ax, by), stroke: (paint: red, thickness: 1pt, dash: "dashed"))
    line((0, by), (ax, by), stroke: (paint: green.darken(20%), thickness: 1pt, dash: "dashed"))

    // Radius line
    line((0, 0), (ax, by), stroke: purple + 1.5pt)
    content((ax / 2 - 0.2, by / 2 + 0.3), text(size: 9pt, fill: purple)[$r = |z|$])

    // Angle arc
    arc((0, 0), start: 0deg, stop: calc.atan2(a, b), radius: 0.6, stroke: orange + 1pt)
    content((0.9, 0.25), text(size: 9pt, fill: orange)[$theta$])

    // Labels
    content((ax / 2, -0.3), text(size: 9pt, fill: green.darken(20%))[$a = "Re"(z)$])
    content((-0.5, by / 2), text(size: 9pt, fill: red)[$b = "Im"(z)$], anchor: "east")

    // Tick marks
    line((scale, -0.1), (scale, 0.1), stroke: black)
    content((scale, -0.3), text(size: 8pt)[$1$])
    line((2 * scale, -0.1), (2 * scale, 0.1), stroke: black)
    content((2 * scale, -0.3), text(size: 8pt)[$2$])
    line((-0.1, scale), (0.1, scale), stroke: black)
    content((-0.3, scale), text(size: 8pt)[$i$])
  })
]

=== Konvertering mellem former

#figure(caption: [Konverteringsformler])[
  #table(
    columns: 2,
    align: center,
    stroke: 0.5pt + gray,
    fill: (x, y) => if y == 0 { gray.lighten(80%) } else { none },
    table.header([*Rektangulær → Polær*], [*Polær → Rektangulær*]),
    [$|z| = sqrt(a^2 + b^2)$ \ $theta = arg(z)$ (se formel nedenfor)],
    [$a = |z| cos(theta)$ \ $b = |z| sin(theta)$],
  )
]

=== Argumentet $arg(z)$ — VIGTIG FORMEL

#important[
  *Sætning 4.3.1 — Beregning af argumentet:*

  For $z = a + b i eq.not 0$:
  $
    arg(z) = cases(
      arctan(b/a) & "hvis" a > 0 "(I. eller IV. kvadrant)",
      pi/2 & "hvis" a = 0 "og" b > 0 "(positiv Im-akse)",
      arctan(b/a) + pi & "hvis" a < 0 "(II. eller III. kvadrant)",
      -pi/2 & "hvis" a = 0 "og" b < 0 "(negativ Im-akse)",

    )
  $
]

#note-box[
  *Trin-for-trin til at finde $arg(z)$:*
  1. Tegn punktet $(a, b)$ i det komplekse plan
  2. Bestem hvilken kvadrant punktet ligger i
  3. Beregn $arctan(b/a)$
  4. Juster baseret på kvadrant:
    - Kvadrant I eller IV ($a > 0$): Brug $arctan(b/a)$ direkte
    - Kvadrant II eller III ($a < 0$): Læg $pi$ til
    - På Im-aksen: $plus.minus pi/2$
]

=== CAST-reglen — Fortegn i kvadranter

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    let r = 3.0

    // Quadrant colors
    arc(
      (0, 0),
      start: 0deg,
      stop: 90deg,
      radius: r,
      mode: "PIE",
      fill: rgb(200, 255, 200, 50),
      stroke: none,
      anchor: "origin",
    )
    arc(
      (0, 0),
      start: 90deg,
      stop: 180deg,
      radius: r,
      mode: "PIE",
      fill: rgb(200, 200, 255, 50),
      stroke: none,
      anchor: "origin",
    )
    arc(
      (0, 0),
      start: 180deg,
      stop: 270deg,
      radius: r,
      mode: "PIE",
      fill: rgb(255, 200, 200, 50),
      stroke: none,
      anchor: "origin",
    )
    arc(
      (0, 0),
      start: 270deg,
      stop: 360deg,
      radius: r,
      mode: "PIE",
      fill: rgb(255, 255, 200, 50),
      stroke: none,
      anchor: "origin",
    )

    // Main circle
    circle((0, 0), radius: r, stroke: black + 1.5pt)

    // Axes
    line((-r - 0.5, 0), (r + 0.5, 0), stroke: gray + 1pt, mark: (end: ">", fill: gray))
    line((0, -r - 0.5), (0, r + 0.5), stroke: gray + 1pt, mark: (end: ">", fill: gray))

    // CAST labels
    content((r * 0.5, r * 0.5), text(size: 14pt, fill: rgb(0, 100, 0), weight: "bold")[A])
    content((-r * 0.5, r * 0.5), text(size: 14pt, fill: rgb(0, 0, 150), weight: "bold")[S])
    content((-r * 0.5, -r * 0.5), text(size: 14pt, fill: rgb(150, 0, 0), weight: "bold")[T])
    content((r * 0.5, -r * 0.5), text(size: 14pt, fill: rgb(150, 100, 0), weight: "bold")[C])

    // Quadrant labels
    content((r * 0.5, r * 0.8), text(size: 8pt)[I])
    content((-r * 0.5, r * 0.8), text(size: 8pt)[II])
    content((-r * 0.5, -r * 0.8), text(size: 8pt)[III])
    content((r * 0.5, -r * 0.8), text(size: 8pt)[IV])
  })
]

#note-box[
  *CAST-reglen* (læses mod uret fra IV. kvadrant):
  - *Kvadrant I* (0° -- 90°): #strong[A]lle positive ($sin$, $cos$, $tan$ alle $> 0$)
  - *Kvadrant II* (90° -- 180°): Kun #strong[S]in positiv
  - *Kvadrant III* (180° -- 270°): Kun #strong[T]an positiv
  - *Kvadrant IV* (270° -- 360°): Kun #strong[C]os positiv

  *Huskeregel:* "All Students Take Calculus" — læs mod uret fra I. kvadrant.
]

=== Eksponentialligninger: $e^z = w$

#lemma(name: "4.6.1 — Løsning af eksponentialligninger")[
  For $e^z = w$ med $w in CC$ givet og $z in CC$ søgt:
  $
    z = ln|w| + i(arg(w) + 2pi p), quad p in ZZ
  $
]

#important[
  *Husk altid at angive $p in ZZ$* for at få fuld point! Der er uendeligt mange løsninger.
]

#example(title: "Løs eksponentialligning")[
  Løs $e^z = sqrt(2) + i sqrt(2)$.

  #solution[
    Vi har $w = sqrt(2) + i sqrt(2)$.

    *Trin 1 — Find modulus:*
    $
      |w| = sqrt((sqrt(2))^2 + (sqrt(2))^2) = sqrt(2 + 2) = sqrt(4) = 2
    $

    *Trin 2 — Find argument:*

    Begge dele positive → I. kvadrant, så:
    $
      arg(w) = arctan(sqrt(2) / sqrt(2)) = arctan(1) = pi/4
    $

    *Trin 3 — Anvend formlen:*
    $
      z = ln(2) + i(pi/4 + 2pi p), quad p in ZZ
    $
  ]
]

=== Binomialligninger: $z^n = w$

#note-box[
  *Fremgangsmåde for $z^n = w$:*

  1. Skriv $w$ på polær form: $w = |w| e^(i arg(w))$
  2. Brug formlen:
    $
      z_k = root(n, |w|) dot e^(i(arg(w)/n + (2pi k)/n)), quad k = 0, 1, 2, ..., n-1
    $
  3. Der er præcis $n$ forskellige løsninger (rødderne ligger jævnt fordelt på en cirkel)
]

#example(title: "Løs binomialligning")[
  Løs $z^3 = -i$.

  #solution[
    *Trin 1 — Find modulus og argument af $w = -i$:*
    $
      |-i| = 1, quad arg(-i) = -pi/2
    $
    (Punktet $(0, -1)$ ligger på den negative imaginære akse)

    *Trin 2 — Anvend formlen med $n = 3$:*
    $
      z_k = root(3, 1) dot e^(i(-pi/6 + (2pi k)/3)), quad k = 0, 1, 2
    $

    *Trin 3 — Beregn de tre løsninger:*
    $
      z_0 &= e^(-i pi/6) = cos(-pi/6) + i sin(-pi/6) = sqrt(3)/2 - i/2 \
      z_1 &= e^(i(-pi/6 + 2pi/3)) = e^(i pi/2) = i \
      z_2 &= e^(i(-pi/6 + 4pi/3)) = e^(i 7pi/6) = -sqrt(3)/2 - i/2
    $

    *Verifikation:* $(i)^3 = i^2 dot i = -1 dot i = -i$ ✓
  ]
]

#math-hint[
  *Hurtige checks for komplekse tal:*
  - $|z|^2 = z dot overline(z) = a^2 + b^2$ (altid reelt og ikke-negativt)
  - $|z_1 dot z_2| = |z_1| dot |z_2|$ (modulus multipliceres)
  - $arg(z_1 dot z_2) = arg(z_1) + arg(z_2)$ (argumenter adderes)
  - Kompleks konjugering: $overline(z_1 + z_2) = overline(z_1) + overline(z_2)$
  - Kompleks konjugering: $overline(z_1 dot z_2) = overline(z_1) dot overline(z_2)$

  *MC-gæt:* Rødder til $z^n = w$ ligger altid på en cirkel med radius $root(n, |w|)$, jævnt fordelt med vinkelafstand $2pi/n$.
]

== Polynomier

#definition(title: [Polynomium (Polynomial)])[
  Et *polynomium* i $Z$ over $FF$ er et udtryk:
  $ p(Z) = a_n Z^n + a_(n-1) Z^(n-1) + ... + a_1 Z + a_0 $
  hvor $a_i in FF$ er *koefficienter*.
]

#definition(title: [Grad (Degree)])[
  *Graden* af et polynomium er den højeste potens med ikke-nul koefficient.
  $ deg(a_n Z^n + ... + a_0) = n quad "hvis" a_n eq.not 0 $
]

#definition(title: [Rod / Nulpunkt (Root/Zero)])[
  $z_0$ er en *rod* i $p(Z)$ hvis $p(z_0) = 0$.
]

#definition(title: [Multiplicitet (Multiplicity)])[
  *Multipliciteten* af en rod $z_0$ er det største $m$ så $(Z - z_0)^m$ er en faktor i $p(Z)$.
]

#definition(title: [Diskriminant (Discriminant)])[
  For $a Z^2 + b Z + c$: *Diskriminanten* er $D = b^2 - 4 a c$.
  - $D > 0$: To forskellige reelle rødder
  - $D = 0$: Én dobbeltrod (reel)
  - $D < 0$: To komplekse rødder (konjugerede)
]

== Matricer — Grundlæggende

#definition(title: [Matrix])[
  En *matrix* $bold(A) in FF^(m times n)$ er et rektangulært array med $m$ rækker og $n$ søjler.
  $ bold(A) = mat(a_(1 1), ..., a_(1 n);dots.v, dots.down, dots.v;a_(m 1), ..., a_(m n)) $
]

#definition(title: [Kvadratisk matrix (Square Matrix)])[
  En matrix er *kvadratisk* hvis antal rækker = antal søjler ($m = n$).
]

#definition(title: [Transponeret matrix (Transpose)])[
  Den *transponerede* $bold(A)^T$ fås ved at bytte rækker og søjler:
  $ (bold(A)^T)_(i j) = A_(j i) $
]

#definition(title: [Identitetsmatrix (Identity Matrix)])[
  *Identitetsmatricen* $bold(I)_n$ er $n times n$ matricen med 1-taller på diagonalen og 0 ellers.
]

#definition(title: [Determinant])[
  *Determinanten* $det(bold(A))$ er et tal associeret med en kvadratisk matrix.

  For $2 times 2$: $det mat(a, b;c, d) = a d - b c$

  For $n times n$: Beregnes via cofaktorudvidelse eller rækkeoperationer.
]

#definition(title: [Invertibel / Regulær matrix (Invertible/Nonsingular)])[
  $bold(A) in FF^(n times n)$ er *invertibel* hvis der findes $bold(A)^(-1)$ så:
  $ bold(A) bold(A)^(-1) = bold(A)^(-1) bold(A) = bold(I)_n $

  Ækvivalent: $det(bold(A)) eq.not 0$
]

#definition(title: [Singulær matrix (Singular)])[
  En kvadratisk matrix er *singulær* hvis den *ikke* er invertibel, dvs. $det(bold(A)) = 0$.
]

== Lineære Ligningssystemer

#definition(title: [Lineært ligningssystem (System of Linear Equations)])[
  Et *lineært ligningssystem* er en samling af ligninger:
  $ cases(a_(1 1) x_1 + ... + a_(1 n) x_n = b_1, dots.v, a_(m 1) x_1 + ... + a_(m n) x_n = b_m) $
  Kan skrives som $bold(A) bold(x) = bold(b)$.
]

#definition(title: [Homogent system (Homogeneous System)])[
  Et system er *homogent* hvis $bold(b) = bold(0)$, dvs. alle højresider er 0.

  Homogene systemer har altid mindst løsningen $bold(x) = bold(0)$ (den trivielle løsning).
]

#definition(title: [Inhomogent system (Inhomogeneous System)])[
  Et system er *inhomogent* hvis $bold(b) eq.not bold(0)$.
]

#definition(title: [Totalmatrix / Udvidet matrix (Augmented Matrix)])[
  *Totalmatricen* er matricen $[bold(A) | bold(b)]$ der kombinerer koefficienter og højresider.
]

#definition(title: [Rækkeechelonform / Trappeform (Row Echelon Form)])[
  En matrix er i *rækkeechelonform* hvis:
  1. Alle nulrækker er nederst
  2. Første ikke-nul element i hver række (pivot) er til højre for pivoten i rækken over
]

#definition(title: [Reduceret rækkeechelonform / RREF (Reduced Row Echelon Form)])[
  En matrix er i *RREF* hvis den er i rækkeechelonform og:
  1. Alle pivoter er 1
  2. Pivoterne er de eneste ikke-nul elementer i deres søjle
]

#definition(title: [Pivot])[
  En *pivot* er det ledende (første ikke-nul) element i en række i echelonform.

  *Pivotsøjler* er søjler der indeholder en pivot.
]

#definition(title: [Fri variabel (Free Variable)])[
  En *fri variabel* svarer til en søjle uden pivot i RREF. Kan vælges frit.
]

#definition(title: [Rang (Rank)])[
  *Rangen* af en matrix er antallet af pivoter i dens RREF.
  $ rho(bold(A)) = "rank"(bold(A)) = "antal pivoter" $
]

#definition(title: [Nulitet (Nullity)])[
  *Nuliteten* af $bold(A) in FF^(m times n)$ er:
  $ "null"(bold(A)) = n - "rank"(bold(A)) = "antal frie variable" = dim(ker(bold(A))) $
]

== Vektorrum

#definition(
  title: [Vektorrum (Vector Space)],
)[
  Et *vektorrum* $V$ over $FF$ er en mængde med addition og skalarmultiplikation der opfylder visse aksiomer (lukkethed, associativitet, kommutativitet, etc.).

  Eksempler: $RR^n$, $CC^n$, $RR^(m times n)$, polynomier $PP_n$.
]

#definition(title: [Underrum (Subspace)])[
  $W subset.eq V$ er et *underrum* hvis $W$ selv er et vektorrum, dvs.:
  $ bold(u), bold(v) in W, c in FF => bold(u) + c bold(v) in W $
  (lukket under addition og skalarmultiplikation, indeholder $bold(0)$)
]

#definition(title: [Linearkombination (Linear Combination)])[
  En *linearkombination* af vektorer $bold(v)_1, ..., bold(v)_k$ er:
  $ c_1 bold(v)_1 + c_2 bold(v)_2 + ... + c_k bold(v)_k quad "hvor" c_i in FF $
]

#definition(title: [Span / Udspænding (Span)])[
  *Spannet* af vektorer er mængden af alle linearkombinationer:
  $ "span"(bold(v)_1, ..., bold(v)_k) = {c_1 bold(v)_1 + ... + c_k bold(v)_k | c_i in FF} $
]

#definition(title: [Lineært uafhængig (Linearly Independent)])[
  Vektorer $bold(v)_1, ..., bold(v)_k$ er *lineært uafhængige* hvis:
  $ c_1 bold(v)_1 + ... + c_k bold(v)_k = bold(0) quad => quad c_1 = ... = c_k = 0 $
  Den eneste måde at få $bold(0)$ er med alle koefficienter = 0.
]

#definition(
  title: [Lineært afhængig (Linearly Dependent)],
)[
  Vektorer er *lineært afhængige* hvis de *ikke* er lineært uafhængige, dvs. mindst én vektor kan skrives som linearkombination af de andre.
]

#definition(title: [Basis])[
  En *basis* for $V$ er en mængde vektorer der er:
  1. Lineært uafhængige
  2. Udspænder $V$
]

#definition(title: [Ordnet basis (Ordered Basis)])[
  En *ordnet basis* er en basis hvor rækkefølgen er specificeret: $(bold(v)_1, bold(v)_2, ..., bold(v)_n)$.

  Koordinater afhænger af rækkefølgen!
]

#definition(title: [Standardbasis (Standard Basis)])[
  *Standardbasen* for $RR^n$ er $(bold(e)_1, ..., bold(e)_n)$ hvor $bold(e)_i$ har 1 i position $i$ og 0 ellers.
]

#definition(title: [Dimension])[
  *Dimensionen* $dim(V)$ er antallet af vektorer i en basis for $V$.

  Alle baser for samme vektorrum har samme antal elementer.
]

#definition(
  title: [Koordinater (Coordinates)],
)[
  *Koordinaterne* af $bold(v)$ mht. ordnet basis $beta = (bold(b)_1, ..., bold(b)_n)$ er koefficienterne $(c_1, ..., c_n)$ så:
  $ bold(v) = c_1 bold(b)_1 + ... + c_n bold(b)_n $
  Skrives $[bold(v)]_beta = vec(c_1, dots.v, c_n)$
]

== Lineære Afbildninger

#definition(title: [Lineær afbildning (Linear Map/Transformation)])[
  $L: V -> W$ er en *lineær afbildning* hvis:
  1. $L(bold(u) + bold(v)) = L(bold(u)) + L(bold(v))$
  2. $L(c bold(v)) = c L(bold(v))$

  for alle $bold(u), bold(v) in V$ og $c in FF$.
]

#definition(title: [Kerne / Nulrum (Kernel/Null Space)])[
  *Kernen* af $L: V -> W$ er:
  $ ker(L) = {bold(v) in V | L(bold(v)) = bold(0)} $
  Mængden af vektorer der afbildes til nulvektoren. Altid et underrum af $V$.
]

#definition(title: [Billedrum (Image/Range)])[
  *Billedrummet* af $L: V -> W$ er:
  $ "im"(L) = {L(bold(v)) | bold(v) in V} $
  Mængden af alle output-vektorer. Altid et underrum af $W$.
]

#definition(title: [Søjlerum (Column Space)])[
  *Søjlerummet* af $bold(A)$ er spannet af søjlerne i $bold(A)$:
  $ "colsp"(bold(A)) = "span"{"søjler i" bold(A)} = "im"(L_bold(A)) $
]

#definition(title: [Rækkerum (Row Space)])[
  *Rækkerummet* af $bold(A)$ er spannet af rækkerne i $bold(A)$:
  $ "row"(bold(A)) = "span"{"rækker i" bold(A)} = "colsp"(bold(A)^T) $
]

#definition(
  title: [Afbildningsmatrix (Transformation Matrix)],
)[
  *Afbildningsmatricen* $amat(L, gamma, beta)$ repræsenterer $L: V -> W$ mht. baser $beta$ for $V$ og $gamma$ for $W$:
  $ [L(bold(v))]_gamma = amat(L, gamma, beta) dot [bold(v)]_beta $
  Søjlerne er koordinaterne af $L(bold(b)_i)$ i basis $gamma$.
]

#definition(title: [Basisskiftematrix (Change of Basis Matrix)])[
  *Basisskiftematricen* $amat("id", gamma, beta)$ konverterer koordinater fra basis $beta$ til basis $gamma$:
  $ [bold(v)]_gamma = amat("id", gamma, beta) dot [bold(v)]_beta $
]

== Egenværdier og Diagonalisering

#definition(title: [Egenværdi (Eigenvalue)])[
  $lambda in FF$ er en *egenværdi* for $bold(A)$ hvis der findes $bold(v) eq.not bold(0)$ så:
  $ bold(A) bold(v) = lambda bold(v) $
]

#definition(title: [Egenvektor (Eigenvector)])[
  $bold(v) eq.not bold(0)$ er en *egenvektor* for $bold(A)$ med egenværdi $lambda$ hvis:
  $ bold(A) bold(v) = lambda bold(v) $
  Vektoren skaleres (ikke roteres) af $bold(A)$.
]

#definition(title: [Egenrum (Eigenspace)])[
  *Egenrummet* for egenværdi $lambda$ er:
  $ E_lambda = ker(bold(A) - lambda bold(I)) = {bold(v) | bold(A) bold(v) = lambda bold(v)} $
  Indeholder alle egenvektorer til $lambda$ plus nulvektoren.
]

#definition(title: [Karakteristisk polynomium (Characteristic Polynomial)])[
  Det *karakteristiske polynomium* for $bold(A) in FF^(n times n)$ er:
  $ p_(bold(A))(Z) = det(bold(A) - Z bold(I)) $
  Egenværdierne er rødderne i $p_(bold(A))(Z) = 0$.
]

#definition(
  title: [Algebraisk multiplicitet (Algebraic Multiplicity)],
)[
  Den *algebraiske multiplicitet* $"am"(lambda)$ er multipliciteten af $lambda$ som rod i det karakteristiske polynomium.
]

#definition(title: [Geometrisk multiplicitet (Geometric Multiplicity)])[
  Den *geometriske multiplicitet* $"gm"(lambda)$ er dimensionen af egenrummet:
  $ "gm"(lambda) = dim(E_lambda) = dim(ker(bold(A) - lambda bold(I))) $

  Altid: $1 <= "gm"(lambda) <= "am"(lambda)$
]

#definition(title: [Diagonaliserbar (Diagonalizable)])[
  $bold(A)$ er *diagonaliserbar* hvis der findes invertibel $bold(P)$ og diagonal $bold(D)$ så:
  $ bold(A) = bold(P) bold(D) bold(P)^(-1) quad "eller ækvivalent" quad bold(P)^(-1) bold(A) bold(P) = bold(D) $

  Ækvivalent: $"gm"(lambda) = "am"(lambda)$ for alle egenværdier.
]

#definition(title: [Similære matricer (Similar Matrices)])[
  $bold(A)$ og $bold(B)$ er *similære* hvis der findes invertibel $bold(P)$ så:
  $ bold(B) = bold(P)^(-1) bold(A) bold(P) $
  Similære matricer har samme egenværdier, determinant, rang og spor.
]

== Differentialligninger

#definition(title: [Differentialligning (Differential Equation)])[
  En *differentialligning* er en ligning der involverer en ukendt funktion og dens afledede.
]

#definition(title: [Orden (Order)])[
  *Ordenen* af en differentialligning er den højeste afledede der optræder.

  $f''(t) + f'(t) = 0$ har orden 2.
]

#definition(
  title: [Lineær differentialligning (Linear ODE)],
)[
  En differentialligning er *lineær* hvis den ukendte funktion og dens afledede kun optræder i første potens og ikke multipliceres med hinanden.

  *Lineær:* $f''(t) + 3f'(t) + 2f(t) = g(t)$

  *Ikke-lineær:* $f'(t) dot f(t) = 1$ eller $(f'(t))^2 = f(t)$
]

#definition(title: [Homogen differentialligning (Homogeneous ODE)])[
  En lineær differentialligning er *homogen* hvis højresiden er 0:
  $ a_n f^((n))(t) + ... + a_1 f'(t) + a_0 f(t) = 0 $
]

#definition(title: [Inhomogen differentialligning (Inhomogeneous ODE)])[
  En lineær differentialligning er *inhomogen* hvis højresiden $g(t) eq.not 0$:
  $ a_n f^((n))(t) + ... + a_1 f'(t) + a_0 f(t) = g(t) $
]

#definition(title: [Begyndelsesværdiproblem / IVP (Initial Value Problem)])[
  Et *begyndelsesværdiproblem* er en differentialligning sammen med betingelser ved et bestemt punkt:
  $ f'(t) = g(t, f(t)), quad f(t_0) = y_0 $
]

#definition(title: [Fuldstændig løsning (General Solution)])[
  Den *fuldstændige løsning* indeholder alle løsninger, typisk med frie konstanter $c_1, c_2, ...$.
]

#definition(
  title: [Partikulær løsning (Particular Solution)],
)[
  En *partikulær løsning* er én specifik løsning (ofte uden frie konstanter, eller med bestemte værdier fra begyndelsesbetingelser).
]

#definition(
  title: [Karakteristisk ligning (Characteristic Equation)],
)[
  For en lineær ODE med konstante koefficienter er den *karakteristiske ligning* den polynomielle ligning man får ved at substituere $f(t) = e^(lambda t)$.

  For $f''(t) + a f'(t) + b f(t) = 0$: Karakteristisk ligning er $lambda^2 + a lambda + b = 0$.
]

== Sætninger — Hurtig Reference

#definition(title: [Rang-Nulitets-sætningen (Rank-Nullity Theorem)])[
  For $bold(A) in FF^(m times n)$:
  $ "rank"(bold(A)) + "null"(bold(A)) = n $
  Antal pivoter + antal frie variable = antal søjler.
]

#definition(title: [De Moivres formel (De Moivre's Formula)])[
  For $z = r e^(i theta)$ og $n in ZZ$:
  $ z^n = r^n e^(i n theta) $

  For $n$-te rødder af $w = r e^(i theta)$:
  $ z_k = root(n, r) e^(i (theta + 2 pi k)/n), quad k = 0, 1, ..., n-1 $
]

#definition(title: [Eulers formel (Euler's Formula)])[
  $ e^(i theta) = cos(theta) + i sin(theta) $
]

= Fundamentale Metoder og Referencetabeller

== FOIL - Multiplikation af parenteser

#note-box[
  *FOIL* står for: #strong[F]irst, #strong[O]uter, #strong[I]nner, #strong[L]ast

  For $(a + b)(c + d)$:
  - #strong[F]irst: $a dot c$
    - #strong[O]uter: $a dot d$
      - #strong[I]nner: $b dot c$
        - #strong[L]ast: $b dot d$

  $ (a + b)(c + d) = a c + a d + b c + b d $
]

#example(title: [FOIL med tal])[
  Beregn $(3 + 2)(5 - 4)$

  #solution()[
    - F: $3 dot 5 = 15$
    - O: $3 dot (-4) = -12$
    - I: $2 dot 5 = 10$
    - L: $2 dot (-4) = -8$

    $ (3 + 2)(5 - 4) = 15 - 12 + 10 - 8 = 5 $
  ]
]

#example(title: [FOIL med komplekse tal])[
  Beregn $(2 + 3i)(4 - i)$

  #solution()[
    - F: $2 dot 4 = 8$
    - O: $2 dot (-i) = -2i$
    - I: $3i dot 4 = 12i$
    - L: $3i dot (-i) = -3i^2 = -3(-1) = 3$

    $ (2 + 3i)(4 - i) = 8 - 2i + 12i + 3 = 11 + 10i $
  ]
]

#example(
  title: [FOIL i karakteristiske polynomier],
)[
  Givet $bold(A) = mat(2, -5;1, -2)$. Beregn det karakteristiske polynomium $p_(bold(A))(Z) = det(bold(A) - Z bold(I))$.

  #solution()[
    *Trin 1:* Opstil $bold(A) - Z bold(I)_n$:
    $ bold(A) - Z bold(I)_2 = mat(2-Z, -5;1, -2-Z) $

    *Trin 2:* Beregn determinanten:
    $ det = (2-Z)(-2-Z) - (-5)(1) $

    *Trin 3:* Anvend FOIL på $(2-Z)(-2-Z)$:
    - #strong[F]irst: $2 dot (-2) = -4$
    - #strong[O]uter: $2 dot (-Z) = -2Z$
    - #strong[I]nner: $(-Z) dot (-2) = 2Z$
    - #strong[L]ast: $(-Z) dot (-Z) = Z^2$

    $ (2-Z)(-2-Z) = -4 - 2Z + 2Z + Z^2 = Z^2 - 4 $

    *Trin 4:* Færdiggør:
    $ p_(bold(A))(Z) = (Z^2 - 4) - (-5) = Z^2 - 4 + 5 = Z^2 + 1 $

    *Rødder:* $Z^2 = -1 => Z = plus.minus i$

    Egenværdier: $lambda_1 = i$, $lambda_2 = -i$
  ]
]

#note-box[
  *Typiske fejl ved karakteristiske polynomier:*

  1. *Fortegnsfejl i FOIL:* Vær særlig opmærksom på $(a - Z)(d - Z)$ — alle fire led!

  2. *Glemmer at trække $b c$ fra:* $det mat(a-Z, b;c, d-Z) = (a-Z)(d-Z) bold(- b c)$

  3. *Hurtig formel for $2 times 2$:* Brug i stedet:
    $ p_(bold(A))(Z) = Z^2 - "tr"(bold(A)) dot Z + det(bold(A)) $
    hvor $"tr"(bold(A)) = a + d$ og $det(bold(A)) = a d - b c$

  *Verificér med hurtig formel:*
  - $"tr"(bold(A)) = 2 + (-2) = 0$
  - $det(bold(A)) = 2 dot (-2) - (-5) dot 1 = -4 + 5 = 1$
  - $p_(bold(A))(Z) = Z^2 - 0 dot Z + 1 = Z^2 + 1$
]

#example(
  title: [Konjugerede komplekse tal],
)[
  Beregn $(a + b i)(a - b i)$

  #solution()[
    - F: $a dot a = a^2$
    - O: $a dot (-b i) = -a b i$
    - I: $b i dot a = a b i$
    - L: $b i dot (-b i) = -b^2 i^2 = b^2$

    $ (a + b i)(a - b i) = a^2 - a b i + a b i + b^2 = a^2 + b^2 $

    *Huskeregel:* $(a + b i)(a - b i) = a^2 + b^2 = |z|^2$
  ]

  #math-hint(
    )[
    *Genveje:*
    - $(a+b)(a-b) = a^2 - b^2$ — ingen mellemled!
    - $(a+b)^2 = a^2 + 2a b + b^2$
    - $(a-b)^2 = a^2 - 2a b + b^2$
    - Kompleks konjugat: $(a+b i)(a-b i) = a^2 + b^2$ — altid reelt og positivt

    *MC-gæt:* Hvis svarmuligheder indeholder $a^2 - b^2$ eller $a^2 + b^2$, er det sandsynligvis konjugat/differens af kvadrater.
  ]
]

== Radianer og Grader - Konverteringstabel

#note-box[
  *Konverteringsformler:*

  $ "radianer" = "grader" times pi/180 $
  $ "grader" = "radianer" times 180/pi $

  *Huskeregel:* $180° = pi$ radianer
]

#align(center)[
  #table(
    columns: 4,
    align: center,
    stroke: 0.5pt,
    [*Grader*],
    [*Radianer*],
    [*Brøk af $pi$*],
    [*Decimal*],
    [$0°$],
    [$0$],
    [$0$],
    [$0$],
    [$30°$],
    [$pi/6$],
    [$1/6 pi$],
    [$approx 0.52$],
    [$45°$],
    [$pi/4$],
    [$1/4 pi$],
    [$approx 0.79$],
    [$60°$],
    [$pi/3$],
    [$1/3 pi$],
    [$approx 1.05$],
    [$90°$],
    [$pi/2$],
    [$1/2 pi$],
    [$approx 1.57$],
    [$120°$],
    [$(2pi)/3$],
    [$2/3 pi$],
    [$approx 2.09$],
    [$135°$],
    [$(3pi)/4$],
    [$3/4 pi$],
    [$approx 2.36$],
    [$150°$],
    [$(5pi)/6$],
    [$5/6 pi$],
    [$approx 2.62$],
    [$180°$],
    [$pi$],
    [$pi$],
    [$approx 3.14$],
    [$270°$],
    [$(3pi)/2$],
    [$3/2 pi$],
    [$approx 4.71$],
    [$360°$],
    [$2pi$],
    [$2 pi$],
    [$approx 6.28$],
  )
]

#math-hint()[
  *Du behøver kun at huske:*
  - $30° = pi/6$, $45° = pi/4$, $60° = pi/3$, $90° = pi/2$
  - Alt andet er multipla af disse

  *Hurtig konvertering:* $pi approx 3.14$, så $pi/6 approx 0.5$, $pi/4 approx 0.8$, $pi/3 approx 1$

  *MC-gæt:* Vinkler i eksamensopgaver er næsten altid multipla af $pi/6$ eller $pi/4$.
]

== Trigonometriske Værdier - Referencetabel

#align(center)[
  #table(
    columns: 5,
    align: center,
    stroke: 0.5pt,
    [*Vinkel $theta$*],
    [*Grader*],
    [$cos(theta)$],
    [$sin(theta)$],
    [$tan(theta)$],
    [$0$],
    [$0°$],
    [$1$],
    [$0$],
    [$0$],
    [$pi/6$],
    [$30°$],
    [$sqrt(3)/2$],
    [$1/2$],
    [$1/sqrt(3)$],
    [$pi/4$],
    [$45°$],
    [$sqrt(2)/2$],
    [$sqrt(2)/2$],
    [$1$],
    [$pi/3$],
    [$60°$],
    [$1/2$],
    [$sqrt(3)/2$],
    [$sqrt(3)$],
    [$pi/2$],
    [$90°$],
    [$0$],
    [$1$],
    [udef.],
    [$(2pi)/3$],
    [$120°$],
    [$-1/2$],
    [$sqrt(3)/2$],
    [$-sqrt(3)$],
    [$(3pi)/4$],
    [$135°$],
    [$-sqrt(2)/2$],
    [$sqrt(2)/2$],
    [$-1$],
    [$(5pi)/6$],
    [$150°$],
    [$-sqrt(3)/2$],
    [$1/2$],
    [$-1/sqrt(3)$],
    [$pi$],
    [$180°$],
    [$-1$],
    [$0$],
    [$0$],
    [$(7pi)/6$],
    [$210°$],
    [$-sqrt(3)/2$],
    [$-1/2$],
    [$1/sqrt(3)$],
    [$(5pi)/4$],
    [$225°$],
    [$-sqrt(2)/2$],
    [$-sqrt(2)/2$],
    [$1$],
    [$(4pi)/3$],
    [$240°$],
    [$-1/2$],
    [$-sqrt(3)/2$],
    [$sqrt(3)$],
    [$(3pi)/2$],
    [$270°$],
    [$0$],
    [$-1$],
    [udef.],
    [$(5pi)/3$],
    [$300°$],
    [$1/2$],
    [$-sqrt(3)/2$],
    [$-sqrt(3)$],
    [$(7pi)/4$],
    [$315°$],
    [$sqrt(2)/2$],
    [$-sqrt(2)/2$],
    [$-1$],
    [$(11pi)/6$],
    [$330°$],
    [$sqrt(3)/2$],
    [$-1/2$],
    [$-1/sqrt(3)$],
  )
]

#math-hint()[
  *Mønster at huske:*
  - $sin$ og $cos$ bytter værdier ved komplementære vinkler: $sin(30°) = cos(60°)$
  - Ved $45°$: $sin = cos = sqrt(2)/2 approx 0.71$
  - $sin(0°) = 0$, $sin(90°) = 1$ — starter fra 0, vokser til 1
  - $cos(0°) = 1$, $cos(90°) = 0$ — starter fra 1, falder til 0

  *Talværdier:* $1/2 = 0.5$, $sqrt(2)/2 approx 0.71$, $sqrt(3)/2 approx 0.87$
]


== Eksponentregler

#align(center)[
  #figure(caption: [Potensregler / Exponent rules])[
    #table(
      columns: 2,
      align: center,
      stroke: 0.5pt + gray,
      fill: (x, y) => if y == 0 { gray.lighten(80%) } else { none },
      table.header([*Regel*], [*Eksempel*]),
      [$a^m a^n = a^(m+n)$], [$2^3 2^4 = 2^(7)$],
      [$(a^m)^n = a^(m n)$], [$ (3^2)^4 = 3^8$],
      [$(a b)^n = a^n b^n$], [$ (2x)^3 = 8 x^3$],
      [$a^0 = 1 "for" a != 0 $], [$5^0 = 1$],
      [$a^(-n) = 1 / a^n$], [$2^(-3) = 1/8$],
    )
  ]
]


== CAST-reglen (Fortegn i kvadranter)

#note-box[
  Hvilke trigonometriske funktioner er *positive* i hver kvadrant:

  #align(center)[
    #table(
      columns: 2,
      stroke: 0.5pt,
      align: center,
      [*Kvadrant II* \ $sin > 0$ \ $(pi/2 < theta < pi)$],
      [*Kvadrant I* \ *Alle* $> 0$ \ $(0 < theta < pi/2)$],
      [*Kvadrant III* \ $tan > 0$ \ $(pi < theta < 3pi/2)$],
      [*Kvadrant IV* \ $cos > 0$ \ $(3pi/2 < theta < 2pi)$],
    )
  ]

  Læs mod uret fra kvadrant IV: *C*os, *A*lle, *S*in, *T*an = *CAST*
]

#math-hint(
  )[
  *Huskeregel:* "All Students Take Calculus" — læs mod uret fra kvadrant I.

  *Hurtig check:* Hvis du får en negativ $cos$-værdi, er du i kvadrant II eller III.

  *MC-gæt:* Hvis en opgave spørger om fortegn, er svaret ofte det "uventede" — dvs. den funktion der skifter fortegn i den givne kvadrant.
]

== Enhedscirklen - Komplet Figur

#align(
  center,
)[
  #figure(
    caption: [Den Komplette Enhedscirkel - Trigonometri, Komplekse Tal og Koordinater],
  )[
    #cetz.canvas(
      {
        import cetz.draw: *

        let r = 4.0 // Større radius for bedre læsbarhed

        // ═══════════════════════════════════════════════════════════════
        // BAGGRUND: Kvadrant-farver (CAST-reglen)
        // ═══════════════════════════════════════════════════════════════
        // Kvadrant I (0° til 90°): ALLE positive - lysegrøn
        arc(
          (0, 0),
          start: 0deg,
          stop: 90deg,
          radius: r,
          mode: "PIE",
          fill: rgb(200, 255, 200, 40),
          stroke: none,
          anchor: "origin",
        )
        // Kvadrant II (90° til 180°): SIN positiv - lyseblå
        arc(
          (0, 0),
          start: 90deg,
          stop: 180deg,
          radius: r,
          mode: "PIE",
          fill: rgb(200, 200, 255, 40),
          stroke: none,
          anchor: "origin",
        )
        // Kvadrant III (180° til 270°): TAN positiv - lyserød
        arc(
          (0, 0),
          start: 180deg,
          stop: 270deg,
          radius: r,
          mode: "PIE",
          fill: rgb(255, 200, 200, 40),
          stroke: none,
          anchor: "origin",
        )
        // Kvadrant IV (270° til 360°): COS positiv - lysegul
        arc(
          (0, 0),
          start: 270deg,
          stop: 360deg,
          radius: r,
          mode: "PIE",
          fill: rgb(255, 255, 200, 40),
          stroke: none,
          anchor: "origin",
        )

        // ═══════════════════════════════════════════════════════════════
        // HOVEDCIRKEL
        // ═══════════════════════════════════════════════════════════════
        circle((0, 0), radius: r, stroke: (paint: black, thickness: 1.5pt))

        // ═══════════════════════════════════════════════════════════════
        // AKSER med pile
        // ═══════════════════════════════════════════════════════════════
        // x-akse (Real akse / cos-akse)
        line((-r - 1.0, 0), (r + 1.0, 0), stroke: (paint: gray, thickness: 1pt), mark: (end: "stealth", fill: gray))
        // y-akse (Imaginær akse / sin-akse)
        line((0, -r - 1.0), (0, r + 1.0), stroke: (paint: gray, thickness: 1pt), mark: (end: "stealth", fill: gray))

        // Akseetiketter
        content((r + 1.3, 0), text(weight: "bold")[$x = cos(theta) = "Re"$], anchor: "west")
        content((0, r + 1.3), text(weight: "bold")[$y = sin(theta) = "Im"$], anchor: "south")

        // ═══════════════════════════════════════════════════════════════
        // CAST-REGEL ETIKETTER (i hver kvadrant)
        // ═══════════════════════════════════════════════════════════════
        content((r * 0.5, r * 0.5), text(size: 10pt, fill: rgb(0, 100, 0))[
          #box(fill: rgb(200, 255, 200, 150), inset: 3pt, radius: 2pt)[#strong[A]lle $+$]
        ])
        content((-r * 0.5, r * 0.5), text(size: 10pt, fill: rgb(0, 0, 150))[
          #box(fill: rgb(200, 200, 255, 150), inset: 3pt, radius: 2pt)[#strong[S]in $+$]
        ])
        content((-r * 0.5, -r * 0.5), text(size: 10pt, fill: rgb(150, 0, 0))[
          #box(fill: rgb(255, 200, 200, 150), inset: 3pt, radius: 2pt)[#strong[T]an $+$]
        ])
        content((r * 0.5, -r * 0.5), text(size: 10pt, fill: rgb(150, 100, 0))[
          #box(fill: rgb(255, 255, 200, 150), inset: 3pt, radius: 2pt)[#strong[C]os $+$]
        ])

        // ═══════════════════════════════════════════════════════════════
        // KVADRANT-NUMRE (romertal i hjørnerne)
        // ═══════════════════════════════════════════════════════════════
        content((r * 0.85, r * 0.85), text(size: 8pt, fill: gray)[I])
        content((-r * 0.85, r * 0.85), text(size: 8pt, fill: gray)[II])
        content((-r * 0.85, -r * 0.85), text(size: 8pt, fill: gray)[III])
        content((r * 0.85, -r * 0.85), text(size: 8pt, fill: gray)[IV])

        // ═══════════════════════════════════════════════════════════════
        // ALLE 16 VIGTIGE VINKLER MED KOMPLETTE DATA
        // Format: (grader, radianer-label, cos-værdi, sin-værdi, kompleks-form)
        // ═══════════════════════════════════════════════════════════════
        let angles = (
          // Grad 0 (Kvadrant I/IV grænse)
          (0, $0$, $1$, $0$, $1$),
          // Kvadrant I
          (30, $pi/6$, $sqrt(3)/2$, $1/2$, $e^(i pi/6)$),
          (45, $pi/4$, $sqrt(2)/2$, $sqrt(2)/2$, $e^(i pi/4)$),
          (60, $pi/3$, $1/2$, $sqrt(3)/2$, $e^(i pi/3)$),
          (90, $pi/2$, $0$, $1$, $i$),
          // Kvadrant II
          (120, $(2pi)/3$, $-1/2$, $sqrt(3)/2$, $e^(i 2pi/3)$),
          (135, $(3pi)/4$, $-sqrt(2)/2$, $sqrt(2)/2$, $e^(i 3pi/4)$),
          (150, $(5pi)/6$, $-sqrt(3)/2$, $1/2$, $e^(i 5pi/6)$),
          (180, $pi$, $-1$, $0$, $-1$),
          // Kvadrant III
          (210, $(7pi)/6$, $-sqrt(3)/2$, $-1/2$, $e^(i 7pi/6)$),
          (225, $(5pi)/4$, $-sqrt(2)/2$, $-sqrt(2)/2$, $e^(i 5pi/4)$),
          (240, $(4pi)/3$, $-1/2$, $-sqrt(3)/2$, $e^(i 4pi/3)$),
          (270, $(3pi)/2$, $0$, $-1$, $-i$),
          // Kvadrant IV
          (300, $(5pi)/3$, $1/2$, $-sqrt(3)/2$, $e^(i 5pi/3)$),
          (315, $(7pi)/4$, $sqrt(2)/2$, $-sqrt(2)/2$, $e^(i 7pi/4)$),
          (330, $(11pi)/6$, $sqrt(3)/2$, $-1/2$, $e^(i 11pi/6)$),
        )

        // ═══════════════════════════════════════════════════════════════
        // TEGN ALLE VINKLER
        // ═══════════════════════════════════════════════════════════════
        for (deg, rad_label, cos_val, sin_val, complex_form) in angles {
          let rad = deg * calc.pi / 180
          let x = r * calc.cos(rad)
          let y = r * calc.sin(rad)

          // Radial linje fra origin til punkt (stiplet)
          line((0, 0), (x, y), stroke: (paint: blue.darken(20%), thickness: 0.6pt, dash: "dashed"))

          // Punkt på cirklen
          circle((x, y), radius: 0.08, fill: blue, stroke: (paint: white, thickness: 0.5pt))

          // Projektionslinjer til akserne (hjælpelinjer for at vise cos og sin)
          if deg != 0 and deg != 180 {
            line((x, 0), (x, y), stroke: (paint: red.lighten(30%), thickness: 0.4pt, dash: "dotted"))
          }
          if deg != 90 and deg != 270 {
            line((0, y), (x, y), stroke: (paint: green.lighten(30%), thickness: 0.4pt, dash: "dotted"))
          }
        }

        // ═══════════════════════════════════════════════════════════════
        // GRADTAL PÅ YDERSIDEN AF CIRKLEN
        // ═══════════════════════════════════════════════════════════════
        let deg_radius = r + 0.35
        for (deg, rad_label, cos_val, sin_val, complex_form) in angles {
          let rad = deg * calc.pi / 180
          let x = deg_radius * calc.cos(rad)
          let y = deg_radius * calc.sin(rad)

          // Bestem ankerpunkt baseret på vinkel
          let anchor = if deg == 0 { "west" } else if deg < 90 { "south-west" } else if deg == 90 { "south" } else if deg < 180 { "south-east" } else if deg == 180 { "east" } else if deg < 270 { "north-east" } else if deg == 270 { "north" } else { "north-west" }

          content((x, y), text(size: 7pt, fill: gray.darken(20%))[#deg°], anchor: anchor)
        }

        // ═══════════════════════════════════════════════════════════════
        // RADIANER PÅ INDERSIDEN AF CIRKLEN
        // ═══════════════════════════════════════════════════════════════
        let rad_radius = r - 0.45
        for (deg, rad_label, cos_val, sin_val, complex_form) in angles {
          let rad = deg * calc.pi / 180
          let x = rad_radius * calc.cos(rad)
          let y = rad_radius * calc.sin(rad)

          // Bestem ankerpunkt (modsat af grader)
          let anchor = if deg == 0 { "east" } else if deg < 90 { "north-east" } else if deg == 90 { "north" } else if deg < 180 { "north-west" } else if deg == 180 { "west" } else if deg < 270 { "south-west" } else if deg == 270 { "south" } else { "south-east" }

          content((x, y), text(size: 6pt, fill: purple.darken(20%))[$#rad_label$], anchor: anchor)
        }

        // ═══════════════════════════════════════════════════════════════
        // KOORDINATER (cos, sin) VED HVERT PUNKT
        // Placeret længere ude for læsbarhed
        // ═══════════════════════════════════════════════════════════════
        let coord_radius = r + 1.0
        for (deg, rad_label, cos_val, sin_val, complex_form) in angles {
          let rad = deg * calc.pi / 180
          let x = coord_radius * calc.cos(rad)
          let y = coord_radius * calc.sin(rad)

          // Juster position for akseværdier
          let (adj_x, adj_y) = if deg == 0 { (x + 0.2, y - 0.3) } else if deg == 90 { (x + 0.5, y + 0.2) } else if deg == 180 { (x - 0.2, y - 0.3) } else if deg == 270 { (x + 0.5, y - 0.2) } else { (x, y) }

          // Bestem ankerpunkt
          let anchor = if deg == 0 { "north-west" } else if deg < 90 { "south-west" } else if deg == 90 { "south-west" } else if deg < 180 { "south-east" } else if deg == 180 { "north-east" } else if deg < 270 { "north-east" } else if deg == 270 { "north-west" } else { "north-west" }

          // Kun vis koordinater for ikke-aksepunkter (aksepunkter vises separat)
          if deg != 0 and deg != 90 and deg != 180 and deg != 270 {
            content(
              (adj_x, adj_y),
              text(size: 5.5pt)[#box(fill: white.darken(5%), inset: 1pt, radius: 1pt)[$(#cos_val, #sin_val)$]],
              anchor: anchor,
            )
          }
        }

        // ═══════════════════════════════════════════════════════════════
        // AKSEPUNKTER (specielle værdier) - større og tydeligere
        // ═══════════════════════════════════════════════════════════════
        // (1, 0) ved 0°
        content((r + 0.15, -0.35), text(size: 7pt)[
          #box(fill: white, inset: 2pt, radius: 2pt, stroke: 0.3pt + gray)[
            $(1, 0)$ \ $= 1$
          ]
        ], anchor: "north-west")

        // (0, 1) ved 90°
        content((0.35, r + 0.15), text(size: 7pt)[
          #box(fill: white, inset: 2pt, radius: 2pt, stroke: 0.3pt + gray)[
            $(0, 1)$ \ $= i$
          ]
        ], anchor: "south-west")

        // (-1, 0) ved 180°
        content((-r - 0.15, -0.35), text(size: 7pt)[
          #box(fill: white, inset: 2pt, radius: 2pt, stroke: 0.3pt + gray)[
            $(-1, 0)$ \ $= -1$
          ]
        ], anchor: "north-east")

        // (0, -1) ved 270°
        content((0.35, -r - 0.15), text(size: 7pt)[
          #box(fill: white, inset: 2pt, radius: 2pt, stroke: 0.3pt + gray)[
            $(0, -1)$ \ $= -i$
          ]
        ], anchor: "north-west")

        // ═══════════════════════════════════════════════════════════════
        // AKSEMARKERINGER (tick marks ved ±1)
        // ═══════════════════════════════════════════════════════════════
        // x-akse tick marks
        line((r, -0.1), (r, 0.1), stroke: black)
        line((-r, -0.1), (-r, 0.1), stroke: black)
        // y-akse tick marks
        line((-0.1, r), (0.1, r), stroke: black)
        line((-0.1, -r), (0.1, -r), stroke: black)

        // ═══════════════════════════════════════════════════════════════
        // EKSEMPEL-VINKEL θ MED VISUALISERING
        // Tegner en eksempel vinkel ved 45° med forklaring
        // ═══════════════════════════════════════════════════════════════
        let example_deg = 45
        let example_rad = example_deg * calc.pi / 180
        let ex = r * calc.cos(example_rad)
        let ey = r * calc.sin(example_rad)

        // Tykkere linje for eksemplet
        line((0, 0), (ex, ey), stroke: (paint: orange, thickness: 2pt), name: "example-line")

        // Vinkelmarkering (bue fra x-aksen til linjen)
        arc(
          (0, 0),
          start: 0deg,
          stop: 45deg,
          radius: 0.8,
          stroke: (paint: orange, thickness: 1.5pt),
          mark: (end: "stealth", fill: orange, scale: 0.5),
        )

        // θ label ved vinklen
        content((1.0, 0.35), text(size: 10pt, fill: orange, weight: "bold")[$theta$])

        // Fremhæv projektioner for eksemplet
        line((ex, 0), (ex, ey), stroke: (paint: red, thickness: 1.5pt), name: "sin-line")
        line((0, ey), (ex, ey), stroke: (paint: green.darken(20%), thickness: 1.5pt), name: "cos-line")
        line((0, 0), (ex, 0), stroke: (paint: green.darken(20%), thickness: 1.5pt))

        // Labels for cos og sin projektioner
        content((ex / 2, -0.25), text(size: 8pt, fill: green.darken(20%), weight: "bold")[$cos(theta)$])
        content((ex + 0.35, ey / 2), text(size: 8pt, fill: red, weight: "bold")[$sin(theta)$])

        // Radius = 1 label
        content((ex / 2 - 0.15, ey / 2 + 0.25), text(size: 7pt, fill: orange)[$r = 1$], anchor: "south-east")

        // ═══════════════════════════════════════════════════════════════
        // NØGLE-FORMLER I BUNDEN
        // ═══════════════════════════════════════════════════════════════
        content((0, -r - 2.2), text(size: 8pt)[
          #box(fill: rgb(245, 245, 255), inset: 6pt, radius: 3pt, stroke: 0.5pt + gray)[
            #std.grid(
              columns: 3,
              gutter: 15pt,
              [#strong[Eulers formel:] \ $e^(i theta) = cos(theta) + i sin(theta)$],
              [#strong[Koordinat:] \ $(cos(theta), sin(theta))$],
              [#strong[Kompleks tal:] \ $z = e^(i theta) = cos(theta) + i sin(theta)$],
            )
          ]
        ])

        // ═══════════════════════════════════════════════════════════════
        // EKSTRA: Vigtige trigonometriske værdier tabel (til højre)
        // ═══════════════════════════════════════════════════════════════
        content((r + 3.5, 0), text(size: 6pt)[
          #box(fill: white, inset: 4pt, radius: 2pt, stroke: 0.5pt + gray)[
            #table(
              columns: 3,
              align: center,
              stroke: 0.3pt + gray,
              inset: 2pt,
              [*θ*],
              [$cos$],
              [$sin$],
              [$0$],
              [$1$],
              [$0$],
              [$pi/6$],
              [$sqrt(3)/2$],
              [$1/2$],
              [$pi/4$],
              [$sqrt(2)/2$],
              [$sqrt(2)/2$],
              [$pi/3$],
              [$1/2$],
              [$sqrt(3)/2$],
              [$pi/2$],
              [$0$],
              [$1$],
            )
          ]
        ], anchor: "west")
      },
    )
  ]
]

#note-box[
  *Sådan læser du enhedscirklen:*

  1. *Vinklen $theta$* måles fra den positive $x$-akse (mod uret er positiv)

  2. *Koordinaterne* $(x, y)$ på cirklen er $(cos(theta), sin(theta))$

  3. *Komplekst tal*: Punktet svarer til $z = e^(i theta) = cos(theta) + i sin(theta)$

  4. *CAST-reglen* fortæller hvilke funktioner er positive:
    - #strong[Kvadrant I] ($0° - 90°$): #strong[A]lle positive
    - #strong[Kvadrant II] ($90° - 180°$): Kun #strong[S]in positiv
    - #strong[Kvadrant III] ($180° - 270°$): Kun #strong[T]an positiv
    - #strong[Kvadrant IV] ($270° - 360°$): Kun #strong[C]os positiv

  5. *Huske-værdier*: $sqrt(3)/2 approx 0.87$, $sqrt(2)/2 approx 0.71$, $1/2 = 0.5$
]

== Vigtige komplekse tal på polær form

#note-box[
  *De fire "akseværdier":*
  $ 1 = e^(i dot 0) = cos(0) + i sin(0) $
  $ i = e^(i pi/2) = cos(pi/2) + i sin(pi/2) $
  $ -1 = e^(i pi) = cos(pi) + i sin(pi) $
  $ -i = e^(-i pi/2) = e^(i 3pi/2) = cos(-pi/2) + i sin(-pi/2) $
]

== Det Karakteristiske Polynomium - Formler

#note-box[
  *For $2 times 2$ matricer:*

  Givet $bold(A) = mat(a, b;c, d)$:

  $ bold(A) - Z bold(I) = mat(a - Z, b;c, d - Z) $

  $ det(bold(A) - Z bold(I)) = (a - Z)(d - Z) - b c $

  *VIGTIGT - udvid $(a - Z)(d - Z)$ korrekt:*

  Brug FOIL:
  $ (a - Z)(d - Z) = a d - a Z - d Z + Z^2 = Z^2 - (a + d)Z + a d $

  Så det karakteristiske polynomium er:
  $ p_(bold(A))(Z) = Z^2 - (a + d)Z + (a d - b c) $

  *Huskeregel:* For $2 times 2$: $p_(bold(A))(Z) = Z^2 - "tr"(bold(A)) Z + det(bold(A))$

  hvor $"tr"(bold(A)) = a + d$ (sporet) og $det(bold(A)) = a d - b c$
]

#note-box[
  *Faktorer polynomiet: Tre metoder*

  *Metode 1: Kvadratisk formel (altid sikker)*
  $ Z = (-b plus.minus sqrt(b^2 - 4 a c))/(2a) $

  For $Z^2 + p Z + q = 0$ (hvor $a = 1$):
  $ Z = (-p plus.minus sqrt(p^2 - 4q))/2 $

  *Metode 2: Faktorisering via gæt (hurtig når det virker)*

  Søg tal $r, s$ så:
  - $r + s = -p$ (summen af rødderne)
  - $r dot s = q$ (produktet af rødderne)

  Så: $Z^2 + p Z + q = (Z - r)(Z - s)$

  *Metode 3: Genkend specielle former*
  - $Z^2 - k^2 = (Z - k)(Z + k)$ (differens af kvadrater)
  - $Z^2 - 2k Z + k^2 = (Z - k)^2$ (perfekt kvadrat)
]

#math-hint()[
  *$2 times 2$ shortcut:* Brug ALTID formlen $p_(bold(A))(Z) = Z^2 - "tr"(bold(A)) Z + det(bold(A))$
  - Hurtigere end FOIL
  - Færre fortegnsfejl

  *Instant egenværdier for specielle matricer:*
  - Triangulær matrix: Egenværdier = diagonalelementerne
  - Diagonal matrix: Egenværdier = diagonalelementerne
  - $det(bold(A)) = 0$: Mindst én egenværdi er $0$

  *Tjek dit svar:*
  - $lambda_1 + lambda_2 = "tr"(bold(A))$
  - $lambda_1 dot lambda_2 = det(bold(A))$
]

// ═══════════════════════════════════════════════════════════════════════════
// PART 2: TOPICS BY CURRICULUM ORDER
// ═══════════════════════════════════════════════════════════════════════════

= Uge 1: Udsagnslogik (Propositional Logic)

== Vurdér om et logisk udtryk er en tautologi

#note-box[
  En *tautologi* er et udtryk, der altid er sandt. To ækvivalente udsagn udgør en tautologi.

  *Metode 1: Sandhedstabeller (den sikre vej)*
  1. Referér til eksempel 1.3.1 og 1.3.2
  2. Opstil en stor tabel med plads til mange rækker og kolonner
  3. Tilføj alle standardudsagn ($P$, $Q$, $R$, osv.) og udfyld alle kombinationer ($2^n$ rækker, hvor $n$ = antal udsagn)
  4. Tilføj sandhedsværdier for alle dele af begge udsagn i nye kolonner
  5. Tilføj en kolonne for logisk ækvivalens - er output altid T, er det en tautologi

  *Metode 2: Uden sandhedstabeller*
  1. Referér til sætning 1.3.1, 1.3.2, 1.3.3, 1.3.4 efter behov
  2. Brug at ækvivalente udtryk kan substitueres
  3. Når du når simple udtryk på begge sider, lav en sandhedstabel for disse
]

#math-hint()[
  *Implikation $P => Q$:*
  - Kun falsk når $P$ er sand og $Q$ er falsk
  - "Falsk impliserer alt" — hvis $P$ er falsk, er $P => Q$ altid sand

  *Tautologi-tjek:* Find ÉN kombination hvor udtrykket er falsk — så er det IKKE en tautologi.

  *MC-gæt:* Hvis der spørges "er dette en tautologi?", prøv $P = T, Q = F$ først — det afslører ofte svaret.
]

= Uge 2: Mængder og Funktioner

== Alle løsninger til ligning med absolutværdi

#note-box[
  *Fremgangsmåde:* (Ingen sætninger at referere til - forklar hvert trin)

  1. *Udvid absolutværdier* ved at opstille grænseværdier for alle dele med $|...|$
  2. *Opdel i intervaller* baseret på hvor udtrykkene skifter fortegn
  3. *Håndtér hvert interval:*
    - Fjern absolutværdier baseret på intervallet
    - Simplificér og løs for $x$
    - Tjek om løsningen ligger inden for intervallet
  4. *Saml løsninger* fra alle intervaller i én løsningsmængde
]

#math-hint()[
  *Absolutværdi-ligninger $|f(x)| = k$:*
  - $k < 0$: Ingen løsninger
  - $k = 0$: Løs $f(x) = 0$
  - $k > 0$: Løs $f(x) = k$ OG $f(x) = -k$

  *Antal løsninger:* Typisk 0, 1, eller 2 — sjældent mere i eksamensopgaver.

  *MC-gæt:* Hvis én svarmulighed er $emptyset$ (tom mængde), overvej om $k < 0$ eller ligningen er umulig.
]

= Uge 3-4: Komplekse Tal

== Trigonometri og Komplekse Tal

#note-box[
  *Eulers formel:*
  $ e^(i theta) = cos(theta) + i sin(theta) $

  *Konvertering mellem former:*

  *Rektangulær til polær:*
  $ z = a + b i quad => quad r = sqrt(a^2 + b^2), quad theta = arctan(b/a) $

  *Polær til rektangulær:*
  $ z = r e^(i theta) quad => quad a = r cos(theta), quad b = r sin(theta) $
]

== Argument-tjekliste (hvilken kvadrant?)

#note-box[
  Givet $z = a + b i$, bestem $theta = arg(z)$:

  #align(center)[
    #table(
      columns: 3,
      stroke: 0.5pt,
      [*Betingelse*],
      [*Kvadrant*],
      [*Argument $theta$*],
      [$a > 0, b >= 0$],
      [I],
      [$arctan(b/a)$],
      [$a < 0$],
      [II eller III],
      [$arctan(b/a) + pi$],
      [$a > 0, b < 0$],
      [IV],
      [$arctan(b/a)$ eller $arctan(b/a) + 2pi$],
      [$a = 0, b > 0$],
      [Pos. im. akse],
      [$pi/2$],
      [$a = 0, b < 0$],
      [Neg. im. akse],
      [$-pi/2$ eller $3pi/2$],
    )
  ]
]

== Komplekse tal på polær form i n'te potens

#note-box[
  *Fremgangsmåde:*
  1. Referér til definition 4.6.1 og opskriv på polær form
  2. Referér til sætning 4.6.2 (De Moivre) for at opløfte til n'te potens:
  $ z^n = (r e^(i theta))^n = r^n e^(i n theta) $
]

== Omdannelse mellem polær og rektangulær form

#note-box[
  *Polær til rektangulær:*

  Bemærk at sætning 4.4.1 sat op mod sætning 4.6.1 medfører:
  $ z(cos(arg(z)) + i sin(arg(z))) = z dot e^(i dot arg(z)) $

  Udregn $cos$ og $sin$ via Appendix A.1

  *Rektangulær til polær:*

  Aflæs modulus og argument efter sætning 4.3.1:
  $ r = |z| = sqrt(a^2 + b^2), quad theta = arctan(b/a) $
]

#example(title: [Konvertér $z = 1 + i$ til polær form])[
  #solution()[
    *Trin 1:* Find modulus
    $ r = |z| = sqrt(1^2 + 1^2) = sqrt(2) $

    *Trin 2:* Find argument (vinkel)
    $ theta = arctan(1/1) = arctan(1) = pi/4 $
    (Punktet ligger i 1. kvadrant, så $theta = pi/4$ er korrekt)

    *Trin 3:* Skriv på polær form
    $ z = sqrt(2) e^(i pi/4) $

    *Verifikation:*
    $ sqrt(2) e^(i pi/4) = sqrt(2)(cos(pi/4) + i sin(pi/4)) = sqrt(2)(sqrt(2)/2 + i sqrt(2)/2) = 1 + i $
  ]
]

#example(title: [Konvertér $z = -1 + sqrt(3) i$ til polær form])[
  #solution()[
    *Trin 1:* Find modulus
    $ r = sqrt((-1)^2 + (sqrt(3))^2) = sqrt(1 + 3) = 2 $

    *Trin 2:* Find argument

    Basis: $arctan(sqrt(3)/(-1)) = arctan(-sqrt(3))$

    Men pas på! Punktet ligger i *2. kvadrant* (negativ reel del, positiv imaginær del).

    Referencevinkel: $arctan(sqrt(3)) = pi/3$

    I 2. kvadrant: $theta = pi - pi/3 = (2pi)/3$

    *Trin 3:* Polær form
    $ z = 2 e^(i 2pi/3) $
  ]
]

== Samtlige komplekse løsninger til eksponentialligning

#note-box[
  *Fremgangsmåde for $e^z = w$:*

  1. Referér til lemma 4.6.1 og udtryk $z$ som $ln(|w|) + arg(w) i$
  2. Referér til sætning 4.3.1 for at finde $|w|$ og $arg(w)$
  3. Indsæt og forkort
  4. Angiv samtlige løsninger som $ln(|w|) + arg(w) i$ hvor $arg(w) = "Arg"(w) + 2k pi$, $k in ZZ$

  *Forklaring:* Enhver løsning udgjort af hovedargumentet adderet med et multiplum af $2pi$ skyldes at vi for hver $2pi$ er nået en hel tur rundt i enhedscirklen.
]

== Omregning med modulus og argumenter

#note-box[
  *Fremgangsmåde:*

  1. Alle regneregler findes via sætning 4.6.2:
    - $|z_1 dot z_2| = |z_1| dot |z_2|$
    - $arg(z_1 dot z_2) = arg(z_1) + arg(z_2)$
    - $|z^n| = |z|^n$
    - $arg(z^n) = n dot arg(z)$
  2. Referér til sætning 4.3.1 for $|w|$ og $arg(w)$
  3. Find hovedargumentet i $]-pi; pi]$ ved at addere/subtrahere $2pi$
]

== Multiplikation og division på polær form

#note-box[
  *Multiplikation:* Gang moduli, læg argumenter sammen
  $ z_1 dot z_2 = r_1 e^(i theta_1) dot r_2 e^(i theta_2) = r_1 r_2 e^(i(theta_1 + theta_2)) $

  *Division:* Divider moduli, træk argumenter fra hinanden
  $ z_1 / z_2 = (r_1 e^(i theta_1))/(r_2 e^(i theta_2)) = r_1/r_2 e^(i(theta_1 - theta_2)) $

  *Potens (De Moivre):*
  $ z^n = (r e^(i theta))^n = r^n e^(i n theta) $
]

#example(title: [Beregn $(1 + i)^8$])[
  #solution()[
    *Trin 1:* Konvertér til polær form
    $ 1 + i = sqrt(2) e^(i pi/4) $

    *Trin 2:* Anvend De Moivre
    $ (1 + i)^8 = (sqrt(2))^8 e^(i dot 8 dot pi/4) = 2^4 e^(i 2pi) = 16 e^(i 2pi) = 16 dot 1 = 16 $

    *Svar:* $(1 + i)^8 = 16$
  ]
]

== Konjugering på polær form

#note-box[
  Hvis $z = r e^(i theta)$, så er
  $ overline(z) = r e^(-i theta) $

  (Samme modulus, negativ vinkel - spejling i den reelle akse)
]

#math-hint()[
  *Modulus-genveje:*
  - $|e^(i theta)| = 1$ for ALLE $theta$
  - $|z dot w| = |z| dot |w|$
  - $|z^n| = |z|^n$
  - $|overline(z)| = |z|$

  *Polær form instant:*
  - $1 = e^(i dot 0)$, $-1 = e^(i pi)$, $i = e^(i pi/2)$, $-i = e^(-i pi/2)$

  *Komplekse rødder:* Hvis koefficienterne er reelle, kommer komplekse rødder ALTID i konjugerede par.

  *MC-gæt for "hvilken ligger længst fra 0":* Beregn $|z|$ — ofte er $|r e^(i theta)| = r$ det hurtigste tjek.
]

#math-hint()[
  *$n$-te rødder:* Der er PRÆCIS $n$ forskellige rødder, jævnt fordelt på en cirkel.

  *Vinkelafstand mellem rødder:* $(2pi)/n$

  *Hurtig tjek:* Hvis $z^n = w$ og $|w| = 1$, så har alle rødder $|z| = 1$ (ligger på enhedscirklen).

  *MC-gæt:* Rødder til $z^n = 1$ er altid $e^(i 2pi k/n)$ for $k = 0, 1, ..., n-1$.
]

= Uge 5: Polynomier og Induktion

== Rødder i komplekst andengradspolynomium

#note-box[
  *Fremgangsmåde:*
  1. Henvis til sætning 5.2.1
  2. Udregn diskriminanten (evt. henvis til definition 5.2.1):
    $ D = b^2 - 4 a c $
  3. Følg fremgangsmetoden fra sætning 5.2.1:
    $ Z = (-b plus.minus sqrt(D))/(2a) $

  *Bemærk:* Diskriminanten har dualitet - den afgør om rødder er reelle eller komplekse.
]

== Divisionsalgoritmen til at undersøge rod

#important[
  *Polynomiumsdivision og Rødder — EKSAMENSKLASSIKER!*

  *Opgavetype:* Givet $p(Z)$ og én rod $lambda$, find faktorisering og alle rødder.

  *Strategi:*
  1. Hvis $lambda$ er rod → $(Z - lambda)$ er faktor
  2. Divider $p(Z)$ med $(Z - lambda)$ → får $q(Z)$ af grad én lavere
  3. Løs $q(Z) = 0$ (ofte 2. gradsligning → brug diskriminant)
]

#note-box[
  *Fremgangsmåde: Polynomiumsdivision i hånden*

  *Givet:* Polynomium $p(Z)$ og oplyst at $Z = r$ er rod.

  *Find:* Faktorisering og samtlige rødder i $CC$.

  *Trin 1 — Verificér roden (valgfrit men godt at tjekke):*
  $ p(r) = 0 quad checkmark $

  *Trin 2 — Udfør polynomiumsdivision:*

  Da $Z = r$ er rod, er $(Z - r)$ en faktor. Udfør lang division:

  + Tag det *ledende led* i dividenden, divider med $Z$
    - Eksempel: $2Z^3 div Z = 2Z^2$ → første led i kvotienten
  + *Gang* divisoren $(Z - r)$ med dette led
    - Eksempel: $2Z^2 dot (Z - 3) = 2Z^3 - 6Z^2$
  + *Træk fra* dividenden og få en ny rest
    - *VIGTIGT:* Husk parentesen! $(2Z^3 - 2Z^2) - (2Z^3 - 6Z^2) = 2Z^3 - 2Z^2 - 2Z^3 + 6Z^2 = 4Z^2$
  + *Gentag* med resten indtil graden er lavere end divisorens grad

  *Trin 3 — Løs kvotienten:*
  - Hvis $q(Z)$ er 2. grad: Brug diskriminantformlen
  - Hvis $q(Z)$ er højere grad: Gentag polynomiumsdivision med andre rødder

  *Trin 4 — Skriv komplet faktorisering:*
  $ p(Z) = a_n (Z - r_1)(Z - r_2) dots.c (Z - r_n) $

  hvor $a_n$ er den ledende koefficient.
]

#note-box[
  *VIGTIGT: Subtraktion med parenteser*

  Ved polynomiumsdivision skal man *trække fra* produktet. Husk at minustegnet gælder HELE parentesen:

  $ (2Z^3 - 2Z^2) - (2Z^3 - 6Z^2) $

  *Forkert:* $2Z^3 - 2Z^2 - 2Z^3 - 6Z^2 = -8Z^2$ ✗

  *Korrekt:* $2Z^3 - 2Z^2 - 2Z^3 + 6Z^2 = 4Z^2$ ✓

  Minustegnet foran parentesen ændrer fortegn på ALLE led inde i parentesen!
]

== Polynomiumsdivision — Hurtig Referencetabel

#important[
  *Almindelige divisioner at huske!*

  Ved polynomiumsdivision skal man ofte hurtigt finde: "Hvad gange $Z$ giver...?"

  Denne tabel hjælper med de mest almindelige tilfælde.
]

#align(center)[
  #table(
    columns: 3,
    stroke: 0.5pt,
    inset: 8pt,
    [*Ønsket led*],
    [*Divisor* $(Z - r)$],
    [*Kvotient-led*],
    [$Z^3$],
    [$Z$],
    [$Z^2$],
    [$2Z^3$],
    [$Z$],
    [$2Z^2$],
    [$3Z^3$],
    [$Z$],
    [$3Z^2$],
    [$-Z^3$],
    [$Z$],
    [$-Z^2$],
    [$Z^2$],
    [$Z$],
    [$Z$],
    [$2Z^2$],
    [$Z$],
    [$2Z$],
    [$4Z^2$],
    [$Z$],
    [$4Z$],
    [$-3Z^2$],
    [$Z$],
    [$-3Z$],
    [$6Z^2$],
    [$Z$],
    [$6Z$],
    [$Z$],
    [$Z$],
    [$1$],
    [$2Z$],
    [$Z$],
    [$2$],
    [$-4Z$],
    [$Z$],
    [$-4$],
    [$8Z$],
    [$Z$],
    [$8$],
  )
]

#note-box[
  *Generel regel:*

  For at finde kvotient-leddet: $("ledende led i dividend") div Z$

  - $a Z^n div Z = a Z^(n-1)$
  - Koefficienten beholdes, graden sænkes med 1
]

#align(center)[
  #table(
    columns: 4,
    stroke: 0.5pt,
    inset: 8pt,
    [*Kvotient-led*],
    [*Divisor* $(Z - r)$],
    [*Produkt*],
    [*Eksempel* ($r = 3$)],
    [$2Z^2$],
    [$(Z - 3)$],
    [$2Z^3 - 6Z^2$],
    [$2Z^2 dot Z = 2Z^3$, $2Z^2 dot (-3) = -6Z^2$],
    [$4Z$],
    [$(Z - 3)$],
    [$4Z^2 - 12Z$],
    [$4Z dot Z = 4Z^2$, $4Z dot (-3) = -12Z$],
    [$4$],
    [$(Z - 3)$],
    [$4Z - 12$],
    [$4 dot Z = 4Z$, $4 dot (-3) = -12$],
    [$-2Z^2$],
    [$(Z + 2)$],
    [$-2Z^3 - 4Z^2$],
    [$-2Z^2 dot Z = -2Z^3$, $-2Z^2 dot 2 = -4Z^2$],
    [$3Z$],
    [$(Z - 1)$],
    [$3Z^2 - 3Z$],
    [$3Z dot Z = 3Z^2$, $3Z dot (-1) = -3Z$],
    [$-5$],
    [$(Z + 1)$],
    [$-5Z - 5$],
    [$-5 dot Z = -5Z$, $-5 dot 1 = -5$],
  )
]

#lemma(name: "2. Gradsformel (Diskriminant)")[
  For $a Z^2 + b Z + c = 0$:
  $ Z = frac(-b plus.minus sqrt(b^2 - 4 a c), 2a) = frac(-b plus.minus sqrt(D), 2a) $

  - $D > 0$: To reelle rødder
  - $D = 0$: Én dobbeltrod
  - $D < 0$: To komplekse rødder $Z = frac(-b, 2a) plus.minus i frac(sqrt(|D|), 2a)$

  *Bemærk:* Komplekse rødder kommer altid i konjugerede par når koefficienterne er reelle!
]

#example(title: [Polynomiumsdivision — E24 Opgave 2 (Komplet løsning)])[
  *Givet:* $p(Z) = 2Z^3 - 2Z^2 - 8Z - 12$, og $Z = 3$ er rod.

  a) Skriv $p(Z)$ som produkt af et 1.-grads og et 2.-gradspolynomium.

  b) Find samtlige rødder i $CC$.

  #solution[
    *Del a) — Faktorisering via polynomiumsdivision:*

    Siden $Z = 3$ er rod, er $(Z - 3)$ en faktor. Vi dividerer:

    #align(center)[
      $ #poly-div-working((2, -2, -8, -12), (1, -3), var: $Z$) $
    ]

    *Resultat:*
    $ p(Z) = (Z - 3)(2Z^2 + 4Z + 4) = 2(Z - 3)(Z^2 + 2Z + 2) $

    *Del b) — Find alle rødder:*

    *Rod 1:* $Z = 3$ (givet)

    *Rod 2 og 3:* Løs $Z^2 + 2Z + 2 = 0$

    Diskriminant: $D = 2^2 - 4 dot 1 dot 2 = 4 - 8 = -4 < 0$ → komplekse rødder

    $ Z = frac(-2 plus.minus sqrt(-4), 2) = frac(-2 plus.minus 2i, 2) = -1 plus.minus i $

    #important[
      *Alle rødder:* $Z_1 = 3$, $Z_2 = -1 + i$, $Z_3 = -1 - i$

      *Komplet faktorisering:* $p(Z) = 2(Z - 3)(Z - (-1+i))(Z - (-1-i))$
    ]
  ]
]

#example(title: [Undersøg om $Z = 2$ er rod i $Z^3 - 5Z^2 - 4Z + 20$])[
  #align(center)[
    $ #poly-div-working((1, -5, -4, 20), (1, -2), var: $Z$) $
  ]

  Rest = 0, så $Z = 2$ *er* rod. Kvotienten er $Z^2 - 3Z - 10$.

  *Videre faktorisering:* $Z^2 - 3Z - 10 = (Z - 5)(Z + 2)$

  *Alle rødder:* $Z = 2, 5, -2$
]

== Find samtlige rødder i polynomium — Komplet metode

#important[
  *At finde ALLE rødder er en klassisk eksamensopgave!*

  Typisk format: "Givet at $r$ er rod, find samtlige rødder i $CC$."
]

#note-box[
  *Fremgangsmåde: Find alle rødder*

  *Trin 1:* Brug den givne rod til at faktorisere
  - Dividér $p(Z)$ med $(Z - r)$ for at få $q(Z)$

  *Trin 2:* Løs $q(Z) = 0$
  - Hvis $q(Z)$ er 2. grad: Brug diskriminantformlen
  - Hvis $q(Z)$ er højere grad: Find flere rødder og divider igen

  *Trin 3:* Husk komplekse rødder
  - For polynomier med *reelle koefficienter*: Komplekse rødder kommer i *konjugerede par*
  - Hvis $a + b i$ er rod, så er $a - b i$ også rod

  *Trin 4:* Skriv alle rødder eksplicit
  - Angiv hver rod på rektangulær form: $Z = a + b i$
]

#example(title: [Find alle rødder — Komplet eksempel])[
  Givet $p(Z) = 2Z^3 - 2Z^2 - 8Z - 12$ hvor $Z = 3$ er rod.

  Find samtlige rødder i $CC$ på rektangulær form.

  #solution()[
    *Trin 1: Polynomiumsdivision*

    #align(center)[
      $ #poly-div-working((2, -2, -8, -12), (1, -3), var: $Z$) $
    ]

    $ p(Z) = (Z - 3)(2Z^2 + 4Z + 4) = 2(Z - 3)(Z^2 + 2Z + 2) $

    *Trin 2: Løs kvotienten $Z^2 + 2Z + 2 = 0$*

    Diskriminant: $D = 2^2 - 4 dot 1 dot 2 = 4 - 8 = -4 < 0$

    Komplekse rødder:
    $ Z = (-2 plus.minus sqrt(-4))/2 = (-2 plus.minus 2i)/2 = -1 plus.minus i $

    *Trin 3: Verificér konjugerede par*

    $Z = -1 + i$ og $Z = -1 - i$ er konjugerede par ✓

    *Trin 4: Samtlige rødder*

    $ Z_1 = 3, quad Z_2 = -1 + i, quad Z_3 = -1 - i $

    *Komplet faktorisering:*
    $ p(Z) = 2(Z - 3)(Z - (-1+i))(Z - (-1-i)) $
  ]
]

#math-hint()[
  *Hurtige tjek for rødder:*
  - Et polynomium af grad $n$ har præcis $n$ rødder (med multiplicitet) i $CC$
  - Reelle koefficienter $=>$ komplekse rødder i konjugerede par
  - Sum af rødder $= -a_(n-1)/a_n$ (Vieta's formler)
  - Produkt af rødder $= (-1)^n a_0/a_n$

  *MC-gæt:* Hvis du får én kompleks rod, tjek om dens konjugerede også er mulighed!
]

== Divisionsalgoritmen til at undersøge faktor

#note-box[
  *Fremgangsmåde:* (Referér til korollar 5.6.4)

  For at undersøge om $u(Z)$ (af grad $>$ 1) er faktor i $q(Z)$:

  1. Opskriv $u(Z)$ i venstre side, $q(Z)$ i midten
  2. Find faktor $a_1 Z^n$ så $u(Z) dot a_1 Z^n$ fjerner førsteleddet i $q(Z)$
  3. Gentag processen
  4. *Konklusion:*
    - Rest = 0: $u(Z)$ er faktor
    - Rest = polynomium med grad $>= $ grad af $u(Z)$: Undersøg videre
    - Rest = polynomium med grad $<$ grad af $u(Z)$: Ikke faktor
]

#math-hint(
  )[
  *Hurtig faktor-tjek:* Hvis $p(a) = 0$, så er $(Z - a)$ en faktor.

  *Test standard rødder først:* Prøv $Z = 0, plus.minus 1, plus.minus 2, plus.minus 3$ — eksamensspørgsmål har ofte "pæne" rødder!

  *Komplekse rødder:* Hvis koefficienterne er *reelle* og du finder én kompleks rod $alpha + beta i$, er $alpha - beta i$ *også* rod.

  *MC-gæt:* Hvis opgaven giver én rod, er de resterende ofte "pæne" tal eller konjugerede par.

  *Algebraens fundamentalsætning:* Et polynomium af grad $n$ har præcis $n$ rødder (talt med multiplicitet) i $CC$.
]

== Multiplicitet af rod i polynomium

#note-box[
  *Fremgangsmåde:* (Referér til definition 5.6.1 og sætning 5.6.3)

  1. Undersøg om $(Z - lambda)$ nemt kan faktoriseres ud
  2. Foretag divisionsalgoritmen
  3. Gentag indtil $(Z - lambda)$ ikke længere er faktor
  4. Antallet af gange $(Z - lambda)$ var faktor = multipliciteten
]

== Induktion over de naturlige tal

#note-box[
  *Bemærk:* $NN$ inkluderer *ikke* 0 på DTU. Basisskridtet er typisk $P(1)$ eller $P(n_0)$.

  *Fremgangsmåde:* (Referér til korollar 3.4.2)

  1. *Basisskridtet:* Verificér $P(n_0)$ (ofte $n_0 = 1$)
  2. *Induktionshypotesen (I.H.):* Antag $P(n-1)$ gælder for et vilkårligt $n >= n_0 + 1$
  3. *Induktionsskridtet (I.S.):* Vis at $P(n)$ følger af $P(n-1)$
  4. *Konklusion:* Dermed gælder $P(n)$ for alle $n >= n_0$ ved induktionsprincippet. $square$
]

#important[
  *Typiske fejl at undgå:*
  - Glem ikke at *eksplicit skrive* "Induktionshypotese" og "Induktionsskridt"
  - Husk at *bruge* I.H. i beviset — marker hvor du bruger den!
  - Afslut med en *klar konklusion* der refererer til induktionsprincippet
]

=== Eksempel 1: Sum af de første $n$ naturlige tal

#example(title: "Bevis ved induktion — Sum")[
  Vis at $display(sum_(k=1)^n k = (n(n+1))/2)$ for alle $n in NN$.

  #solution[
    *Basisskridt* ($n = 1$):
    $
      "V.S.:" quad sum_(k=1)^1 k = 1, quad "H.S.:" quad (1 dot 2)/2 = 1 quad checkmark
    $

    *Induktionshypotese (I.H.):*

    Antag at $display(sum_(k=1)^(n-1) k = ((n-1)n)/2)$ gælder for et vilkårligt $n >= 2$.

    *Induktionsskridt (I.S.):*

    Vi skal vise at $display(sum_(k=1)^n k = (n(n+1))/2)$.
    $
      sum_(k=1)^n k &= underbrace(sum_(k=1)^(n-1) k, = ((n-1)n)/2 "af I.H.") + n \
                    &= ((n-1)n)/2 + n \
                    &= ((n-1)n)/2 + (2n)/2 \
                    &= ((n-1)n + 2n)/2 \
                    &= (n^2 - n + 2n)/2 \
                    &= (n^2 + n)/2 \
                    &= (n(n+1))/2 quad checkmark
    $

    *Konklusion:* Ved induktionsprincippet gælder formlen for alle $n in NN$. $square$
  ]
]

=== Eksempel 2: Rekursiv følge

#example(title: "Bevis ved induktion — Rekursiv følge")[
  Lad $s_n$ være defineret rekursivt ved:
  $
    s_n = cases(1 & n = 1, 2s_(n-1) + 1 & n > 1)
  $

  Vis at $s_n = 2^n - 1$ for alle $n in NN$.

  #solution[
    *Basisskridt* ($n = 1$):
    $
      s_1 = 1 = 2^1 - 1 = 2 - 1 = 1 quad checkmark
    $

    *Induktionshypotese (I.H.):*

    Antag at $s_(n-1) = 2^(n-1) - 1$ for et vilkårligt $n >= 2$.

    *Induktionsskridt (I.S.):*

    Vi skal vise at $s_n = 2^n - 1$.
    $
      s_n &= 2 s_(n-1) + 1 quad "(definition)" \
          &= 2(2^(n-1) - 1) + 1 quad "(I.H.)" \
          &= 2 dot 2^(n-1) - 2 + 1 \
          &= 2^n - 1 quad checkmark
    $

    *Konklusion:* Ved induktionsprincippet gælder $s_n = 2^n - 1$ for alle $n in NN$. $square$
  ]
]

=== Eksempel 3: Matrixpotenser

#example(title: "Bevis ved induktion — Matrixpotens")[
  Lad $bold(A) = mat(1, 2;0, 1)$.

  Vis at $bold(A)^n = mat(1, 2n;0, 1)$ for alle $n in NN$.

  #solution[
    *Basisskridt* ($n = 1$):
    $
      bold(A)^1 = mat(1, 2;0, 1) = mat(1, 2 dot 1;0, 1) quad checkmark
    $

    *Induktionshypotese (I.H.):*

    Antag at $bold(A)^(n-1) = mat(1, 2(n-1);0, 1)$ for et vilkårligt $n >= 2$.

    *Induktionsskridt (I.S.):*

    Vi skal vise at $bold(A)^n = mat(1, 2n;0, 1)$.
    $
      bold(A)^n &= bold(A)^(n-1) dot bold(A) \
                &= mat(1, 2(n-1);0, 1) dot mat(1, 2;0, 1) quad "(I.H.)" \
                &= mat(1 dot 1 + 2(n-1) dot 0, 1 dot 2 + 2(n-1) dot 1;0 dot 1 + 1 dot 0, 0 dot 2 + 1 dot 1) \
                &= mat(1, 2 + 2(n-1);0, 1) \
                &= mat(1, 2 + 2n - 2;0, 1) \
                &= mat(1, 2n;0, 1) quad checkmark
    $

    *Konklusion:* Ved induktionsprincippet gælder formlen for alle $n in NN$. $square$
  ]
]

== Induktion over andre tallegemer

#note-box[
  *Fremgangsmåde:* (Referér til sætning 3.5.1)

  Hvis påstanden skal gælde for $n >= n_0$ (hvor $n_0 eq.not 1$):

  1. *Basisskridtet:* Verificér $P(n_0)$
  2. *Induktionshypotesen:* Antag $P(n-1)$ for $n >= n_0 + 1$
  3. *Induktionsskridtet:* Vis $P(n)$
]

#math-hint()[
  *Polynomium-rødder:*
  - Reelle koefficienter $=>$ komplekse rødder kommer i par
  - Grad $n$ $=>$ præcis $n$ rødder (med multiplicitet)
  - Summen af rødder $= -a_(n-1)/a_n$
  - Produktet af rødder $= (-1)^n a_0/a_n$

  *Test simple rødder først:* Prøv $Z = 0, plus.minus 1, plus.minus 2$ før du bruger formler.

  *Induktion — Strategi:*
  - Basisskridtet er ofte trivielt — brug det til at forstå mønstret
  - I induktionsskridtet: Skriv $P(n)$ som $P(n-1) +$ "noget ekstra"
  - For summer: $sum_(k=1)^n = sum_(k=1)^(n-1) + "sidste led"$
  - For rekursive følger: Brug definitionen direkte
  - For matrixpotenser: $bold(A)^n = bold(A)^(n-1) dot bold(A)$
]

= Uge 6: Lineære Ligningssystemer og Gauss Elimination

== Frie variable

#note-box[
  $ "Antal frie variable" = "Antal søjler" - "Antal pivoter" $

  For $bold(A) in FF^(m times n)$.

  *Sætninger:* Sætning 9.2.1, lemma 11.1.2, sætning 9.4.2

  Da rangen af $bold(A)$ er lig med antallet af pivoter i RREF, og antallet af vektorer i søjlerummet også er lig med antallet af pivoter, gælder:
  $ "colsp"(bold(A)) = rho(bold(A)) $
]

== Invertibel matrix

#note-box[
  *Fremgangsmåde:*

  1. Referér til definition 7.3.1: $bold(A) in FF^(n times n)$ er invertibel hvis der findes $bold(B) in FF^(n times n)$ så:
    $ bold(A) dot bold(B) = bold(B) dot bold(A) = bold(I)_n $
  2. Referér til korollar 7.3.5: Invers eksisterer kun hvis rang = antal søjler
  3. Sørg for at søjlerne i $bold(P)$ ikke er proportionale
  4. Kontrollér at $det(bold(P)) eq.not 0$

  *Bemærk:* $bold(P)^(-1)$ eksisterer $<=>$ $det(bold(P)) eq.not 0$
]

== Beregning af invers matrix — VIGTIG!

#important[
  *Matrixinversion — Eksamensklassiker!*

  Inverser optræder hyppigt i forbindelse med:
  - Basisskiftematricer: $amat("id", gamma, beta) = (amat("id", beta, gamma))^(-1)$
  - Diagonalisering: $bold(A) = bold(P) bold(D) bold(P)^(-1)$
  - Løsning af $bold(A) bold(x) = bold(b)$: $bold(x) = bold(A)^(-1) bold(b)$
]

#note-box[
  *Metode 1: Formel for $2 times 2$ matrix (HURTIGST!)*

  For $bold(A) = mat(a, b;c, d)$ med $det(bold(A)) = a d - b c eq.not 0$:

  $ bold(A)^(-1) = 1/(a d - b c) mat(d, -b;-c, a) $

  *Huskeregel:*
  1. Byt diagonalelementerne ($a$ og $d$)
  2. Skift fortegn på anti-diagonalen ($b$ og $c$)
  3. Divider med determinanten
]

#note-box[
  *Metode 2: Gauss-Jordan metoden (for alle størrelser)*

  1. Opstil $[bold(A) | bold(I)]$ (matrix med identitetsmatrix til højre)
  2. Rækkeoperationer indtil venstresiden er $bold(I)$
  3. Højresiden er nu $bold(A)^(-1)$

  $ [bold(A) | bold(I)] arrow.long^("RREF") [bold(I) | bold(A)^(-1)] $
]

#note-box[
  *Metode 3: Blokdiagonal matrix (HURTIG GENVEJ!)*

  Hvis $bold(A)$ er blokdiagonal:
  $ bold(A) = mat(bold(B), bold(0);bold(0), bold(C)) quad => quad bold(A)^(-1) = mat(bold(B)^(-1), bold(0);bold(0), bold(C)^(-1)) $

  *Eksempel:* For $mat(2, 1, 0;1, 1, 0;0, 0, 2)$:

  - Øverste $2 times 2$ blok: $mat(2, 1;1, 1)^(-1) = 1/(2-1) mat(1, -1;-1, 2) = mat(1, -1;-1, 2)$
  - Nederste blok: $2^(-1) = 1/2$

  $ bold(A)^(-1) = mat(1, -1, 0;-1, 2, 0;0, 0, 1/2) $

  *Genkend blokdiagonal:* Når matricen har "blokke" af nuller, så de øverste rækker ikke interagerer med de nederste.
]

#example(
  title: [Beregn invers af $2 times 2$ matrix],
)[
  Find $bold(A)^(-1)$ for $bold(A) = mat(3, 5;1, 2)$.

  #solution(
    )[
    *Trin 1:* Beregn determinanten:
    $ det(bold(A)) = 3 dot 2 - 5 dot 1 = 6 - 5 = 1 $

    *Trin 2:* Anvend formlen:
    $ bold(A)^(-1) = 1/1 mat(2, -5;-1, 3) = mat(2, -5;-1, 3) $

    *Verifikation:* $bold(A) bold(A)^(-1) = mat(3, 5;1, 2) mat(2, -5;-1, 3) = mat(6-5, -15+15;2-2, -5+6) = mat(1, 0;0, 1) checkmark$
  ]
]

#example(title: [Beregn invers via Gauss-Jordan])[
  Find $bold(A)^(-1)$ for $bold(A) = mat(1, 2;3, 7)$.

  #solution()[
    Opstil og reducer:
    $
      mat(1, 2, |, 1, 0;3, 7, |, 0, 1) &arrow.long_(R_2 <- R_2 - 3R_1) mat(1, 2, |, 1, 0;0, 1, |, -3, 1) \
                                       &arrow.long_(R_1 <- R_1 - 2R_2) mat(1, 0, |, 7, -2;0, 1, |, -3, 1)
    $

    $ bold(A)^(-1) = mat(7, -2;-3, 1) $
  ]
]

#math-hint()[
  *Hvornår bruge hvilken metode?*
  - $2 times 2$: Brug *altid* formlen — hurtigst og færrest fejl
  - $3 times 3$ blokdiagonal: Opdel i blokke
  - Generel $3 times 3$: Gauss-Jordan eller kofaktormetoden

  *Inverse eksisterer ikke hvis:*
  - $det = 0$
  - Rækker/søjler er lineært afhængige
  - RREF har ikke fuld rang
]

== Vurdér om system er homogent eller inhomogent

#note-box[
  *Fremgangsmåde for lineære ligningssystemer:* (Sætning 6.1.2)

  1. Undersøg højresiden i den udvidede matrix
  2. Hvis alle elementer = 0: *Homogent*
  3. Ellers: *Inhomogent*
]

#note-box[
  *Fremgangsmåde for differentialligningssystemer:*

  For systemet $bold(f)'(t) = bold(A) bold(f)(t) + bold(g)(t)$:

  1. Identificér $bold(g)(t)$ (tvangsfunktionen/højresiden)
  2. Klassificér:
    - $bold(g)(t) = bold(0)$ (nulvektor) for alle $t$: *Homogent*
    - $bold(g)(t) eq.not bold(0)$: *Inhomogent*

  *Eksempel (homogent):*
  $ cases(f'_1(t) = f_1(t) + 2f_2(t), f'_2(t) = 2f_1(t) + f_2(t)) $
  Dette er homogent fordi der kun er $f_1$ og $f_2$ led — ingen konstanter eller funktioner af $t$ alene.

  *Eksempel (inhomogent):*
  $ cases(f'_1(t) = f_1(t) + 2f_2(t) + e^t, f'_2(t) = 2f_1(t) + f_2(t) + 3) $
  Dette er inhomogent pga. $e^t$ og $3$ leddene.
]

== Vurdér om vektorer er lineært uafhængige

#note-box[
  *Fremgangsmåde:* (Sætning 7.1.3)

  1. Omskriv matricen til RREF (definition 6.3.2, rækkeoperationer fra kapitel 6.2)
  2. Undersøg om rang = antal søjler
    - Ja: Lineært *uafhængige*
    - Nej: Lineært *afhængige*
]

#math-hint()[
  *Hurtige observationer:*
  - Nulrække $=>$ fri variabel $=>$ uendeligt mange løsninger
  - Nulrække med ikke-nul på højresiden $=>$ ingen løsning
  - Antal pivoter = rang
  - Frie variable = søjler - pivoter

  *Invertibel matrix:* $n times n$ matrix er invertibel $<=>$ $n$ pivoter $<=>$ $det eq.not 0$

  *MC-gæt:* Hvis systemet har parameter (f.eks. $a$), er "specielle værdier" ofte dem der giver $det = 0$.
]

= Uge 7: Matrixalgebra og Determinanter

== Determinant af kvadratisk matrix

#note-box[
  *For $2 times 2$:* Kun definition 8.1.2
  $ det mat(a, b;c, d) = a d - b c $

  *For $n times n$, $n > 2$:*

  *Metode 1: Uden rækkeoperationer*
  - Henvis til sætning 8.2.1 (cofaktorudvidelse langs række med flest nuller)
  - Henvis til definition 8.1.2

  *Metode 2: Med rækkeoperationer*
  - Forkort med elementære operationer, hold styr på effekt på determinant:
    - $R_i <- c dot R_i$: Multiplicér $det$ med $c$ (korollar 8.3.2)
    - $R_i <-> R_j$: Skift fortegn på $det$ (sætning 8.3.6)
    - $R_i <- R_i + c dot R_j$: Ingen effekt (sætning 8.3.7)

  *For triangulær matrix:* $det =$ produkt af diagonalelementer (proposition 8.1.1, sætning 8.1.2, 8.1.4)

  *Specielle tilfælde:*
  - Nulrække $=>$ $det = 0$ (lemma 8.1.3)
  - To identiske rækker $=>$ $det = 0$ (proposition 8.2.5)
]

== Rang af matrix

#note-box[
  *Fremgangsmåde:*
  1. Omskriv til RREF (definition 6.3.2)
  2. Rang = antal pivoter (definition 6.3.3)
]

== Rang og Nulitet

#note-box[
  *Rang-Nulitets-sætningen:*
  $ "rank"(bold(A)) + "null"(bold(A)) = n $
  hvor $n$ er antal søjler i $bold(A)$.

  *Rang:* Antal pivoter i RREF
  *Nulitet:* $n - "rank"(bold(A))$ = dimension af kernen
]

#example(title: [Find egenværdier for $bold(A) = mat(1, 8;1, -1)$])[
  #solution()[
    *Metode 1: Direkte beregning*

    *Trin 1:* Opstil $bold(A) - lambda bold(I)$:
    $ bold(A) - lambda bold(I) = mat(1 - lambda, 8;1, -1 - lambda) $

    *Trin 2:* Beregn determinanten (FOIL på diagonalen):
    $ det = (1 - lambda)(-1 - lambda) - 8 dot 1 $

    *Trin 3:* udvid $(1 - lambda)(-1 - lambda)$ *omhyggeligt*:
    $ (1 - lambda)(-1 - lambda) $
    - F: $1 dot (-1) = -1$
    - O: $1 dot (-lambda) = -lambda$
    - I: $(-lambda) dot (-1) = lambda$
    - L: $(-lambda) dot (-lambda) = lambda^2$

    $ = -1 - Z + Z + Z^2 = Z^2 - 1 $

    *Trin 4:* Det karakteristiske polynomium:
    $ p_(bold(A))(Z) = (Z^2 - 1) - 8 = Z^2 - 9 $

    *Trin 5:* Find rødderne:
    $ lambda^2 - 9 = 0 $
    $ lambda^2 = 9 $
    $ lambda = plus.minus 3 $

    *Egenværdier:* $lambda_1 = 3$, $lambda_2 = -3$

    ---

    *Metode 2: Brug formlen (hurtigere, færre fejl)*

    $ "tr"(bold(A)) = 1 + (-1) = 0 $
    $ det(bold(A)) = 1 dot (-1) - 8 dot 1 = -1 - 8 = -9 $

    $ p_(bold(A))(Z) = Z^2 - 0 dot Z + (-9) = Z^2 - 9 $

    Samme resultat!
  ]
]

#example(title: [Faktorisér $lambda^2 - 9$])[
  #solution()[
    *Genkend:* Dette er en *differens af kvadrater*: $a^2 - b^2 = (a-b)(a+b)$

    $ lambda^2 - 9 = lambda^2 - 3^2 = (lambda - 3)(lambda + 3) $

    *Rødder:* $lambda = 3$ eller $lambda = -3$
  ]
]

#example(title: [Faktorisér $lambda^2 - 5lambda + 6$])[
  #solution()[
    *Metode: Gæt og tjek*

    Søg $r, s$ så:
    - $r + s = 5$ (bemærk: $-p = -(-5) = 5$)
    - $r dot s = 6$

    Prøv: $r = 2$, $s = 3$ (da $2 + 3 = 5$ og $2 dot 3 = 6$)

    $ lambda^2 - 5lambda + 6 = (lambda - 2)(lambda - 3) $

    *Rødder:* $lambda = 2$ eller $lambda = 3$
  ]
]

#example(title: [Faktorisér $lambda^2 + 2lambda - 8$])[
  #solution()[
    *Metode: Gæt og tjek*

    Søg $r, s$ så:
    - $r + s = -2$
    - $r dot s = -8$

    Prøv: $r = -4$, $s = 2$ (da $-4 + 2 = -2$ og $(-4) dot 2 = -8$)

    $ lambda^2 + 2lambda - 8 = (lambda + 4)(lambda - 2) $

    *Rødder:* $lambda = -4$ eller $lambda = 2$
  ]
]

#example(
  title: [Faktorisér $lambda^2 - 4lambda + 5$ (komplekse rødder)],
)[
  #solution()[
    *Metode: Kvadratisk formel* (ingen nemme heltalsrødder)

    $ lambda = (4 plus.minus sqrt(16 - 20))/2 = (4 plus.minus sqrt(-4))/2 = (4 plus.minus 2i)/2 = 2 plus.minus i $

    $ lambda^2 - 4lambda + 5 = (lambda - (2 + i))(lambda - (2 - i)) $

    *Rødder:* $lambda = 2 + i$ eller $lambda = 2 - i$
  ]
]

#note-box[
  *Almindelige fejl at undgå:*

  1. *Fortegnsfejl i FOIL:* $(a - lambda)(b - lambda) eq.not a b - lambda^2$

    Korrekt: $(a - lambda)(b - lambda) = a b - a lambda - b lambda + lambda^2$

  2. *Glemmer $-b c$ leddet:* $det mat(a - lambda, b;c, d - lambda) = (a-lambda)(d-lambda) bold(- b c)$

  3. *Forkert fortegn i faktorer:* Hvis $lambda = 3$ er rod, er faktoren $(lambda - 3)$, *ikke* $(lambda + 3)$

  4. *Blander spor og determinant:*
    - Spor = diagonal#strong[sum]: $a + d$
      - Determinant = diagonal#strong[produkt] minus anti-diagonal: $a d - b c$
]

#math-hint(
  )[
  *Instant $det = 0$:*
  - Nulrække eller nulsøjle
  - To identiske rækker/søjler
  - Proportionale rækker/søjler
  - Række/søjle er linearkombination af andre

  *Triangulær matrix:* $det =$ produkt af diagonalelementer — ingen udregning nødvendig!

  *Rækkeoperationer:*
  - Byt rækker: $det$ skifter fortegn
  - Gang række med $k$: $det$ ganges med $k$
  - Læg række til anden: $det$ uændret

  *MC-gæt:* $det(bold(A) bold(B)) = det(bold(A)) det(bold(B))$ — men $det(bold(A) + bold(B)) eq.not det(bold(A)) + det(bold(B))$!
]

= Uge 8-9: Vektorrum, Basis og Koordinater

== Span (udspænding)

#note-box[
  *Definition 9.1.1:* Span af vektorer er mængden af alle lineære kombinationer:
  $ "span"(bold(v)_1, ..., bold(v)_k) = {c_1 bold(v)_1 + ... + c_k bold(v)_k | c_i in FF} $

  Hvis vektorerne udgør en basis for et vektorrum, er deres span hele vektorrummet.
]

== Dimension

#note-box[
  *Flere metoder:*

  1. *Sætning 10.2.7:* $dim(V)$ = antal lineært uafhængige vektorer i basis
  2. For $V$ med basis af $n times m$ matricer: $dim(V) = n dot m$
  3. *Rang-Nulitets-sætningen (9.4.2):* $rho(bold(A)) + "null"(bold(A)) = n$
  4. *Korollar 11.4.3:* $dim(V) = dim(ker L) + dim("image" L)$
]

== Forskellige typer basis

#note-box[
  *Generel basis:*
  Et sæt af lineært uafhængige vektorer ${bold(v)_1, ..., bold(v)_n}$ der udspænder hele $V$.

  *Ordnet basis (definition 10.2.4, 9.2.1):*
  En basis hvor rækkefølgen er vigtig - koordinater afhænger af rækkefølgen.

  *Ordnet standardbasis (eksempel 9.2.1):*
  I $RR^n$: $(bold(e)_1, bold(e)_2, ..., bold(e)_n)$ hvor $bold(e)_i$ har 1 i position $i$, 0 ellers.
]

== Underrum

#note-box[
  *Fremgangsmåde:* (Lemma 10.4.2)

  $W subset.eq V$ er et underrum hvis:
  $ bold(u) + c dot bold(v) in W quad forall c in FF, forall bold(u), bold(v) in W $
]

== Basis for underrum udspændt af vektorer

#note-box[
  *Fremgangsmåde:* (Definition 9.2.3, 9.2.4, sætning 9.2.1)

  1. Saml vektorerne i en matrix
  2. Reducér til RREF (definition 6.3.2)
  3. Søjlerne med pivoter udgør en ordnet basis for udspændingen
]

#math-hint(
  )[
  *Dimension:*
  - $dim(RR^n) = n$
  - $dim(RR^(m times n)) = m dot n$
  - $dim(PP_n) = n + 1$ (polynomier af grad $<= n$)

  *Lineær uafhængighed:* $n$ vektorer i $RR^n$ er lineært uafhængige $<=>$ $det eq.not 0$

  *Span:* Hvis vektorerne har "tydelige" ledende indgange i forskellige positioner, er de sandsynligvis uafhængige.

  *MC-gæt:* Standardbasis-vektorer er altid lineært uafhængige.
]

= Uge 10: Lineære Afbildninger

== Undersøg om afbildning er lineær

#note-box[
  *Fremgangsmåde:* (Definition 11.0.1)

  Undersøg om $L$ opfylder:
  1. $L(bold(u) + bold(v)) = L(bold(u)) + L(bold(v))$, $forall bold(u), bold(v) in V_1$
  2. $L(c dot bold(u)) = c dot L(bold(u))$, $forall c in FF$, $forall bold(u) in V_1$

  Angiv vilkårlige vektorer og undersøg begge krav.
]

== Kernel (kernen)

#note-box[
  *Definition 11.2.1:*
  $ ker(bold(A)) = {bold(v) in FF^n | bold(A) dot bold(v) = bold(0)} $

  *Fremgangsmåde:*
  1. Sæt $bold(A) bold(x) = bold(0)$
  2. Reducér til RREF
  3. Find frie variable, skriv løsning som linearkombination

  $ ker(bold(A)) = "span"{("basisvektorer")} $
]

== Image (billedrum)

#note-box[
  *Definition:* (Side 22 i lærebogen)
  $ "image"(f) = f(A) = {f(a) | a in A} $

  *Fremgangsmåde:*
  1. Reducér til RREF
  2. Pivotsøjlerne i den *originale* matrix danner basis for billedrummet
]

== Dimension af billedrum og kerne

#note-box[
  *Billedrum:* (Sætning 10.4.4, lemma 11.1.2, sætning 9.4.1)
  $ dim("Im"(bold(A))) = dim("colsp"(bold(A))) = rho(bold(A)) $

  *Kerne:* (Sætning 9.4.2)
  $ "null"(bold(A)) = n - rho(bold(A)) $
  $ dim(ker(bold(A))) = n - dim("im"(bold(A))) $
]

== Afbildningsmatrix

#note-box[
  *Definition:* (Lemma 11.3.3)

  Afbildningsmatricen $amat(L, gamma, beta)$ beskriver hvordan $L$ transformerer fra basis $beta$ til $gamma$:
  $ amat(L, gamma, beta) = [[L(bold(v)_1)]_gamma ... [L(bold(v)_n)]_gamma], quad beta = (bold(v)_1, ..., bold(v)_n) $

  *Beregning:*
  1. Anvend $L$ på hver basisvektor i $beta$
  2. Udtryk resultaterne som linearkombinationer af $gamma$-basisvektorer
  3. Koefficienterne udgør søjlerne i matricen
]

== Basisskifte

#note-box[
  *Definition:*

  Basisskiftematrix $amat("id", gamma, beta)$ konverterer koordinater fra $beta$ til $gamma$:
  $ amat("id", gamma, beta) dot [bold(v)]_beta = [bold(v)]_gamma, quad forall bold(v) in V $

  Der gælder: $amat("id", gamma, beta) = (amat("id", beta, gamma))^(-1)$

  *Sammensætning:*
  $ amat(L, beta, beta) = amat("id", beta, gamma) dot amat(L, gamma, gamma) dot amat("id", gamma, beta) $
]

#math-hint()[
  *Injektiv/Surjektiv hurtig-tjek:*
  - Injektiv $<=>$ $ker = {bold(0)}$ $<=>$ ingen frie variable
  - Surjektiv $<=>$ rang = $dim("codomain")$
  - Kvadratisk matrix: Injektiv $<=>$ Surjektiv $<=>$ $det eq.not 0$

  *Rang-Nulitet:* $dim(ker) + dim("im") = dim("domæne")$

  *MC-gæt:* Hvis matricen er kvadratisk og $det eq.not 0$, er afbildningen BÅDE injektiv OG surjektiv.
]

= Uge 11: Egenværdiproblemet og Diagonalisering

== Egenværdier

#note-box[
  *Fremgangsmåde:*

  1. Opskriv egenværdiproblemet (definition 12.1.2): $bold(A) dot bold(v) = lambda dot bold(v)$
  2. Omskriv til $p_(bold(A))(Z) = det(bold(A) - Z bold(I)_n) = 0$
  3. Løs det karakteristiske polynomium:
    - *2. grad:* Faktoriser eller brug diskriminantformlen (definition 5.2.1)
    - *3. grad:* Test simple rødder ${-1, 0, 1}$, divider, løs rest
    - *Højere grad:* Kombinér strategier
]

== Egenvektorer

#note-box[
  *Fremgangsmåde:*

  1. Find egenværdierne $lambda_i$
  2. For hver $lambda_i$: Løs $(bold(A) - lambda_i bold(I)_n) bold(v) = bold(0)$
  3. Egenvektorerne er ikke-trivielle løsninger ($bold(v) eq.not bold(0)$)
]

== Egenrum

#note-box[
  *Definition:* (Lemma 12.2.3)

  Egenrummet for $lambda$ er mængden af alle egenvektorer (plus nulvektoren):
  $ E_lambda = ker(bold(A) - lambda bold(I)_n) $
]

#example(title: [Komplet eksempel — Find egenværdier, egenvektorer og egenrum])[
  Givet $bold(A) = mat(1, 2;2, 1) in RR^(2 times 2)$.

  Find egenværdierne, egenvektorerne og egenrummene.

  #solution[
    *Trin 1 — Find det karakteristiske polynomium:*
    $
      p_(bold(A))(Z) &= det(bold(A) - Z bold(I)_2) = det mat(1-Z, 2;2, 1-Z) \
                     &= (1-Z)(1-Z) - 2 dot 2 \
                     &= (1-Z)^2 - 4
    $

    *Trin 2 — Find egenværdierne (løs $p_(bold(A))(Z) = 0$):*
    $
      (1-Z)^2 - 4 &= 0 \
      (1-Z)^2     &= 4 \
      1 - Z       &= plus.minus 2 \
      Z           &= 1 minus.plus 2
    $

    *Egenværdier:* $lambda_1 = -1$ og $lambda_2 = 3$

    *Trin 3 — Find egenrummet $E_(-1)$:*
    $
      E_(-1) = ker(bold(A) - (-1) bold(I)_2) = ker mat(2, 2;2, 2)
    $

    Reducér til RREF:
    $
      mat(2, 2;2, 2) arrow.long^("RREF") mat(1, 1;0, 0)
    $

    Fra RREF: $v_1 + v_2 = 0$, så $v_1 = -v_2 = -t$ hvor $v_2 = t$ er fri.
    $
      bold(v) = vec(v_1, v_2) = t vec(-1, 1) quad => quad E_(-1) = "span"{vec(-1, 1)}
    $

    *Trin 4 — Find egenrummet $E_3$:*
    $
      E_3 = ker(bold(A) - 3 bold(I)_2) = ker mat(-2, 2;2, -2)
    $

    Reducér til RREF:
    $
      mat(-2, 2;2, -2) arrow.long^("RREF") mat(1, -1;0, 0)
    $

    Fra RREF: $v_1 - v_2 = 0$, så $v_1 = v_2 = t$ hvor $v_2 = t$ er fri.
    $
      bold(v) = t vec(1, 1) quad => quad E_3 = "span"{vec(1, 1)}
    $

    *Opsummering:*
    - $lambda_1 = -1$: $E_(-1) = "span"{vec(-1, 1)}$, $"gm"(-1) = 1$, $"am"(-1) = 1$
    - $lambda_2 = 3$: $E_3 = "span"{vec(1, 1)}$, $"gm"(3) = 1$, $"am"(3) = 1$

    Da $"gm" = "am"$ for begge egenværdier, er $bold(A)$ *diagonaliserbar*.
  ]
]

#important[
  *Vigtig sammenhæng:*
  $ 1 <= "gm"(lambda) <= "am"(lambda) $

  En matrix er diagonaliserbar $<=>$ $"gm"(lambda) = "am"(lambda)$ for alle egenværdier.
]

== Basis for egenrum

#note-box[
  *Fremgangsmåde:*
  1. Find egenrummene
  2. Følg fremgangsmetoden "Basis for underrum udspændt af vektorer"
  3. Se evt. eksempel 12.2.1
]

== Geometrisk multiplicitet

#note-box[
  *Definition 12.2.1:* $"gm"(lambda) = dim(E_lambda)$

  *Fremgangsmåde:*
  1. Opskriv $(bold(A) - lambda bold(I)_n)$ og reducér til RREF
  2. $"gm"(lambda)$ = antal frie variable = antal uafhængige løsninger
]

== Algebraisk multiplicitet

#note-box[
  *Definition 12.2.1:* $"am"(lambda)$ = multiplicitet i det karakteristiske polynomium

  *Fremgangsmåde:*
  1. Find egenværdierne via $p_(bold(A))(Z) = 0$
  2. Faktorisér polynomiet på formen $(Z - lambda_i)^(m_i)$
  3. $"am"(lambda_i) = m_i$
]

== Diagonalisering

#note-box[
  *Fremgangsmåde:*

  1. *Tjek om diagonaliserbar:*
    - Korollar 12.3.4, 12.3.5: $"am"(lambda_i) = "gm"(lambda_i)$ for alle $lambda_i$
    - Definition 12.3.1: $bold(A)$ similær med diagonalmatrix

  2. Find egenværdier

  3. Lemma 12.3.1: Egenvektorer til forskellige egenværdier er lineært uafhængige

  4. Find egenvektorer, referér til Lemma 12.3.2

  5. Opstil $bold(X)$ med egenvektorer som søjler

  6. Verificér: $bold(X)^(-1) dot bold(A) dot bold(X) = bold(D)$
]

== Similære matricer

#note-box[
  *Definition 12.3.1:*

  $bold(A)$ er similær med $bold(B)$ hvis der findes invertibel $bold(Q)$ så:
  $ bold(A) = bold(Q)^(-1) dot bold(B) dot bold(Q) $

  Matricer er similære hvis de er similære med samme diagonalmatrix.
]

== Kvadratrod af matrix

#note-box[
  *Fremgangsmåde:* (Fra undervisning)

  1. Konstatér at matricen kan diagonaliseres
  2. Brug:
    $ bold(M)^(-1) dot bold(A) dot bold(M) = bold(D) $
    $ bold(B) = bold(M) dot sqrt(bold(D)) dot bold(M)^(-1) $
    hvor $sqrt(bold(D))$ har kvadratrødder af diagonalelementerne
]

#example(
  title: [Komplet eksempel: ODE-system med egenværdier],
)[
  Givet $bold(A) = mat(3, 1;4, 3)$. Find egenværdier og den fuldstændige løsning til $bold(f)'(t) = bold(A) bold(f)(t)$.

  #solution()[
    *Trin 1:* Karakteristisk polynomium via formlen:
    $ "tr"(bold(A)) = 3 + 3 = 6 $
    $ det(bold(A)) = 3 dot 3 - 1 dot 4 = 9 - 4 = 5 $
    $ p_(bold(A))(Z) = Z^2 - 6Z + 5 $

    *Trin 2:* Faktorisér:

    Søg $r, s$ så $r + s = 6$ og $r dot s = 5$.

    Prøv: $r = 1$, $s = 5$

    $ p_(bold(A))(Z) = (Z - 1)(Z - 5) $

    *Egenværdier:* $lambda_1 = 1$, $lambda_2 = 5$

    *Trin 3:* Find egenvektorer:

    *For $lambda_1 = 1$:*
    $ bold(A) - bold(I) = mat(2, 1;4, 2) arrow mat(2, 1;0, 0) $
    $ 2v_1 + v_2 = 0 => bold(v)_1 = vec(1, -2) $

    *For $lambda_2 = 5$:*
    $ bold(A) - 5bold(I) = mat(-2, 1;4, -2) arrow mat(-2, 1;0, 0) $
    $ -2v_1 + v_2 = 0 => bold(v)_2 = vec(1, 2) $

    *Trin 4:* Fuldstændig løsning:
    $ bold(f)(t) = c_1 e^t vec(1, -2) + c_2 e^(5t) vec(1, 2) $
  ]
]

#note-box[
  *For $3 times 3$ matricer:*

  Brug *co-faktorudvidelse* langs en række/søjle med flest nuller.

  Typisk struktur hvis blokdiagonal eller trekantsform:
  - Øvre/nedre trekantsmatrix: Egenværdier = diagonalelementerne
  - Blokdiagonal: Find egenværdier for hver blok separat
]

#math-hint()[
  *Instant egenværdier:*
  - Triangulær/diagonal matrix: Aflæs fra diagonalen
  - $2 times 2$: Brug $lambda^2 - "tr"(bold(A)) lambda + det(bold(A)) = 0$

  *Tjek egenvektor:* Beregn $bold(A) bold(v)$ — er det $lambda bold(v)$?

  *Diagonaliserbar:*
  - $n$ forskellige egenværdier $=>$ ALTID diagonaliserbar
  - Symmetrisk matrix $=>$ ALTID diagonaliserbar (og reelle egenværdier)

  *MC-gæt:* Hvis $"am"(lambda) > "gm"(lambda)$ for nogen $lambda$, er matricen IKKE diagonaliserbar.
]

= Uge 12: Systemer af Lineære Differentialligninger

== Vurdér om differentialligning er lineær og homogen

#important[
  *Homogen vs. Inhomogen — Eksamensklassiker!*

  Spørgsmålet "Er systemet homogent eller inhomogent?" optræder ofte som del a) i eksamensopgaver.
]

#note-box[
  *Fremgangsmåde:* (Definition 13.0.2)

  For $bold(f)'(t) = bold(A) bold(f)(t) + bold(g)(t)$:

  1. Skriv systemet på matrixform
  2. Identificér $bold(g)(t)$:
    - $bold(g)(t) = bold(0)$: *Homogen*
    - $bold(g)(t) eq.not bold(0)$: *Inhomogen*

  *Hurtig tjek:* Kig efter led der IKKE indeholder $f_1, f_2, ...$ funktionerne.
  - Kun $f$-led: Homogen
  - Konstanter eller funktioner af $t$ alene: Inhomogen
]

#example(title: [Klassificér ODE-systemer])[
  *System 1:*
  $ cases(f'_1(t) = f_1(t) + 2f_2(t), f'_2(t) = 2f_1(t) + f_2(t)) $

  På matrixform: $bold(f)'(t) = mat(1, 2;2, 1) bold(f)(t) + vec(0, 0)$

  *Svar:* Homogent (ingen ekstra led)

  ---

  *System 2:*
  $ cases(f'_1(t) = 2f_1(t) - f_2(t) + e^t, f'_2(t) = f_1(t) + 3f_2(t)) $

  På matrixform: $bold(f)'(t) = mat(2, -1;1, 3) bold(f)(t) + vec(e^t, 0)$

  *Svar:* Inhomogent (pga. $e^t$ leddet)
]

== Løsning til førsteordens differentialligning

#note-box[
  *Gættemetoden (bedste strategi):*
  1. Find løsning til homogen ligning
  2. Gæt partikulær løsning til inhomogen
  3. Fuldstændig løsning = homogen + partikulær

  *Alternativ:* Panserformlen (sætning 13.1.1, korollar 13.1.2, lemma 13.1.3)
]

== Homogent system med reelle egenværdier

#important[
  *Løsning af homogent ODE-system — Komplet metode!*

  Dette er en af de vigtigste eksamensopgaver. Følg trinene nøje.
]

#note-box[
  *For $bold(f)'(t) = bold(A) bold(f)(t)$:*

  *Trin 1: Find egenværdier*
  - Opstil det karakteristiske polynomium: $det(bold(A) - lambda bold(I)_n) = 0$
  - Løs for $lambda$ (brug diskriminantformlen for 2. grad)

  *Trin 2: Find egenvektorer*
  - For hver egenværdi $lambda_i$: Løs $(bold(A) - lambda_i bold(I)) bold(v) = bold(0)$
  - Rækkereducér og aflæs egenvektoren

  *Trin 3: Skriv fuldstændig løsning*
  $ bold(f)(t) = c_1 e^(lambda_1 t) bold(v)_1 + c_2 e^(lambda_2 t) bold(v)_2 + ... $

  *Trin 4: Bestem $c_1, c_2$ fra begyndelsesbetingelser*
  - Sæt $t = 0$: $bold(f)(0) = c_1 bold(v)_1 + c_2 bold(v)_2 = bold(w)$
  - Løs det lineære system for $c_1, c_2$
]

#example(title: [Komplet løsning af homogent ODE-system — E24 Opgave 6])[
  Givet systemet:
  $ cases(f'_1(t) = f_1(t) + 2f_2(t), f'_2(t) = 2f_1(t) + f_2(t)) $

  a) Er systemet homogent eller inhomogent?
  b) Find den fuldstændige reelle løsning.
  c) Find løsningen med $f_1(0) = 3$, $f_2(0) = 5$.

  #solution()[
    *Del a) — Homogen/Inhomogen:*

    Systemet er *homogent* da der kun er $f_1$ og $f_2$ led (ingen konstanter eller funktioner af $t$ alene).

    ---

    *Del b) — Fuldstændig løsning:*

    *Trin 1: Opskriv på matrixform*
    $ bold(A) = mat(1, 2;2, 1) $

    *Trin 2: Find egenværdier*

    Det karakteristiske polynomium:
    $ det(bold(A) - lambda bold(I)) = det mat(1-lambda, 2;2, 1-lambda) = (1-lambda)^2 - 4 $
    $ = 1 - 2lambda + lambda^2 - 4 = lambda^2 - 2lambda - 3 $

    Løs $lambda^2 - 2lambda - 3 = 0$:
    $ lambda = (2 plus.minus sqrt(4 + 12))/2 = (2 plus.minus 4)/2 $

    *Egenværdier:* $lambda_1 = 3$, $lambda_2 = -1$

    *Trin 3: Find egenvektorer*

    For $lambda_1 = 3$:
    $ bold(A) - 3bold(I) = mat(-2, 2;2, -2) arrow.long^("RREF") mat(1, -1;0, 0) $
    Giver $v_1 = v_2$, så $bold(v)_1 = vec(1, 1)$

    For $lambda_2 = -1$:
    $ bold(A) - (-1)bold(I) = mat(2, 2;2, 2) arrow.long^("RREF") mat(1, 1;0, 0) $
    Giver $v_1 = -v_2$, så $bold(v)_2 = vec(-1, 1)$ eller $vec(1, -1)$

    *Trin 4: Fuldstændig løsning*
    $ bold(f)(t) = c_1 e^(3t) vec(1, 1) + c_2 e^(-t) vec(-1, 1) $

    Eller som system:
    $ f_1(t) = c_1 e^(3t) - c_2 e^(-t) $
    $ f_2(t) = c_1 e^(3t) + c_2 e^(-t) $

    ---

    *Del c) — Partikulær løsning med begyndelsesbetingelser:*

    Sæt $t = 0$:
    $ f_1(0) = c_1 - c_2 = 3 $
    $ f_2(0) = c_1 + c_2 = 5 $

    Addér ligningerne: $2c_1 = 8 => c_1 = 4$

    Fra $c_1 + c_2 = 5$: $c_2 = 5 - 4 = 1$

    *Partikulær løsning:*
    $ f_1(t) = 4e^(3t) - e^(-t) $
    $ f_2(t) = 4e^(3t) + e^(-t) $
  ]
]

== Inhomogent system med reelle egenværdier

#note-box[
  *For $bold(f)'(t) = bold(A) bold(f)(t) + bold(q)(t)$:*

  1. Find fuldstændig løsning til homogent system
  2. Gæt partikulær løsning baseret på $bold(q)(t)$:
    - Førstegradspolynomium $=>$ gæt førstegradspolynomium
    - Eksponentialfunktion $=>$ gæt eksponentialfunktion
    - $cos$/$sin$ $=>$ gæt kombination af $cos$ og $sin$
  3. Isolér variable
  4. Fuldstændig løsning = homogen + partikulær
]

== Homogent system med komplekse egenværdier

#note-box[
  *Fremgangsmåde:* (Korollar 13.2.6)

  1. Find komplekse egenværdier og egenvektorer
  2. For komplekst par $mu = alpha plus.minus beta i$:
    $ bold(f)(t) = e^(alpha t)(c_1 "Re"(bold(w) e^(i beta t)) + c_2 "Im"(bold(w) e^(i beta t))) $
  3. Omregn via Eulers formel (ligninger 3.7 og 3.8)
  4. Anvend begyndelsesbetingelser som før
]

#math-hint(
  )[
  *Homogen vs. Inhomogen:*
  - Højreside $= bold(0)$ $=>$ homogen
  - Alt andet $=>$ inhomogen

  *Løsningsform (homogen):*
  - Reelle egenværdier: $c_1 e^(lambda_1 t) bold(v)_1 + c_2 e^(lambda_2 t) bold(v)_2$
  - Komplekse egenværdier $alpha plus.minus beta i$: $e^(alpha t)(cos(beta t), sin(beta t))$-kombination

  *Begyndelsesværdi:* Sæt $t = 0$, løs for $c_1, c_2$.

  *MC-gæt:* Hvis egenværdierne er rent imaginære ($alpha = 0$), oscillerer løsningen (ingen eksponentiel vækst/fald).
]

= Uge 13: Differentialligninger af n'te Orden

== Homogen andenordens differentialligning

#note-box[
  *For $f''(t) + a_1 f'(t) + a_0 f(t) = 0$:*

  1. Opstil karakteristisk polynomium (definition 13.3.2): $lambda^2 + a_1 lambda + a_0 = 0$
  2. Udregn diskriminant: $D = a_1^2 - 4 a_0$
  3. Løsning afhænger af $D$:
    - $D > 0$: To reelle rødder $=>$ $f(t) = c_1 e^(lambda_1 t) + c_2 e^(lambda_2 t)$ (formel 13.15)
    - $D < 0$: Komplekse rødder $alpha plus.minus beta i$ $=>$ $f(t) = e^(alpha t)(c_1 cos(beta t) + c_2 sin(beta t))$ (formel 13.16)
    - $D = 0$: Dobbeltrod $=>$ $f(t) = (c_1 + c_2 t) e^(lambda t)$ (formel 13.17)
]

== Inhomogen andenordens differentialligning

#note-box[
  *Fremgangsmåde:* (Korollar 13.3.2)

  1. Find løsning til den homogene version
  2. Find partikulær løsning ved gæt
  3. Fuldstændig løsning = homogen + partikulær
]

== Begyndelsesværdier

#note-box[
  Ved to begyndelsesbetingelser til andenordens differentialligning:

  *Indsæt IKKE* betingelserne én efter én!

  Kendes $f(t_0)$ og $f'(t_0)$, findes én unik partikulær løsning der opfylder begge betingelser.
  Løs ligningssystemet for $c_1$ og $c_2$ samtidigt.
]

// ═══════════════════════════════════════════════════════════════════════════
// PART 3: EXAM PROBLEMS & MULTIPLE CHOICE TYPES
// ═══════════════════════════════════════════════════════════════════════════

#math-hint()[
  *2. ordens karakteristisk ligning $lambda^2 + a lambda + b = 0$:*
  - $D > 0$: To reelle $=>$ $c_1 e^(lambda_1 t) + c_2 e^(lambda_2 t)$
  - $D = 0$: Dobbeltrod $=>$ $(c_1 + c_2 t) e^(lambda t)$
  - $D < 0$: Komplekse $alpha plus.minus beta i$ $=>$ $e^(alpha t)(c_1 cos(beta t) + c_2 sin(beta t))$

  *Partikulær løsning gæt:*
  - Højreside polynomium $=>$ gæt polynomium af samme grad
  - Højreside $e^(k t)$ $=>$ gæt $A e^(k t)$ (medmindre $k$ er egenværdi)
  - Højreside $sin$/$cos$ $=>$ gæt $A cos + B sin$

  *MC-gæt:* Løsninger til homogene ligninger indeholder ALDRIG konstante led alene (undtagen hvis $lambda = 0$).
]

= Eksamensopgaver - Løste Eksempler

== Hints
#math-hint()[
  *Generelle MC-strategier:*

  1. *Eliminér først:* Fjern åbenlyst forkerte svar
  2. *Indsæt tal:* Prøv $x = 0, 1, -1$ i abstrakte udtryk
  3. *Dimensionstjek:* Passer dimensionerne i svaret?
  4. *Ekstremer:* Hvad sker ved $t -> 0$, $t -> infinity$?

  *Typiske fælder:*
  - Fortegnsfejl (check fortegn i alle led)
  - $det(bold(A) + bold(B)) eq.not det(bold(A)) + det(bold(B))$
  - Glemmer kompleks konjugat-rod

  *Når tiden er knap:*
  - Triangulær matrix? Egenværdier = diagonal
  - $det = 0$? Ikke invertibel, $lambda = 0$ er egenværdi
  - Reelle koefficienter + kompleks rod? Den konjugerede er også rod
]

== Opgave 1: Logik og Mængdelære

#note-box[
  *Fremgangsmåde: Sandhedstabeller*

  1. Identificér alle atomare udsagn ($P$, $Q$, $R$, ...)
  2. Opret en tabel med $2^n$ rækker (hvor $n$ = antal atomare udsagn)
  3. Udfyld alle kombinationer af 0/1 for de atomare udsagn
  4. Beregn mellemresultater (f.eks. $P or Q$) fra inderst til yderst
  5. Anvend definitionen af implikation: $A => B equiv not A or B$ (falsk kun når $A$ er sand og $B$ er falsk)
  6. Udfyld den endelige søjle

  *Fremgangsmåde: Mængdeoperationer*

  1. Skriv elementerne i hver mængde eksplicit op
  2. Beregn indefra og ud:
    - $A union B$: Alle elementer der er i $A$ *eller* $B$ (eller begge)
    - $A inter B$: Alle elementer der er i *både* $A$ og $B$
    - $A without B$: Elementer i $A$ som *ikke* er i $B$
  3. Skriv det endelige resultat som en mængde
]

#example(title: [1a - Sandhedstabel for $(P or Q or R) => Q$])[
  Opstil sandhedstabellen for det logiske udsagn $(P or Q or R) => Q$.

  #solution()[
    *Sætning:* Implikation: $A => B equiv not A or B$

    Implikationen $(P or Q or R) => Q$ er kun falsk når antecedenten er sand og konklusionen er falsk.

    #align(center)[
      #table(
        columns: 5,
        align: center,
        stroke: 0.5pt,
        [$P$],
        [$Q$],
        [$R$],
        [$P or Q or R$],
        [$(P or Q or R) => Q$],
        [0],
        [0],
        [0],
        [0],
        [1],
        [0],
        [0],
        [1],
        [1],
        [0],
        [0],
        [1],
        [0],
        [1],
        [1],
        [0],
        [1],
        [1],
        [1],
        [1],
        [1],
        [0],
        [0],
        [1],
        [0],
        [1],
        [0],
        [1],
        [1],
        [0],
        [1],
        [1],
        [0],
        [1],
        [1],
        [1],
        [1],
        [1],
        [1],
        [1],
      )
    ]

    *Nøgleindsigt:* Implikationen er falsk præcis når $Q = 0$ og mindst én af $P, R$ er 1.
  ]
]

#example(title: [1b - Mængdeoperationer])[
  Givet $A = {0,1,2}$, $B = {1,2,3}$, $C = {3,4,5}$. Bestem $(A union B) inter C$.

  #solution()[
    *Trin 1:* Beregn $A union B$ (alle elementer i $A$ eller $B$):
    $ A union B = {0,1,2} union {1,2,3} = {0,1,2,3} $

    *Trin 2:* Beregn $(A union B) inter C$ (elementer i begge mængder):
    $ (A union B) inter C = {0,1,2,3} inter {3,4,5} = {3} $

    *Svar:* $(A union B) inter C = {3}$
  ]
]

== Opgave 2: Komplekse Tal - Rødder

#note-box[
  *Fremgangsmåde: Løs $z^n = w$ (De Moivres formel)*

  1. Udtryk $w$ på polær form: $w = r e^(i theta)$
    - Find modulus: $r = |w| = sqrt(a^2 + b^2)$ hvis $w = a + b i$
    - Find argument: $theta = arg(w)$ (vinklen fra den positive reelle akse)

  2. Anvend De Moivres formel:
    $ z_k = root(n, r) dot e^(i(theta + 2 pi k)/n), quad k = 0, 1, ..., n-1 $

  3. Beregn de $n$ forskellige rødder ved at indsætte $k = 0, 1, ..., n-1$

  4. Verificér at vinklerne er forskellige og korrekt fordelt (de ligger jævnt fordelt på en cirkel)

  *Huskeregel for polær form:*
  - $1 = e^(i dot 0)$
  - $-1 = e^(i pi)$
  - $i = e^(i pi/2)$
  - $-i = e^(-i pi/2)$
]

#example(title: [2 - Løs $z^3 = -i$ på polær form])[
  Find alle løsninger til $z^3 = -i$ og angiv dem på polær form.

  #solution()[
    *Sætning:* De Moivres formel - For $z^n = w$, hvis $w = r e^(i theta)$, så:
    $ z_k = root(n, r) dot e^(i(theta + 2 pi k)/n), quad k = 0, 1, ..., n-1 $

    *Trin 1:* Udtryk $-i$ på polær form.
    $ -i = e^(-i pi/2) $
    (Da $-i$ ligger på den negative imaginære akse: vinkel $= -pi/2$, modulus $= 1$)

    *Trin 2:* Anvend De Moivres formel med $n = 3$, $r = 1$, $theta = -pi/2$.
    $ z = r^(1/3) e^(i v) "hvor" r^3 = 1 => r = 1 $
    $ 3v = -pi/2 + 2 pi k, quad k in ZZ $
    $ v = -pi/6 + (2 pi k)/3 $

    *Trin 3:* Find de tre forskellige rødder ($k = 0, 1, 2$):

    #align(center)[
      #table(
        columns: 3,
        align: center,
        stroke: 0.5pt,
        [$k$],
        [Vinkel $v$],
        [Løsning],
        [0],
        [$-pi/6$],
        [$z_1 = e^(-i pi/6)$],
        [1],
        [$-pi/6 + (2pi)/3 = pi/2$],
        [$z_2 = e^(i pi/2)$],
        [2],
        [$-pi/6 + (4pi)/3 = -(5pi)/6$],
        [$z_3 = e^(-i (5pi)/6)$],
      )
    ]

    *Endelige svar:*
    $ z_1 = e^(-i pi/6), quad z_2 = e^(i pi/2), quad z_3 = e^(-i (5pi)/6) $
  ]
]

== Opgave 3: Matrixpotenser og Induktion

#note-box[
  *Fremgangsmåde: Matrixmultiplikation (i hånden)*

  1. For $bold(C) = bold(A) dot bold(B)$: element $(i,j)$ i $bold(C)$ er prikproduktet af række $i$ i $bold(A)$ med søjle $j$ i $bold(B)$
  2. $(bold(A) bold(B))_(i j) = sum_k A_(i k) B_(k j)$
  3. Beregn systematisk: tag én indgang ad gangen

  *Fremgangsmåde: Induktionsbevis*

  1. *Basistilfælde:* Verificér at formlen gælder for den mindste værdi (f.eks. $n = 1$ eller $n = 2$)

  2. *Induktionshypotese:* Antag at formlen gælder for $n - 1$ (eller $n = k$)

  3. *Induktionsskridt:* Vis at formlen så også gælder for $n$ (eller $n = k + 1$)
    - Brug induktionshypotesen til at omskrive et udtryk
    - Manipulér algebraisk til det ønskede resultat

  4. *Konklusion:* Formlen gælder for alle $n >= n_0$ ved induktionsprincippet
]

#example(title: [3a - Beregn $bold(A)^2$])[
  Givet $bold(A) = mat(a, 1;0, 2a) in CC^(2 times 2)$, beregn $bold(A)^2$.

  #solution()[
    *Matrixmultiplikation:* $(bold(A) bold(B))_(i j) = sum_k A_(i k) B_(k j)$

    $ bold(A)^2 = mat(a, 1;0, 2a) dot mat(a, 1;0, 2a) $

    Beregn hver indgang:
    - $(1,1)$: $a dot a + 1 dot 0 = a^2$
    - $(1,2)$: $a dot 1 + 1 dot 2a = a + 2a = 3a$
    - $(2,1)$: $0 dot a + 2a dot 0 = 0$
    - $(2,2)$: $0 dot 1 + 2a dot 2a = 4a^2$

    $ bold(A)^2 = mat(a^2, 3a;0, 4a^2) = mat(a^2, (2^2 - 1)a^(2-1);0, (2a)^2) $
  ]
]

#example(
  title: [3b - Bevis ved induktion],
)[
  Vis ved induktion at $bold(A)^n = mat(a^n, (2^n - 1)a^(n-1);0, (2a)^n)$ for alle $n in ZZ_(>=2)$.

  #solution(
    )[
    *Induktionsprincippet:*
    1. Basistilfælde: Vis $P(2)$
    2. Induktionsskridt: Antag $P(n-1)$, vis $P(n)$

    *Basistilfælde ($n = 2$):*
    Fra del (a) har vi verificeret:
    $ bold(A)^2 = mat(a^2, 3a;0, 4a^2) = mat(a^2, (2^2 - 1)a^1;0, (2a)^2) $

    *Induktionshypotese:*
    Antag sand for $n - 1$:
    $ bold(A)^(n-1) = mat(a^(n-1), (2^(n-1) - 1)a^(n-2);0, (2a)^(n-1)) $

    *Induktionsskridt:*
    $ bold(A)^n = bold(A)^(n-1) dot bold(A) = mat(a^(n-1), (2^(n-1) - 1)a^(n-2);0, (2a)^(n-1)) dot mat(a, 1;0, 2a) $

    Beregn hver indgang:
    - $(1,1)$: $a^(n-1) dot a + (2^(n-1) - 1)a^(n-2) dot 0 = a^n$
    - $(1,2)$: $a^(n-1) dot 1 + (2^(n-1) - 1)a^(n-2) dot 2a$
      $ = a^(n-1) + 2(2^(n-1) - 1)a^(n-1) = a^(n-1)[1 + 2^n - 2] = (2^n - 1)a^(n-1) $
    - $(2,1)$: $0 dot a + (2a)^(n-1) dot 0 = 0$
    - $(2,2)$: $0 dot 1 + (2a)^(n-1) dot 2a = (2a)^n$

    $ bold(A)^n = mat(a^n, (2^n - 1)a^(n-1);0, (2a)^n) $

    *Konklusion:* Ved induktionsprincippet gælder formlen for alle $n in ZZ_(>=2)$. $square$
  ]
]

== Opgave 4: Rang og Nulitet

#note-box[
  *Fremgangsmåde: Find rang af en matrix*

  1. Skriv matricen op
  2. Udfør rækkeoperationer til reduceret trappeform (RREF):
    - Byt rækker
    - Gang en række med en skalar $eq.not 0$
    - Læg et multiplum af én række til en anden
  3. Tæl antal pivoter (ledende 1-taller)
  4. $"rank"(bold(A))$ = antal pivoter

  *Fremgangsmåde: Find nulitet (dimension af kernen)*

  Brug Rang-Nulitets-sætningen:
  $ "rank"(bold(A)) + "null"(bold(A)) = n $
  hvor $n$ er antal søjler i $bold(A)$.

  Altså: $"null"(bold(A)) = n - "rank"(bold(A))$
]

#example(title: [4a - Rang af matrix $bold(B)$])[
  Givet $bold(B) = mat(1, 2, 0;-1, 2, -4;3, 2, 4)$, bestem $"rank"(bold(B))$.

  #solution()[
    *Definition:* Rang = antal pivoter i RREF (reduceret række-echelon form).

    *Trin 1:* Rækkeréducer til RREF.

    $ mat(1, 2, 0;-1, 2, -4;3, 2, 4) arrow.long_(R_2 <- R_2 + R_1) mat(1, 2, 0;0, 4, -4;3, 2, 4) $

    $ arrow.long_(R_3 <- R_3 - 3R_1) mat(1, 2, 0;0, 4, -4;0, -4, 4) $

    $ arrow.long_(R_3 <- R_3 + R_2) mat(1, 2, 0;0, 4, -4;0, 0, 0) $

    $ arrow.long_(R_2 <- 1/4 R_2) mat(1, 2, 0;0, 1, -1;0, 0, 0) $

    *Trin 2:* Tæl pivoter.

    RREF: $mat(1, 2, 0;0, 1, -1;0, 0, 0)$

    Pivoter i søjle 1 og 2 $=>$ *2 pivoter*

    $ bold("rank"(bold(B)) = 2) $
  ]
]

#example(title: [4b - Nulitet af matrix $bold(B)$])[
  Bestem kernens dimension for matricen $bold(B)$.

  #solution()[
    *Rang-Nulitets-sætningen:* For $bold(A) in RR^(m times n)$:
    $ "rank"(bold(A)) + "null"(bold(A)) = n $
    hvor $n$ er antal søjler.

    For $bold(B) in RR^(3 times 3)$:
    - $n = 3$ (søjler)
    - $"rank"(bold(B)) = 2$ (fra del a)

    $ "null"(bold(B)) = n - "rank"(bold(B)) = 3 - 2 = 1 $

    $ bold("null"(bold(B)) = 1) $
  ]
]

== Opgave 5: Systemer af ODE'er

#note-box[
  *Fremgangsmåde: Homogent system via egenvektormetoden*

  Givet system $bold(f)'(t) = bold(A) dot bold(f)(t)$ hvor $bold(A) in RR^(n times n)$:

  1. Find det karakteristiske polynomium: $p_(bold(A))(Z) = det(bold(A) - Z bold(I)_n)$
  2. Find egenværdierne $lambda_1, ..., lambda_r$ (rødderne i $p_(bold(A))(Z) = 0$)
  3. For hver egenværdi $lambda_i$: Find en basis for egenrummet $E_(lambda_i) = ker(bold(A) - lambda_i bold(I)_n)$
  4. Tjek at $bold(A)$ er diagonalisérbar: $sum_i "gm"(lambda_i) = n$
  5. Den fuldstændige løsning er:
    $ bold(f)(t) = c_1 bold(v)_1 e^(lambda_1 t) + c_2 bold(v)_2 e^(lambda_2 t) + dots.c + c_n bold(v)_n e^(lambda_n t) $
    hvor $bold(v)_i$ er egenvektorer og $c_i in RR$.

  *Fremgangsmåde: Begyndelsesværdiproblem for systemer*

  1. Find den fuldstændige løsning med parametre $c_1, ..., c_n$
  2. Indsæt $t = t_0$ i den fuldstændige løsning
  3. Sæt $bold(f)(t_0) = bold(y)_0$ og løs det lineære ligningssystem for $c_1, ..., c_n$
  4. Indsæt værdierne af $c_1, ..., c_n$ i den fuldstændige løsning
]

Givet systemet:
$ cases(f'_1(t) = f_1(t) + f_2(t), f'_2(t) = 2f_2(t)) $

#example(title: [5a - Homogent eller inhomogent?])[
  Er systemet homogent eller inhomogent?

  #solution()[
    *Definition:* Et lineært ODE-system $bold(f)'(t) = bold(A) bold(f)(t) + bold(g)(t)$ er:
    - *Homogent* hvis $bold(g)(t) = bold(0)$
    - *Inhomogent* hvis $bold(g)(t) eq.not bold(0)$

    Omskriv på matrixform:
    $ vec(f'_1(t), f'_2(t)) = mat(1, 1;0, 2) vec(f_1(t), f_2(t)) + vec(0, 0) $

    Da $bold(g)(t) = vec(0, 0)$, er systemet *homogent*.
  ]
]

#example(title: [5b - Verificér løsning])[
  Er $(f_1(t), f_2(t)) = (e^t, e^(2t))$ en løsning til systemet?

  #solution()[
    *Metode:* Indsæt og tjek om begge ligninger er opfyldt.

    *Tjek ligning 1:* $f'_1(t) = f_1(t) + f_2(t)$
    - VL: $f'_1(t) = d/(d t)(e^t) = e^t$
    - HL: $f_1(t) + f_2(t) = e^t + e^(2t)$

    $e^t eq.not e^t + e^(2t)$ (da $e^(2t) eq.not 0$)

    *Konklusion:* $(e^t, e^(2t))$ er *IKKE en løsning* da første ligning ikke er opfyldt.
  ]
]

#example(title: [5c - Fuldstændig løsning])[
  Bestem den fuldstændige reelle løsning til systemet.

  #solution()[
    *Metode:* Find egenværdier og egenvektorer for koefficientmatricen.

    *Trin 1:* Skriv på matrixform $bold(f)'(t) = bold(A) bold(f)(t)$ hvor:
    $ bold(A) = mat(1, 1;0, 2) $

    *Trin 2:* Find egenværdier via $det(bold(A) - lambda bold(I)) = 0$:
    $ det mat(1 - lambda, 1;0, 2 - lambda) = (1 - lambda)(2 - lambda) = 0 $
    $ lambda_1 = 1, quad lambda_2 = 2 $

    *Trin 3:* Find egenvektorer.

    For $lambda_1 = 1$: Løs $(bold(A) - bold(I))bold(v) = bold(0)$
    $ mat(0, 1;0, 1) vec(v_1, v_2) = vec(0, 0) => v_2 = 0 $
    $ bold(v)_1 = vec(1, 0) $

    For $lambda_2 = 2$: Løs $(bold(A) - 2bold(I))bold(v) = bold(0)$
    $ mat(-1, 1;0, 0) vec(v_1, v_2) = vec(0, 0) => v_1 = v_2 $
    $ bold(v)_2 = vec(1, 1) $

    *Trin 4:* Fuldstændig løsning:
    $ bold(f)(t) = c_1 e^(lambda_1 t) bold(v)_1 + c_2 e^(lambda_2 t) bold(v)_2 $
    $ bold(f)(t) = c_1 e^t vec(1, 0) + c_2 e^(2t) vec(1, 1) $

    *På komponentform:*
    $ f_1(t) = c_1 e^t + c_2 e^(2t), quad f_2(t) = c_2 e^(2t), quad c_1, c_2 in RR $
  ]
]

#example(title: [5d - Begyndelsesværdiproblem])[
  Bestem løsningen der opfylder $f_1(0) = 0$ og $f_2(0) = 1$.

  #solution()[
    *Fra den fuldstændige løsning:*
    $ f_1(t) = c_1 e^t + c_2 e^(2t), quad f_2(t) = c_2 e^(2t) $

    *Anvend begyndelsesbetingelser ved $t = 0$:*

    Fra $f_2(0) = 1$:
    $ c_2 e^0 = 1 => c_2 = 1 $

    Fra $f_1(0) = 0$:
    $ c_1 e^0 + c_2 e^0 = 0 => c_1 + 1 = 0 => c_1 = -1 $

    *Partikulær løsning:*
    $ f_1(t) = -e^t + e^(2t), quad f_2(t) = e^(2t) $
  ]
]

== Opgave 6: Lineære Afbildninger og Vektorrum

#note-box[
  *Fremgangsmåde: Beregn $L(bold(v))$ via afbildningsmatrix*

  1. Find koordinaterne $[bold(v)]_beta$ i basen $beta$ ved at løse:
    $ bold(v) = x_1 bold(b)_1 + x_2 bold(b)_2 + ... + x_n bold(b)_n $

  2. Anvend afbildningsmatricen:
    $ [L(bold(v))]_gamma = amat(L, gamma, beta) dot [bold(v)]_beta $

  3. Konvertér tilbage fra koordinater til vektorer:
    $ L(bold(v)) = y_1 bold(c)_1 + y_2 bold(c)_2 + ... + y_m bold(c)_m $
    hvor $(y_1, ..., y_m)^T = [L(bold(v))]_gamma$

  *Fremgangsmåde: Tjek injektivitet/surjektivitet*

  - *Injektiv* $<=>$ $ker(L) = {bold(0)}$ $<=>$ afbildningsmatricen har fuld søjlerang
  - *Surjektiv* $<=>$ $"rank"(L) = dim("codomæne")$ $<=>$ afbildningsmatricen har fuld rækkerang
  - For kvadratisk matrix: Injektiv $<=>$ Surjektiv $<=>$ $det eq.not 0$
]

Lad $V = RR^(2 times 2)$ med ordnet basis:
$ beta = (mat(0, 1;1, 1), mat(1, 0;1, 1), mat(1, 1;0, 1), mat(1, 1;1, 0)) $

Afbildningsmatrix: $amat(L, beta, beta) = mat(1, 1, 1, 1;0, 1, 1, 1;0, 0, 1, 1;0, 0, 0, 1)$

#example(title: [6a - Dimension af $V$])[
  Angiv dimensionen af $V = RR^(2 times 2)$.

  #solution()[
    *Definition:* $dim(V)$ = antal elementer i en basis for $V$.

    Standardbasen for $RR^(2 times 2)$ er:
    $ {mat(1, 0;0, 0), mat(0, 1;0, 0), mat(0, 0;1, 0), mat(0, 0;0, 1)} $

    Dette har 4 elementer (én for hver indgang i en $2 times 2$ matrix).

    *Alternativt:* $RR^(2 times 2) tilde.eq RR^4$, så $dim(V) = 4$.

    $ bold(dim(V) = 4) $
  ]
]

#example(
  title: [6b - Beregn $L(mat(3, 3;3, 3))$],
)[
  Beregn $L(mat(3, 3;3, 3))$.

  #solution(
    )[
    *Strategi:*
    1. Udtryk inputmatrix som linearkombination af basisvektorer
    2. Anvend afbildningsmatricen
    3. Konvertér tilbage til matrixform

    *Trin 1:* Find koordinater $[bold(M)]_beta$ hvor $bold(M) = mat(3, 3;3, 3)$.

    Løs: $x_1 mat(0, 1;1, 1) + x_2 mat(1, 0;1, 1) + x_3 mat(1, 1;0, 1) + x_4 mat(1, 1;1, 0) = mat(3, 3;3, 3)$

    Indgangsvis ligninger:
    - $(1,1)$: $0 x_1 + 1 x_2 + 1 x_3 + 1 x_4 = 3$
    - $(1,2)$: $1 x_1 + 0 x_2 + 1 x_3 + 1 x_4 = 3$
    - $(2,1)$: $1 x_1 + 1 x_2 + 0 x_3 + 1 x_4 = 3$
    - $(2,2)$: $1 x_1 + 1 x_2 + 1 x_3 + 0 x_4 = 3$

    Læg alle fire ligninger sammen: $3(x_1 + x_2 + x_3 + x_4) = 12 => x_1 + x_2 + x_3 + x_4 = 4$

    Fra ligning 1: $x_2 + x_3 + x_4 = 3 => x_1 = 1$

    Tilsvarende: $x_2 = 1, x_3 = 1, x_4 = 1$

    $ [bold(M)]_beta = vec(1, 1, 1, 1) $

    *Trin 2:* Anvend afbildningsmatrix:
    $ [L(bold(M))]_beta = amat(L, beta, beta) dot [bold(M)]_beta = mat(1, 1, 1, 1;0, 1, 1, 1;0, 0, 1, 1;0, 0, 0, 1) vec(1, 1, 1, 1) = vec(4, 3, 2, 1) $

    *Trin 3:* Konvertér tilbage:
    $ L(bold(M)) = 4 mat(0, 1;1, 1) + 3 mat(1, 0;1, 1) + 2 mat(1, 1;0, 1) + 1 mat(1, 1;1, 0) $
    $ = mat(0, 4;4, 4) + mat(3, 0;3, 3) + mat(2, 2;0, 2) + mat(1, 1;1, 0) = mat(6, 7;8, 9) $
  ]
]

#example(
  title: [6c - Er $L$ injektiv?],
)[
  Er den lineære afbildning $L$ injektiv?

  #solution(
    )[
    *Sætning:* En lineær afbildning $L: V -> W$ er injektiv $<=>$ $ker(L) = {bold(0)}$ $<=>$ afbildningsmatricen har fuld søjlerang.

    *Metode - Tjek om afbildningsmatricen er invertibel:*

    $amat(L, beta, beta) = mat(1, 1, 1, 1;0, 1, 1, 1;0, 0, 1, 1;0, 0, 0, 1)$

    Dette er en *øvre trekantsmatrix*. Dens determinant er produktet af diagonalelementerne:
    $ det(amat(L, beta, beta)) = 1 dot 1 dot 1 dot 1 = 1 eq.not 0 $

    *Konklusion:* Da afbildningsmatricen er invertibel (det $eq.not 0$), har afbildningen triviel kerne, derfor:

    $ bold(L "er injektiv") $

    *Bemærk:* Da $L: V -> V$ med $dim(V) = 4$ og $L$ er injektiv, er $L$ også *surjektiv* (rang-nulitets-sætningen), altså *bijektiv*.
  ]
]

= Multiple Choice - Opgavetyper

== MC1: Rødder i polynomium

#note-box[
  *Fremgangsmåde: Find rødder i et polynomium*

  1. Identificér faktorer på formen $(Z - a)$ - disse giver umiddelbart rod $Z = a$
  2. For 2.-gradspolynomier $a Z^2 + b Z + c$: Brug kvadratisk formel
    $ Z = (-b plus.minus sqrt(b^2 - 4 a c))/(2a) $
  3. Husk: Hvis diskriminanten $b^2 - 4 a c < 0$, er rødderne komplekse
  4. Komplekse rødder til polynomier med reelle koefficienter kommer i konjugerede par
]

#example(title: [Hvilke tal er rødder i polynomiet?])[
  Lad $a in RR$, og betragt 3.-gradspolynomiet:
  $ p(Z) = (Z - a)(Z^2 - 2Z + 5) $
  Hvilke af følgende tal er en rod i polynomiet?

  #solution()[
    *Metode:* Polynomiet har rødder ved $Z = a$ og rødderne af $Z^2 - 2Z + 5 = 0$.

    Løs $Z^2 - 2Z + 5 = 0$ med kvadratisk formel:
    $ Z = (2 plus.minus sqrt(4 - 20))/2 = (2 plus.minus sqrt(-16))/2 = (2 plus.minus 4i)/2 = 1 plus.minus 2i $

    Rødderne er: $Z = a$, $Z = 1 + 2i$, $Z = 1 - 2i$

    *Svar:* $bold(1 - 2i)$
  ]
]

== MC2: Afstand i det komplekse plan

#note-box[
  *Fremgangsmåde: Find afstand fra 0 i det komplekse plan*

  1. Afstanden fra $0$ til $z$ er modulus $|z|$
  2. For $z = a + b i$: $|z| = sqrt(a^2 + b^2)$
  3. For $z = r e^(i theta)$: $|z| = r$
  4. Særlige tilfælde:
    - $|e^(i theta)| = 1$ for alle $theta$
    - $|r e^(i theta)| = |r|$
    - $|z_1 dot z_2| = |z_1| dot |z_2|$
]

#example(title: [Hvilket komplekst tal ligger længst fra 0?])[
  Hvilket af følgende komplekse tal ligger længst fra $0$ i det komplekse plan?

  Valgmuligheder: $i$, $e^(6i)$, $2+i$, $pi i$, $1+i$, $1-i$, $4e^i$

  #solution()[
    *Metode:* Afstanden fra $0$ er modulus $|z|$.

    Beregn $|z|$ for hver:
    - $|i| = 1$
    - $|e^(6i)| = 1$ (enhver $e^(i theta)$ har modulus 1)
    - $|2 + i| = sqrt(4 + 1) = sqrt(5) approx 2.24$
    - $|pi i| = pi approx 3.14$
    - $|1 + i| = sqrt(2) approx 1.41$
    - $|1 - i| = sqrt(2) approx 1.41$
    - $|4e^i| = 4$ (da $|r e^(i theta)| = r$)

    *Svar:* $bold(4e^i)$ med $|4e^i| = 4$
  ]
]

== MC3: Funktionssammensætning

#note-box[
  *Fremgangsmåde: Beregn $g(f^(-1)(y))$*

  1. Find $f^(-1)(y)$: Bestem hvilken $x$ opfylder $f(x) = y$
    - For diskrete funktioner: Slå op i tabellen "baglæns"
    - For kontinuerte funktioner: Løs ligningen $f(x) = y$ for $x$
  2. Beregn $g(f^(-1)(y))$ ved at indsætte resultatet i $g$
]

#example(title: [Beregn $g(f^(-1)(3))$])[
  En diskret funktion $f: {1,2,3} -> {1,2,3}$ er givet ved tabellen:
  #align(center)[
    #table(columns: 2, stroke: 0.5pt, [$n$], [$f(n)$], [1], [2], [2], [3], [3], [1])
  ]
  Desuden er $g: {1,2,3} -> NN$ givet ved $g(n) = 4 + n$.

  Bestem $g(f^(-1)(3))$.

  #solution()[
    *Trin 1:* Find $f^(-1)(3)$ - dvs. hvilket $n$ opfylder $f(n) = 3$?

    Fra tabellen: $f(2) = 3$, så $f^(-1)(3) = 2$

    *Trin 2:* Beregn $g(2)$:
    $ g(2) = 4 + 2 = 6 $

    *Svar:* $bold(6)$
  ]
]

== MC4: Løsninger til 2.-ordens ODE

#note-box[
  *Fremgangsmåde: Find generel løsning til homogen 2.-ordens ODE*

  Givet $a f''(t) + b f'(t) + c f(t) = 0$:

  1. Opstil karakteristisk ligning: $a lambda^2 + b lambda + c = 0$
  2. Løs for $lambda$ med kvadratisk formel
  3. Tre tilfælde:
    - *To forskellige reelle rødder* $lambda_1, lambda_2$: $f(t) = c_1 e^(lambda_1 t) + c_2 e^(lambda_2 t)$
    - *Én dobbeltrod* $lambda$: $f(t) = (c_1 + c_2 t) e^(lambda t)$
    - *Komplekse rødder* $alpha plus.minus beta i$: $f(t) = e^(alpha t)(c_1 cos(beta t) + c_2 sin(beta t))$

  *Fremgangsmåde: Verificér om en funktion er løsning*

  1. Beregn $f'(t)$ og $f''(t)$
  2. Indsæt i ODE'en
  3. Tjek om udtrykket forenkler til 0
]

#example(
  title: [Hvilken funktion er IKKE en løsning?],
)[
  Givet den homogene lineære 2.-ordens differentialligning:
  $ f''(t) - 2f'(t) + 5f(t) = 0 $
  Hvilken af følgende er *ikke* en løsning?

  #solution(
    )[
    *Trin 1:* Find den generelle løsning via karakteristisk ligning.
    $ lambda^2 - 2lambda + 5 = 0 $
    $ lambda = (2 plus.minus sqrt(4 - 20))/2 = (2 plus.minus 4i)/2 = 1 plus.minus 2i $

    *Generel løsning:* $f(t) = e^t (c_1 cos(2t) + c_2 sin(2t))$

    *Trin 2:* Tjek hver mulighed - en gyldig løsning skal have formen $e^t dot ("linearkombination af" cos(2t), sin(2t))$.

    Problemet med $f(t) = e^t cos(2t) + sin(2t)$:

    Leddet $sin(2t)$ mangler faktoren $e^t$. Det er *ikke* på formen $e^t(...)$.

    *Svar:* $bold(f(t) = e^t cos(2t) + sin(2t))$
  ]
]

== MC5: Algebraisk multiplicitet

#note-box[
  *Fremgangsmåde: Find algebraisk multiplicitet $> 1$*

  1. Opstil det karakteristiske polynomium $p_(bold(A))(Z) = det(bold(A) - Z bold(I))$
  2. For at få $"am"(lambda_0) > 1$ skal $(lambda - lambda_0)^2$ være en faktor
  3. To måder dette kan ske:
    - En kendt egenværdi er også rod i en anden faktor
    - En faktor har diskriminant = 0 (dobbeltrod)
  4. Løs for den ukendte parameter
]

#example(title: [For hvilken værdi af $a$ har matricen en egenværdi med algebraisk multiplicitet $> 1$?])[
  Givet $a in RR$ og matricen:
  $ bold(A) = mat(2, 0, 0;0, a, 1;0, -1, 1) $

  #solution()[
    *Trin 1:* Find det karakteristiske polynomium.

    $bold(A)$ er blok-diagonal: øverste $1 times 1$ blok giver $lambda = 2$, nederste $2 times 2$ blok:
    $ det mat(a - Z, 1;-1, 1 - Z) = (a - Z)(1 - Z) + 1 = Z^2 - (a+1)Z + (a + 1) $

    Karakteristisk polynomium:
    $ p_(bold(A))(Z) = (Z - 2)(Z^2 - (a+1)Z + (a+1)) $

    *Trin 2:* For algebraisk multiplicitet $> 1$ skal enten:
    - $Z = 2$ også være rod i $Z^2 - (a+1)Z + (a+1) = 0$, eller
    - $Z^2 - (a+1)Z + (a+1)$ have en dobbeltrod (diskriminant $= 0$)

    *Mulighed A:* $Z = 2$ er rod i den kvadratiske:
    $ 4 - 2(a+1) + (a+1) = 0 => 4 - (a+1) = 0 => a = 3 $

    Verificér: Når $a = 3$, bliver polynomiet $(Z - 2)(Z^2 - 4Z + 4) = (Z - 2)(Z - 2)^2 = (Z - 2)^3$

    *Svar:* $bold(a = 3)$
  ]
]

== MC6: Rekursiv matrixligning

#note-box[
  *Fremgangsmåde: Beregn rekursiv matrixligning*

  Givet $bold(c)_k = bold(A) bold(c)_(k-1) + bold(b)$:

  1. Start med $bold(c)_0$ (givet)
  2. Beregn iterativt:
    - $bold(c)_1 = bold(A) bold(c)_0 + bold(b)$
    - $bold(c)_2 = bold(A) bold(c)_1 + bold(b)$
    - osv.
  3. Husk: Matrixmultiplikation først, så vektoraddition
]

#example(
  title: [Bestem $bold(c)_3$],
)[
  Givet:
  $ bold(A) = mat(0, 1;1, 1), quad bold(b) = vec(-1, 1), quad bold(c)_0 = vec(0, 0) $
  og $bold(c)_k = bold(A) bold(c)_(k-1) + bold(b)$ for $k = 1, 2, 3, ...$

  #solution(
    )[
    Beregn iterativt:

    *$k = 1$:*
    $ bold(c)_1 = bold(A) bold(c)_0 + bold(b) = mat(0, 1;1, 1) vec(0, 0) + vec(-1, 1) = vec(0, 0) + vec(-1, 1) = vec(-1, 1) $

    *$k = 2$:*
    $ bold(c)_2 = bold(A) bold(c)_1 + bold(b) = mat(0, 1;1, 1) vec(-1, 1) + vec(-1, 1) = vec(1, 0) + vec(-1, 1) = vec(0, 1) $

    *$k = 3$:*
    $ bold(c)_3 = bold(A) bold(c)_2 + bold(b) = mat(0, 1;1, 1) vec(0, 1) + vec(-1, 1) = vec(1, 1) + vec(-1, 1) = vec(0, 2) $

    *Svar:* $bold(c)_3 = vec(0, 2)$
  ]
]

== MC7: Determinant af matrixprodukt

#note-box[
  *Fremgangsmåde: Beregn determinant af matrixprodukt*

  1. Beregn først matrixproduktet $bold(A) dot bold(B)$
  2. Beregn determinanten af resultatet
  3. For $2 times 2$: $det mat(a, b;c, d) = a d - b c$

  *Alternativ (kun for kvadratiske matricer af samme størrelse):*
  $ det(bold(A) dot bold(B)) = det(bold(A)) dot det(bold(B)) $

  *Tip:* Hvis søjlerne (eller rækkerne) er lineært afhængige, er $det = 0$
]

#example(title: [Bestem $det(bold(A) dot bold(B))$])[
  Givet:
  $ bold(A) = vec(1, 2) in RR^(2 times 1), quad bold(B) = mat(1, 2) in RR^(1 times 2) $

  #solution()[
    *Trin 1:* Beregn $bold(A) dot bold(B)$:
    $ bold(A) dot bold(B) = vec(1, 2) mat(1, 2) = mat(1 dot 1, 1 dot 2;2 dot 1, 2 dot 2) = mat(1, 2;2, 4) $

    *Trin 2:* Beregn determinanten:
    $ det mat(1, 2;2, 4) = 1 dot 4 - 2 dot 2 = 4 - 4 = 0 $

    *Alternativ indsigt:* Søjlerne er lineært afhængige (søjle 2 = 2 $times$ søjle 1), så $det = 0$.

    *Svar:* $bold(det(bold(A) dot bold(B)) = 0)$
  ]
]

== MC8: Underrum og span

#note-box[
  *Fremgangsmåde: Tjek om vektor/polynomium tilhører et span*

  For at tjekke om $bold(v) in "span"(bold(u)_1, ..., bold(u)_k)$:

  1. Opstil ligningen: $bold(v) = alpha_1 bold(u)_1 + ... + alpha_k bold(u)_k$
  2. Dette giver et ligningssystem for $alpha_1, ..., alpha_k$
  3. Hvis systemet har løsning: $bold(v)$ tilhører span
  4. Hvis systemet ikke har løsning: $bold(v)$ tilhører *ikke* span

  *For polynomier:* Sammenlign koefficienter for hver potens af $Z$
]

#example(title: [Hvilket polynomium tilhører IKKE underrummet?])[
  Betragt underrummet $"span"_RR (1 + Z^2, 1 + Z) subset.eq RR[Z]$ (polynomier af grad $<= 2$).

  Hvilket polynomium tilhører *ikke* dette underrum?

  #solution()[
    *Metode:* Et polynomium $p(Z) = a Z^2 + b Z + c$ tilhører $"span"(1 + Z^2, 1 + Z)$ hvis:
    $ p(Z) = alpha(1 + Z^2) + beta(1 + Z) = alpha Z^2 + beta Z + (alpha + beta) $

    Dette giver betingelserne:
    - Koefficient for $Z^2$: $a = alpha$
    - Koefficient for $Z$: $b = beta$
    - Konstant led: $c = alpha + beta = a + b$

    *Test:* For at tilhøre underrummet skal $c = a + b$ (konstantleddet = summen af de andre koefficienter).

    Tjek $-2Z^2 + 3Z + 2$:
    - $a = -2$, $b = 3$, $c = 2$
    - $a + b = -2 + 3 = 1 eq.not 2 = c$

    *Svar:* $bold(-2Z^2 + 3Z + 2)$ tilhører ikke underrummet.
  ]
]

== Polynomium fra rødder (med reelle koefficienter)

#note-box[
  *Fremgangsmåde: Konstruér polynomium fra rødder*

  1. *Identificér alle rødder:*
    - Rødder der er givet direkte
    - Husk: Komplekse rødder kommer i konjugerede par (hvis koefficienterne er reelle)

  2. *Opskriv polynomiet som produkt af faktorer:*
    $ p(Z) = c(Z - r_1)^(m_1) (Z - r_2)^(m_2) ... $
    hvor $m_i$ er multipliciteten

  3. *Forenkl komplekse par:*
    $(Z - (a + b i))(Z - (a - b i)) = Z^2 - 2a Z + (a^2 + b^2)$

  4. *Find den ledende koefficient $c$:*
    Brug en given værdi $p(x_0) = y_0$ til at bestemme $c$

  5. *Udvid polynomiet* for at finde specifikke koefficienter
]

#example(
  title: [Konstruér polynomium fra rødder],
)[
  Lad $p(Z)$ være et polynomium af grad 4 med reelle koefficienter.
  - $2$ er rod med multiplicitet $2$
  - $1 + i$ er rod
  - $p(1) = 7$

  Find $a_0$ og $a_3$.

  #solution(
    )[
    *Sætning:* Hvis et polynomium har reelle koefficienter og $z_0$ er en kompleks rod, så er $overline(z_0)$ også rod.

    *Trin 1:* Identificér alle rødder.
    - $Z = 2$ (multiplicitet 2)
    - $Z = 1 + i$ (givet)
    - $Z = 1 - i$ (kompleks konjugeret, da koefficienterne er reelle)

    *Trin 2:* Opskriv polynomiet.
    $ p(Z) = c(Z - 2)^2 (Z - (1+i))(Z - (1-i)) $

    Udregn $(Z - (1+i))(Z - (1-i))$:
    $ = Z^2 - Z(1-i) - Z(1+i) + (1+i)(1-i) = Z^2 - 2Z + 2 $

    Så: $p(Z) = c(Z - 2)^2(Z^2 - 2Z + 2)$

    *Trin 3:* Brug $p(1) = 7$ til at finde $c$.
    $ p(1) = c(1-2)^2(1 - 2 + 2) = c dot 1 dot 1 = c = 7 $

    *Trin 4:* Udvid polynomiet.
    $ p(Z) = 7(Z^2 - 4Z + 4)(Z^2 - 2Z + 2) $

    Multiplicér ud:
    $ (Z^2 - 4Z + 4)(Z^2 - 2Z + 2) = Z^4 - 6Z^3 + 14Z^2 - 16Z + 8 $

    $ p(Z) = 7Z^4 - 42Z^3 + 98Z^2 - 112Z + 56 $

    *Svar:* $a_0 = 56$, $a_3 = -42$
  ]
]

== Polynomiumsdivision (givet én rod)

#note-box[
  *Fremgangsmåde: Polynomiumsdivision i hånden*

  Givet $p(Z)$ hvor $Z = r$ er rod, så er $(Z - r)$ en faktor.

  1. *Opstil divisionen:* Skriv $p(Z)$ til højre og $(Z - r)$ til venstre

  2. *Find første led i kvotienten:*
    - Tag det ledende led i $p(Z)$ og divider med $Z$
    - Eksempel: $2Z^3 div Z = 2Z^2$

  3. *Gang og træk fra:*
    - Gang kvotientleddet med hele divisoren $(Z - r)$
    - Træk resultatet fra dividenden
    - Eksempel: $2Z^2 dot (Z - 3) = 2Z^3 - 6Z^2$

  4. *Gentag processen:*
    - Brug resten som ny dividend
    - Fortsæt indtil graden af resten er lavere end divisorens grad

  5. *Tjek:* Resten skal være 0 (ellers var $r$ ikke en rod)

  6. *Faktorisér videre:* Løs den resulterende kvotient for resterende rødder
]

#example(title: [Faktorisér polynomium givet én rod])[
  Givet $p(Z) = 2Z^3 - 2Z^2 - 8Z - 12$ hvor $Z = 3$ er rod.

  a) Skriv $p(Z)$ som produkt af et 1.-grads og et 2.-gradspolynomium.

  b) Find samtlige rødder i $CC$.

  #solution()[
    *Del a) - Polynomiumsdivision:*

    Da $Z = 3$ er rod, er $(Z - 3)$ en faktor. Udfør division:

    #align(center)[
      $ #poly-div-working((2, -2, -8, -12), (1, -3), var: $Z$) $
    ]

    $ p(Z) = (Z - 3)(2Z^2 + 4Z + 4) = 2(Z - 3)(Z^2 + 2Z + 2) $

    *Del b) - Find alle rødder:*

    Fra $(Z - 3)$: $Z = 3$

    Fra $Z^2 + 2Z + 2 = 0$:
    $ Z = (-2 plus.minus sqrt(4 - 8))/2 = (-2 plus.minus 2i)/2 = -1 plus.minus i $

    *Svar:* $Z = 3$, $Z = -1 + i$, $Z = -1 - i$
  ]
]

#example(title: [Polynomiumsdivision - Generelt eksempel])[
  Divider $x^3 - 5x^2 - 4x + 20$ med $(x - 2)$:

  #align(center)[
    $ #poly-div-working((1, -5, -4, 20), (1, -2)) $
  ]

  Altså: $x^3 - 5x^2 - 4x + 20 = (x - 2)(x^2 - 3x - 10)$
]

== Determinantegenskaber

#note-box[
  *Fremgangsmåde: Beregn determinant via egenskaber*

  *Nøglesætninger:*
  - $det(bold(A) bold(B)) = det(bold(A)) dot det(bold(B))$
  - $det(bold(A)^T) = det(bold(A))$
  - $det(bold(A)^(-1)) = 1/(det(bold(A)))$
  - $det(c bold(A)) = c^n det(bold(A))$ for $n times n$ matrix
  - $det(bold(A)^k) = (det(bold(A)))^k$

  *VIGTIGT:* $det(bold(X) + bold(Y)) eq.not det(bold(X)) + det(bold(Y))$ generelt!

  *Strategi:*
  1. Brug egenskaberne til at forenkle hvis muligt
  2. Hvis en sum optræder, må man ofte beregne eksplicit
]

#example(
  title: [Beregn $det((bold(A)^T + bold(A)^2) dot bold(A)^(-1))$],
)[
  Givet $bold(A) in CC^(4 times 4)$ med $det(bold(A)) = d$. Beregn $D = det((bold(A)^T + bold(A)^2) dot bold(A)^(-1))$.

  #solution()[
    *Nøglesætninger:*
    - $det(bold(A) bold(B)) = det(bold(A)) dot det(bold(B))$
    - $det(bold(A)^T) = det(bold(A))$
    - $det(bold(A)^(-1)) = 1/(det(bold(A)))$
    - $det(c bold(A)) = c^n det(bold(A))$ for $n times n$ matrix

    *Metode:* Kan IKKE bruge $det(bold(X) + bold(Y)) = det(bold(X)) + det(bold(Y))$ (dette er FORKERT!)

    For konkret beregning skal man typisk:
    1. Beregne $bold(A)^T + bold(A)^2$ eksplicit
    2. Gange med $bold(A)^(-1)$
    3. Beregne determinanten

    *Alternativ (hvis muligt):* Brug at $det(bold(A) bold(B)) = det(bold(A)) det(bold(B))$:
    $ D = det((bold(A)^T + bold(A)^2) dot bold(A)^(-1)) $

    Hvis $bold(A)^T = bold(A)$ (symmetrisk): $det(bold(A)^T + bold(A)^2) dot det(bold(A)^(-1))$

    *For den konkrete matrix i opgaven må man regne eksplicit.*
  ]
]

== Tjek om vektor er egenvektor

#note-box[
  *Fremgangsmåde: Tjek om en vektor er en egenvektor*

  1. Beregn $bold(A) bold(v)$
  2. Tjek om resultatet er et skalarmultiplum af $bold(v)$, dvs. om der findes $lambda in FF$ så $bold(A) bold(v) = lambda bold(v)$
  3. Hvis ja: $bold(v)$ er en egenvektor med egenværdi $lambda$
  4. Hvis nej (komponenterne giver forskellige $lambda$-værdier): $bold(v)$ er ikke en egenvektor
]

#example(
  title: [Er $bold(v)$ en egenvektor for $bold(A)$?],
)[
  Givet $bold(A) = mat(-1, 4, 4;0, 7, 8;0, -4, -5)$.

  Er $bold(v) = vec(3, -1, 1)$ en egenvektor?

  #solution(
    )[
    *Definition:* $bold(v)$ er egenvektor for $bold(A)$ $<=>$ $bold(A) bold(v) = lambda bold(v)$ for et $lambda in CC$.

    *Metode:* Beregn $bold(A) bold(v)$ og tjek om resultatet er en skalar multiplikation af $bold(v)$.

    $ bold(A) bold(v) = mat(-1, 4, 4;0, 7, 8;0, -4, -5) vec(3, -1, 1) = vec(-3 - 4 + 4, 0 - 7 + 8, 0 + 4 - 5) = vec(-3, 1, -1) $

    Tjek: Er $vec(-3, 1, -1) = lambda vec(3, -1, 1)$?

    Hvis ja, så $lambda = -1$ (da $-3 = -1 dot 3$, $1 = -1 dot (-1)$, $-1 = -1 dot 1$)

    *Svar:* Ja, $bold(v) = vec(3, -1, 1)$ er egenvektor med egenværdi $lambda = -1$.

    *Hvis NEJ:* Komponenterne ville give forskellige $lambda$-værdier.
  ]
]

== Basis for kerne og søjlerum

#note-box[
  *Fremgangsmåde: Find basis for kernen*

  1. Løs $bold(B) bold(x) = bold(0)$
  2. Rækkeréducér $bold(B)$ til RREF
  3. Identificér frie variable (søjler uden pivot)
  4. Udtryk løsningen parametrisk
  5. Basisvektorerne for kernen aflæses fra de parametriske udtryk

  *Fremgangsmåde: Find basis for søjlerummet*

  1. Rækkeréducér $bold(B)$ til RREF
  2. Identificér pivotsøjlerne (søjler med pivot)
  3. De tilsvarende søjler i den *originale* matrix danner basis for søjlerummet

  *Tjek surjektivitet:*
  $L$ er surjektiv $<=>$ $"rank"(bold(B)) = m$ (antal rækker i $bold(B)$)
]

#example(
  title: [Find basis for $ker(bold(B))$ og $"colsp"(bold(B))$],
)[
  Givet $bold(B) = mat(1, 3, -3;2, 1, 4;2, -1, 8)$.

  a) Find en basis for kernen.
  b) Find en basis for søjlerummet.
  c) Er $L(bold(v)) = bold(B) bold(v)$ surjektiv?

  #solution(
    )[
    *Del a) - Basis for kernen:*

    Løs $bold(B) bold(x) = bold(0)$. Rækkeréducér:

    $ mat(1, 3, -3;2, 1, 4;2, -1, 8) arrow.long_(R_2 <- R_2 - 2R_1 \ R_3 <- R_3 - 2R_1) mat(1, 3, -3;0, -5, 10;0, -7, 14) $

    $ arrow.long_(R_3 <- R_3 - (7/5)R_2) mat(1, 3, -3;0, -5, 10;0, 0, 0) arrow.long_(R_2 <- (-1/5) R_2) mat(1, 3, -3;0, 1, -2;0, 0, 0) $

    $ arrow.long_(R_1 <- R_1 - 3R_2) mat(1, 0, 3;0, 1, -2;0, 0, 0) $

    Fra RREF: $x_1 = -3t$, $x_2 = 2t$, $x_3 = t$ (fri variabel)

    $ ker(bold(B)) = "span"{vec(-3, 2, 1)} $

    *Basis for kernen:* ${ vec(-3, 2, 1) }$

    *Del b) - Basis for søjlerummet:*

    *Sætning:* Pivotsøjlerne i den *originale* matrix danner basis for søjlerummet.

    Fra RREF har vi pivoter i søjle 1 og 2.

    *Basis for søjlerummet:* ${ vec(1, 2, 2), vec(3, 1, -1) }$

    *Del c) - Er $L$ surjektiv?*

    *Sætning:* $L: RR^n -> RR^m$ er surjektiv $<=>$ $"rank"(bold(B)) = m$ (antal rækker).

    Her: $"rank"(bold(B)) = 2$ (2 pivoter), men $m = 3$ (3 rækker).

    $2 eq.not 3$, så *$L$ er IKKE surjektiv*.

    *Alternativ:* Søjlerummet har dimension 2, men codomænet er $RR^3$, så $L$ rammer ikke hele $RR^3$.
  ]
]

== Basisskiftematricer

#important[
  *Basisskiftematricer — Eksamensklassiker!*

  Ofte kombineret med matrixinversion. Husk: $amat("id", gamma, beta) = (amat("id", beta, gamma))^(-1)$
]

#note-box[
  *Fremgangsmåde: Beregn basisskiftematricer*

  *Notation:* $amat("id", beta, gamma)$ er matricen der konverterer koordinater fra $gamma$ til $beta$.
  (Læses fra højre mod venstre: "fra $gamma$ til $beta$")

  *Metode 1: Når $beta$ er standardbasen*

  $amat("id", beta, gamma)$ har $gamma$-basisvektorerne som søjler (i standardkoordinater).

  Eksempel: Hvis $gamma = (vec(2, 1, 0), vec(1, 1, 0), vec(0, 0, 2))$, så:
  $ amat("id", beta, gamma) = mat(2, 1, 0;1, 1, 0;0, 0, 2) $

  *Metode 2: Beregn den inverse*

  $amat("id", gamma, beta) = (amat("id", beta, gamma))^(-1)$

  *Metode 3: Brug blokdiagonal struktur (hvis muligt)*

  Hvis matricen er blokdiagonal, invertér hver blok separat!

  *Verifikation:*
  $amat("id", beta, gamma) dot amat("id", gamma, beta) = bold(I)$
]

#note-box[
  *Hurtig metode: Blokdiagonal basisskiftematrix*

  Hvis $amat("id", beta, gamma)$ er blokdiagonal, kan inversen beregnes hurtigt:

  $ mat(bold(B), bold(0);bold(0), bold(C))^(-1) = mat(bold(B)^(-1), bold(0);bold(0), bold(C)^(-1)) $

  *Eksempel fra eksamensopgave:*

  $ amat("id", beta, gamma) = mat(2, 1, 0;1, 1, 0;0, 0, 2) $

  Denne er blokdiagonal med:
  - Øvre blok: $mat(2, 1;1, 1)$
  - Nedre blok: $mat(2)$

  Invertér separat:
  - $mat(2, 1;1, 1)^(-1) = 1/(2-1) mat(1, -1;-1, 2) = mat(1, -1;-1, 2)$
  - $mat(2)^(-1) = mat(1/2)$

  $ amat("id", gamma, beta) = mat(1, -1, 0;-1, 2, 0;0, 0, 1/2) $
]

#example(title: [Beregn basisskiftematricer])[
  Lad $V = RR^3$ med standardbasis $beta = (bold(e)_1, bold(e)_2, bold(e)_3)$ og basis:
  $ gamma = (vec(2, 1, 0), vec(1, 1, 0), vec(0, 0, 2)) $

  a) Angiv $amat("id"_(RR^3), beta, gamma)$
  b) Beregn $amat("id"_(RR^3), gamma, beta)$

  #solution()[
    *Notation:* $amat("id", beta, gamma)$ konverterer koordinater fra $gamma$ til $beta$.

    *Del a) - $amat("id", beta, gamma)$:*

    Denne matrix har $gamma$-basisvektorerne som søjler (udtrykt i $beta$-koordinater).

    Da $beta$ er standardbasen, er $beta$-koordinaterne bare de sædvanlige koordinater:

    $ amat("id", beta, gamma) = mat(2, 1, 0;1, 1, 0;0, 0, 2) $

    *Del b) - $amat("id", gamma, beta)$:*

    *Sætning:* $amat("id", gamma, beta) = (amat("id", beta, gamma))^(-1)$

    Beregn inversen af $mat(2, 1, 0;1, 1, 0;0, 0, 2)$:

    Brug kofaktormetode eller rækkeoperationer. Da matricen er blokdiagonal:

    Øverste $2 times 2$ blok: $mat(2, 1;1, 1)^(-1) = 1/(2-1) mat(1, -1;-1, 2) = mat(1, -1;-1, 2)$

    Nederste blok: $1/2$

    $ amat("id", gamma, beta) = mat(1, -1, 0;-1, 2, 0;0, 0, 1/2) $

    *Verifikation:* $amat("id", beta, gamma) dot amat("id", gamma, beta) = bold(I)$
  ]
]

== 2.-ordens inhomogen ODE

#note-box[
  *Fremgangsmåde: Løs inhomogen 2.-ordens ODE*

  Givet $a f''(t) + b f'(t) + c f(t) = g(t)$:

  1. *Find den homogene løsning $f_h(t)$:*
    - Løs karakteristisk ligning $a lambda^2 + b lambda + c = 0$
    - Konstruér $f_h(t)$ baseret på rødderne

  2. *Find én partikulær løsning $f_p(t)$:*
    - Gæt en ansatz baseret på $g(t)$:
      - $g(t) = $ konstant $=>$ prøv $f_p = A$
      - $g(t) = $ polynomium $=>$ prøv polynomium af samme grad
      - $g(t) = e^(k t)$ $=>$ prøv $f_p = A e^(k t)$
    - Indsæt i ODE'en og bestem koefficienterne

  3. *Fuldstændig løsning:*
    $ f(t) = f_h(t) + f_p(t) $
]

#example(title: [Find partikulær løsning til $f''(t) + 2f'(t) - 8f(t) = p(t)$])[
  Givet $f''(t) + 2f'(t) - 8f(t) = a t + b$ hvor $f_0(t) = -t + 5$ er partikulær løsning.

  Find $f_p(t)$, $a$ og $b$.

  #solution()[
    *Trin 1:* Find den homogene løsning.

    Karakteristisk ligning: $lambda^2 + 2lambda - 8 = 0$
    $ (lambda + 4)(lambda - 2) = 0 => lambda_1 = -4, lambda_2 = 2 $

    Homogen løsning: $f_h(t) = c_1 e^(-4t) + c_2 e^(2t)$

    *Trin 2:* Bestem $a$ og $b$ fra den partikulære løsning.

    Hvis $f_0(t) = -t + 5$ er partikulær løsning, så:
    $ f_0'(t) = -1, quad f_0''(t) = 0 $

    Indsæt i ODE'en:
    $ 0 + 2(-1) - 8(-t + 5) = a t + b $
    $ -2 + 8t - 40 = a t + b $
    $ 8t - 42 = a t + b $

    Sammenlign koefficienter:
    - $t$-led: $a = 8$
    - Konstant: $b = -42$

    *Trin 3:* Fuldstændig løsning.
    $ f_p(t) = f_h(t) + f_0(t) = c_1 e^(-4t) + c_2 e^(2t) - t + 5 $

    *Svar:* $a = 8$, $b = -42$, $f_p(t) = c_1 e^(-4t) + c_2 e^(2t) - t + 5$
  ]
]

== Rekursiv funktion

#note-box[
  *Fremgangsmåde: Beregn rekursiv funktion*

  1. Skriv startværdierne op (basistilfælde)
  2. Beregn iterativt fra de kendte værdier:
    - $f(3) = ...$ (brug $f(1), f(2)$)
    - $f(4) = ...$ (brug $f(2), f(3)$)
    - osv.
  3. Fortsæt indtil du når den ønskede værdi

  *Tip:* Lav en tabel for at holde styr på beregningerne
]

#example(title: [Beregn $f(5)$ for rekursiv funktion])[
  $ f(n) = cases(1 "for" n = 1, 2 "for" n = 2, 3f(n-1) - f(n-2) "for" n >= 3) $

  #solution()[
    Beregn iterativt:
    - $f(1) = 1$
    - $f(2) = 2$
    - $f(3) = 3 dot f(2) - f(1) = 3 dot 2 - 1 = 5$
    - $f(4) = 3 dot f(3) - f(2) = 3 dot 5 - 2 = 13$
    - $f(5) = 3 dot f(4) - f(3) = 3 dot 13 - 5 = 34$

    *Svar:* $f(5) = 34$
  ]
]

== Løsning af 2.-gradsligning (kompleks, polær form)

#note-box[
  *Fremgangsmåde: Løs 2.-gradsligning og angiv på polær form*

  1. Brug kvadratisk formel: $z = (-b plus.minus sqrt(b^2 - 4 a c))/(2a)$
  2. Hvis diskriminanten er negativ, får du komplekse løsninger
  3. Konvertér til polær form:
    - Find modulus: $|z| = sqrt(("Re"(z))^2 + ("Im"(z))^2)$
    - Find argument: $arg(z) = arctan("Im"(z)/"Re"(z))$ (juster for kvadrant)
  4. Skriv: $z = |z| e^(i arg(z))$
]

#example(
  title: [Løs $3z^2 - 6z + 12 = 0$, angiv på polær form],
)[
  #solution(
    )[
    Brug kvadratisk formel:
    $ z = (6 plus.minus sqrt(36 - 144))/6 = (6 plus.minus sqrt(-108))/6 = (6 plus.minus 6sqrt(3)i)/6 = 1 plus.minus sqrt(3)i $

    Konvertér $z = 1 + sqrt(3)i$ til polær form:
    - $|z| = sqrt(1 + 3) = 2$
    - $arg(z) = arctan(sqrt(3)/1) = pi/3$

    $ z = 2e^(i pi/3) $

    Den anden løsning: $z = 1 - sqrt(3)i = 2e^(-i pi/3)$

    *Svar:* $z = 2e^(plus.minus i pi/3)$
  ]
]

= Hurtig Reference: Nøglesætninger

== Logik
- *Implikation:* $P => Q equiv not P or Q$ (kun falsk når $P$ sand, $Q$ falsk)

== Komplekse Tal
- *De Moivre:* $(r e^(i theta))^n = r^n e^(i n theta)$
- *$n$-te rødder:* $z_k = root(n, r) e^(i(theta + 2 pi k)/n)$, $k = 0, ..., n-1$

== Lineær Algebra
- *Rang-Nulitet:* $"rank"(bold(A)) + "null"(bold(A)) = n$ (antal søjler)
- *Injektivitet:* $L$ injektiv $<=>$ $ker(L) = {bold(0)}$ $<=>$ $det eq.not 0$ (for kvadratisk)

== ODE'er
- *Homogen:* $bold(f)' = bold(A) bold(f)$ (ingen tvangsfunktion)
- *Inhomogen:* $bold(f)' = bold(A) bold(f) + bold(g)(t)$ (har tvangsfunktion)
- *Løsning (homogen):* $bold(f)(t) = sum_i c_i e^(lambda_i t) bold(v)_i$ hvor $lambda_i, bold(v)_i$ er egenværdi/egenvektor-par
- *Løsning (inhomogen):* $bold(f)(t) = bold(f)_h(t) + bold(f)_p(t)$ (homogen + partikulær)

== Matrixinversion
- *$2 times 2$ formel:* $mat(a, b;c, d)^(-1) = 1/(a d-b c) mat(d, -b;-c, a)$
- *Blokdiagonal:* $mat(bold(B), bold(0);bold(0), bold(C))^(-1) = mat(bold(B)^(-1), bold(0);bold(0), bold(C)^(-1))$
- *Basisskifte:* $amat("id", gamma, beta) = (amat("id", beta, gamma))^(-1)$

== Induktion
1. Basistilfælde: Verificér $P(n_0)$
2. Induktionsskridt: Antag $P(k)$, vis $P(k+1)$

== Polynomiumsdivision
- Husk parenteser ved subtraktion: $(a Z^2 + b Z) - (c Z^2 + d Z) = (a-c)Z^2 + (b-d)Z$
- Komplekse rødder kommer i konjugerede par (for reelle koefficienter)
