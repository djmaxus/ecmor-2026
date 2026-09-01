#import "@preview/peace-of-posters:0.6.0" as pop

#set page(
  "a0",
  margin: (
    top: 12cm,
    bottom: 7cm,
    left: 4cm,
    right: 4cm,
  ),
  background: align(
    center,
  )[
    #image(
      "poster-back.pdf",
      width: 100%,
    )],
)

#pop.set-poster-layout(pop.layout-a0)
#pop.set-theme(pop.black-white)

#let text-font = 18pt;

#set text(
  font: "Imperial Sans Display",
  size: text-font,
  hyphenate: false,
)

#pop.update-poster-layout(
  body-size: text-font,
  subtitle-size: 18pt,
)

#let imperial_blue = rgb("#0000CD")

#pop.update-theme(
  title-box-args: (
    fill: none,
    stroke: none,
  ),
  heading-text-args: (
    fill: rgb("#A0450B"),
    weight: "bold",
  ),
  title-text-args: (fill: black),
)

#let logo_imperial = image("logo-imperial.svg", height: 2cm)
#let logo_norce = image("logo-norce.svg", height: 4cm)

#place(
  top + left,
  dy: -6cm,
  dx: 32cm + 8cm,
  logo_imperial,
)

#place(
  top + right,
  dy: -7cm,
  dx: -1cm,
  logo_norce,
)

#let s1 = text(fill: imperial_blue, weight: "bold")[$""^dagger$]
#let s2 = text(fill: rgb("#3408AC"), weight: "bold")[$""^dagger.double$]

#pop.title-box(
  text(
    fill: imperial_blue,
  )[
    *Capillary heterogeneity* effects *upscaled*
    #linebreak()
    with *macroscopic percolation*
    for the *Troll aquifer* model
  ],
  subtitle: none,
  authors: [
    #strong[Max ELIZAREV]#s1,
    Tor Harald SANDVE#s2,
    David LANDA-MARBÁN#s2,
    Svenn TVEIT#s2,
    Sarah E. GASDA#s2,
    #linebreak()Prof Ann MUGGERIDGE#s1,
    Prof Samuel KREVOR#s1
  ],
  institutes: [
    #s1 Imperial College London (United Kingdom),
    #s2 NORCE Research AS (Norway)
  ],
)

#set figure(numbering: none)

#let cotwo = text[CO#sub[2]]

// #show link: underline
#show link: set text(
  fill: imperial_blue,
  font: "JetBrains Mono",
)

#let github = link("https://github.com/djmaxus/ecmor-2026")[
  github.com/djmaxus/#text(weight: "bold")[ecmor-2026]
]

#let strata_trapper = link("https://github.com/ImperialCollegeLondon/StrataTrapper")[
  github.com/ImperialCollegeLondon/#text(weight: "bold")[StrataTrapper]
]

#let bottom_table = table(
  rows: 2,
  columns: (auto, auto),
  stroke: none,
  align: (horizon + right, horizon + left),
  inset: 16pt + 4pt,
  table.hline(stroke: rgb("#609A99") + 2pt),
  [Reproducible Experiment], [#github],
  [Upscaling Library], [#strata_trapper],
  table.hline(stroke: rgb("#609A99") + 2pt),
)

#set image(width: 100%);

#figure(
  grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    gutter: 0.0em,
  )[
    #figure(
      image(
        "img/contour/FINE_NOCAP_Contour_Map_4_SGAS_63_01_Jan_2050_crop.png",
        width: 100%,
        scaling: "pixelated",
      ),
      caption: "Fine scale (no capillary pressure)",
    )
  ][
    #figure(
      image(
        "img/contour/FINE_Contour_Map_3_SGAS_63_01_Jan_2050_crop.png",
        width: 100%,
        scaling: "pixelated",
      ),
      caption: [
        *Fine-scale reference*
      ],
    )
  ][
    #figure(
      image(
        "img/contour/COARSE_Contour_Map_2_SGAS_63_01_Jan_2050_crop.png",
        width: 100%,
        scaling: "pixelated",
      ),
      caption: text(fill: rgb("#dc143c"))[
        *Single-phase upscaling*
      ],
    )
  ][
    #figure(
      image(
        "img/contour/MIP_MIP_SGAS_SGAS_63_01_Jan_2050_crop.png",
        scaling: "pixelated",
      ),
      caption: text(fill: imperial_blue)[*Macroscopic percolation upscaling*],
    )
  ],
  caption: figure.caption[
    #cotwo saturations at the end of injection (ResInsight contour maps).
    Injection wells are indicated by red spheres.],
  numbering: "1",
)

#place(
  left,
  dy: -16cm - 4cm,
  dx: 1.35cm,
  image("img/contour/bar.png", width: auto),
)

#place(
  left,
  dy: -10cm,
  dx: 1cm,
  image("img/contour/bar-scale.png", width: auto),
)

#place(
  center + horizon,
  dy: -6cm,
  dx: 0cm,
  align(center)[
    #set text(size: 18pt * 2, fill: rgb("#558B8A"))
    #bottom_table
  ],
)

#set figure(
  numbering: "1",
  placement: none,
)

#show figure.caption: it => {
  set align(left)
  set par(justify: true)
  it
}

#set image(width: auto, fit: "contain")

#columns(3, gutter: 0.5%)[

  #pop.common-box(heading: "Summary")
  #par(justify: true)[
    *Keywords:*
    #show "-": sym.hyph.nobreak;
    CCS
    #sym.dot.op Geological~#cotwo~storage
    #sym.dot.op dynamic~reservoir~simulation
    sub-grid~capillary~heterogeneity
    #sym.dot.op accuracy-feasibility~trade-off
    #sym.dot.op capillary-limit~upscaling
    Macroscopic~Invasion~Percolation
    #sym.dot.op directional~relative~permeability
    #sym.dot.op Troll~aquifer~model
    regional~scale
    #sym.dot.op vertical~upscaling
    #sym.dot.op parallel~computing
    #sym.dot.op `OPM Flow`
    #sym.dot.op `ResInsight`
    #sym.dot.op `C++`~codegen
  ]

  #columns(2, gutter: 0.5%)[

    == Troll aquifer model
    - Large regional model with faults
    - 25 years of #cotwo injection, 14 wells
    - 500 years of post-injection monitoring
    - Simulated with *OPM Flow*
      (`CO2STORE`, `ENDSCALE`, `JFUNC`, `SGWFN`, no imbibition)

    === Coarse mesh
    - vertically upscaled from 217 to 5 layers
    - 27$#math.times$ fewer active cells

    == Capillary heterogeneity
    Introduced to the model via Leverett-J
    #math.equation(block: true, numbering: "(1)")[
      $p_text(c)(overline(s)_text(w)) = sigma J(overline(s)_text(w)) sqrt(frac(2 phi, K_text(x) + K_text(y)))$
    ]
    $J(overline(s)_text(w))$ is weakened normalized capillary pressure from the Smeaheia dataset.

    == Macroscopic Invasion Percolation
    - Static modelling tool
    - Counterpart of pore-scale percolation
    - Individual pores replaced with fine-scale cells
    - Assumes local capillary equilibrium
    - Simulates drainage of wetting phase
    - Discrepancies in entry pressures
      yield\
      steady-state fluid distributions

    #colbreak()
    == #text(fill: imperial_blue)[MIP Upscaling]
    Novel capillary-limit static upscaling.\
    (see: Elizarev~et~al.,~2025; Wolff~et~al.,~2013)\
    *Local*, per-cell MIP
    - Integrated MIP-controlled fluid content\
      #sym.arrow *upscaled capillary pressure*
    - Local Darcy flow w.r.t MIP #sym.arrow *upscaled\ directional phase permeabilities*

    == StrataTrapper #link("https://github.com/ImperialCollegeLondon/StrataTrapper/releases/tag/v0.17.0")[>=v0.17.0]
    - OPM Flow input deck export
    - automatic C++ code generation,\
      6$#math.times$ upscaling acceleration

    == Contribution to OPM Flow
    Support for directional scaling of relative\
    permeabilities in gas-water models:\
    #link("https://github.com/OPM/opm-common/pull/4923")[github:OPM/opm-common/pull/4923]

    == Simulation Results
    Improved accuracy with MIP upscaling
    - areal extent of #cotwo plumes, migration paths
    - operational state of wells
    - Preserved pressure match
    - Performance gain: 2 orders of magnitude
  ]

  #pop.common-box(heading: "Results")

  #figure(
    image(
      "TCPU.pdf",
    ),
    caption: [
      Computational performance of reservoir simulations with OPM Flow, 16 MPI nodes.],
    placement: none,
  )

  #colbreak()

  #figure(
    image("upscaling.pdf"),
    caption: [Variety of MIP-upscaled flow functions. Fine-scale inputs are in #text(fill: rgb(255, 0, 0))[red].\ Statistical plots of MIP-upscaled functions are in #text(fill: rgb(0, 0, 255))[blue].],
    placement: none,
  )


  #box(
    stroke: none,
  )[
    = Pressure match preserved

    #let mono(body) = text(body, font: "JetBrains Mono");
    In the presence of capillary pressure $p_#text[c,gw]$, phase pressures are non-equivalent.
    #math.equation(numbering: "(1)", block: true)[
      $p_#text[g] = p_#text[w] + p_#text[c,gw]$
    ]
    *Figure 8 of the extended abstract* shows the pressure of *gas* $p_#text[g]$, which is the reference pressure in #mono[CO2STORE] simulations. In the abstract, we did not provide a definitive explanation to the reservoir pressure discrepancy we observed.

    *@fig:pres* of the mean reservoir *water* pressure $p_#text[w]$ suggests that
    upscaled simulations stayed closely aligned in pressure,
    preserving the achievement of Landa-Marbán et al. (2025).
    #figure(
      image("pressure.pdf", width: auto),
      caption: [Water phase pressure dynamics in upscaled simulations.\ Log-scale time, volume-weighted average, difference with reference fine-scale simulation.],
      placement: none,
    )<fig:pres>
  ]

  #align(center)[
    #let qrh = 7cm;
    #set align(center + horizon)
    #box[
      #align[
        #image("qr-code.svg", height: qrh)
      ]
    ]
    #h(3.5cm)
    #box[
      #align[
        #image("qr-strata.svg", height: qrh,scaling: "smooth")
      ]
    ]
  ]
  #colbreak()
  #box()[
    #math.equation(block: true, numbering: "(1)")[
      #let bhp(model) = $upright("BHP")_text(#str(model))(t)$
      $upright("WDDBHP")(t) = abs(1-frac(bhp("coarse"), bhp("fine")))
      - abs(1-frac(bhp("MIP"), bhp("fine")))$
    ]<eq:wddbhp>
    #figure(
      image("MIP_WDDBHP.pdf"),
      caption: [Relative improvement in bottom-hole pressure prediction for the injection wells\ as per @eq:wddbhp],
      // placement: auto,
    )
  ]

  #pop.column-box(heading: "References")[

    - Max Elizarev et al. (2025) #link("https://doi.org/10.2139/ssrn.5068897")[10.2139/ssrn.5068897]\
      *Upscaling Algorithm to Preserve Effects of Small-Scale Capillary Heterogeneity:\ Field-Scale Studies on CO2 Storage Sites*

    - David Landa-Marbán et al. (2025) #link("https://arxiv.org/pdf/2508.08670")[arxiv.org/pdf/2508.08670]\
      *A Coarsening Approach to the Troll Aquifer Model*\

    - Hailun Ni et al. (2025) #link("https://doi.org/10.1016/j.earscirev.2025.105257")[10.1016/j.earscirev.2025.105257]\
      *The impact of capillary heterogeneity on CO2 flow and trapping across scales*\

    - Markus Wolff et al. (2013) #link("https://doi.org/10.1002/2013WR013800")[10.1002/2013WR013800]\
      *An adaptive multiscale approach for modeling two-phase flow in porous media including capillary pressure*
  ]

  #pop.common-box(heading: "Acknowledgements")
  #set image(fit: "contain", width: auto)
  #let logo-h = 80pt;
  #let logap = 7em;
  #align(center + horizon)[
    #box(image("express-black.png", height: logo-h)) #h(logap)
    #box(image("NFR-logo-eng-rgb-cropped.svg", height: logo-h))
    #linebreak()
    #box(image("sodir_logo-en.svg", height: logo-h)) #h(logap)
    #box(image("opm-logo-ver2.png", height: logo-h))
    #linebreak()
    #box(image("Equinor.svg", height: logo-h)) #h(logap)
    #box(image("he_full-colour_landscape-digital-logo_rgb.png", height: logo-h)) #h(logap)
    #box(image("SHEL-a71e2d12.png", height: logo-h))
  ]
]
