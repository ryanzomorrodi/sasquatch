
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sasquatch

<!-- badges: start -->

[![R-CMD-check](https://github.com/ryanzomorrodi/sasr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ryanzomorrodi/sasr/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/ryanzomorrodi/healthatlas/branch/main/graph/badge.svg)](https://app.codecov.io/gh/ryanzomorrodi/healthatlas?branch=main)
<!-- badges: end -->

Use SAS, R, and Quarto together

`sasquatch` allows you to combine the power of R, SAS, and quarto
together to create reproducable multilingual reports. `sasquatch` can
run SAS code blocks interactively, send data back and forth between SAS
and R, and render SAS HTML output within quarto documents.

`sasquatch` relies on the
[`SASPy`](https://sassoftware.github.io/saspy/) Python package. But if
you

- Don’t have `SASPy` already installed, or  
- Don’t have a SAS License

Check out `vignette("setting_up")` for guidance on how to get started
with a free [SAS OnDemand for
Academics](https://www.sas.com/en_us/software/on-demand-for-academics)
license (you don’t need to be an academic!).

## Installation

You can install the development version of sasquatch like so:

``` r
pak::pkg_install("ryanzomorrodi/sasquatch")
```

## Usage

Once you have setup `SASPy` and connected to the right python
environment using `reticulate` (if necessary), use `sas_use_quarto()` to
create the `sasquatch` template to a specified directory.

``` r
sasquatch::sas_use_quarto("path to directory")
```

Run the first code block within the template.

``` r
library(sasquatch)
sas_connect()
```

#### Code blocks

Now, you should be able to run SAS code blocks in RStudio like any
other.

<figure>
<img src="man/figures/run_sas_chunk.gif" alt="Executing a SAS chunk" />
<figcaption aria-hidden="true">Executing a SAS chunk</figcaption>
</figure>

#### Sending output to viewer

If you want to send the SAS output to the viewer, you can utilize the
`sas_run_selected()` addin with a custom shortcut.

<figure>
<img src="man/figures/run_sas_selected.gif"
alt="Running SAS Selection" />
<figcaption aria-hidden="true">Running SAS Selection</figcaption>
</figure>

#### Converting tables

Pass tables between R and SAS with `r_to_sas()` and `sas_to_r()`.

``` r
r_to_sas(mtcars, "mtcars")
cars <- sas_to_r("cars", libref = "sashelp")
```

#### Rendering quarto documents

And of course, render beautiful quarto documents in the same style you
would expect from SAS with the `sas_engine()`.

<figure>
<img src="man/figures/rendered_quarto.png"
alt="Rendered Quarto Document" />
<figcaption aria-hidden="true">Rendered Quarto Document</figcaption>
</figure>

## Similar packages

`saquatch` works similarly to packages like
[`sasr`](https://sassoftware.github.io/saspy/) or
[`configSAS`](https://github.com/baselr/configSAS). In fact, `configSAS`
author [Johann Laurent’s
talk](https://www.youtube.com/watch?v=4c9T6-__vI8) at a useR! event
inspired `sasquatch`’s creation. `sasr`, while similar to `sasquatch`,
does not include interactive SAS functionality or a `knitr` engine. On
the other hand, `configSAS` includes a `knitr` engine, but no
interactive SAS functionality. `configSAS` `knitr` output also does not
include syntax highlighting and nested SAS output interferes with the
styles of the rest of the document.
