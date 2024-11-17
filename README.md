
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sasquatch

<!-- badges: start -->
<!-- badges: end -->

Use SAS, R, and Quarto together

`sasquatch` is currently in a very rudimentary form, but it is not hard
to use once you have [`saspy`](https://sassoftware.github.io/saspy/)
installed and set up. Feel free to contribute by adding an [issue or
pull request](http://github.com/ryanzomorrodi/sasquatch).

Don’t have a SAS License? You can still set up saspy with [SAS OnDemand
for
Academics](https://www.sas.com/en_us/software/on-demand-for-academics.html#928a7e06-1416-4d88-b966-311df1bdfea6).
Check out `vignette("setting_up")` for how to get started with SAS ODA
and `sasquatch`.

## Installation

You can install the development version of sasquatch like so:

``` r
pak::pkg_install("ryanzomorrodi/sasquatch")
```

## Usage

Once you have setup `saspy` and connected to the right python
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

Now, you should be able to run sas code blocks in RStudio like any
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
