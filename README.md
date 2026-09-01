# ECMOR 2026 experiment

by Max Elizarev et al.

**Extended abstract:** <https://doi.org/10.3997/2214-4609.202637104>

**StrataTrapper**: <https://github.com/ImperialCollegeLondon/StrataTrapper>

[![poster](poster/poster.svg)](poster/poster.pdf)

- [Troll Aquifer model availability](#troll-aquifer-model-availability)
- [What's inside](#whats-inside)
  - [Data](#data)
  - [Codes](#codes)
  - [Placeholders](#placeholders)
  - [Poster presentation](#poster-presentation)
  - [Meta](#meta)
- [Dependencies](#dependencies)
- [Licenses](#licenses)

## Troll Aquifer model availability

I amimed for exemplarly transparency and reproducibility by publishing our numerical experiment data and codes in full.

However, we had to remove dynamic simulation inputs of the Troll Aquifer model in both resolutions. To the best of our knowledge, these files cannot be openly shared.

A known way to access the Troll Aquifer model is to contact the Norwegian Offshore Directorate <https://www.sodir.no/en/>.
Please do not hesitate to do so.

The rest of the setup is preserved.

## What's inside

More specifically, this repository contains:

### Data

Inputs, intermediate results, and final outputs that do not reveal neither the model's geometry nor rock properties:

- Dynamic simulation specifications
- `StrataTrapper`'s outputs
- summary outputs `out/*.ESMRY` and `out/*.SMSPEC`
- Porosity and permeability from the Smeaheia dataset

### Codes

- StrataTrapper's instance. Likely, a bit diverged from the upstream GitHub repository
- The MIP-upscaling script [`main.m`](main.m), the very upscaling experiment.
- [`startup.m`](startup.m) to run before the main script
- Shell scripts with dynamic simulation commands we used

### Placeholders

Some files were intentionnaly replaced with placeholder text files:

- Troll Aquifer model inputs
- Mapping between grid scales
- External dependencies

### Poster presentation

I had a wonderful time typesetting my research poster with Typst for the first time. For so long, I have been looking forward to switching to it from PowerPoint and LaTeX.

That said, I am more than happy to share the sources at [`poster/`](./poster/) with the public. I sincerely hope to inspire some of you to try Typst, too.

### Meta

- [`CITATION.cff`](CITATION.cff) (see: <https://citation-file-format.github.io/>)
  - VS Code settings with the schema for this file

## Dependencies

External tools required to run the experiment

- [ ] MATLAB >= `R2023a`
- [ ] [OPM Flow](https://opm-project.org/?page_id=36>) with `opm-common` at commit [`e12c23091c322db1fd81b2966ce44c38186463b1`](https://github.com/OPM/opm-common/pull/4923) or later
- [ ] [MRST](https://www.sintef.no/projectweb/mrst/) >= `mrst-R2025b`
- [ ] [ResInsight](https://resinsight.org/) to visualise `.ESMRY`/`.SMSPEC` results in [`out/`](./out/)

## Licenses

Different parts of this repository are licensed differently. Please refer to files named `LICENSE` and `NOTICE` for details.
