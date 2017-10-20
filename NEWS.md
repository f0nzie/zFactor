## 20171019 0.1.6.9012
* add unit tests up to coverage 89%
* improve couple of functions: convertStringToVector , 
* add function stats_of_z.stats 
* add three datasets to ./tests/testthat/data


## 20171018 0.1.6.9011
* add citations to Papp vignette
* add correlation titles to sub-sections in README
* update README with references to new authors
* add two authors to bibliography: Takacs and Papp

## 20171018 0.1.6.9010
* change wrong Papay name to Papp in README, _pkgdown.yaml, vignette, util.R
* refresh site sending develop ./docs to branch `gh-pages using `git subtree`  

## 20171018 0.1.6.9009
* use a different git workflow
* delete unused tags in remote and local
* use "git subtree push --prefix docs origin gh-pages" in the Linux VM to send ./docs to remote branch gh-pages

## 20171016, 0.1.6.9008
* add vignette for Papay
* add function z.Papay
* fix Beggs-Brill vignette
* remove blank lines separating the badges
* TODO: Fix "Beggs-Brill Correlation". object --> sk_corr_3
* TODO: add Papp's correlation


## 20171016, 0.1.6.9007
* add travis.yml
* add code coverage with covr
* add badges to README
* rename couple of Rda files in ./data

## 20171010, 0.1.6.9006
* fix Rmd for Standing-Katz notebook

## 20171008, 0.1.6.9005
* small changes in the write-up of the README
* fix case in multiplotStandingKatz() when a vector of length 1 is specified
* ignore extra files in .Rbuildignore
* add more details and improve titles of several function. First group in "Standing-Katz chart" in customized menu.
* describe default values in parameters.
* move multiplot function to StandingKatz.R
* add some stops to functions

## 20171008, 0.1.6.9004
* customize navbar
* change menu to cerulean. 
* customize order of vignettes. 
* categorize functions.

## 20171008, 0.1.6.9003
* remove rdocumentation badge, it was static. changed to CRAN badge.

## 20171008, 0.1.6.9002
* add URL to description
* remove middle name from author

## 20171008, 0.1.6.9001
* Rebuild site after updates
* minor cosmetic changes in README
* add a link to wikipedia (MAPE)

## 20171008, 0.1.6.9000
* correct misspelled "hyddrocarbons". Noted by CRAN.
* resubmit to CRAN
* Build the package with `pkgdown`
* change author in description to use new way of adding authors
* tested offline and website running
* reinstalled package `rlang` to fix error during `pkgdown` installation


## 20170703, 0.1.6
* to be released to CRAN.
* CRAN found a problen in an URL in Shell.html file.
* Fixed problem by changing to a faster link. Previous link was loading a PDF from a website.
* remove bibliography.bib from inst/doc and letting devtools::build_vignettes() doing it instead. Necessary to add file vignettes/.install_extras with one line calling bibliography.bib. That way the file gets copied to inst/doc

## 20170702, 0.1.5
* to be released to CRAN. Problem with HY.rda
* add citations to README
* add citations to correlation notebooks
* use knitcitations
* add examples for all public functions
* improve description of package clarifying it is for sweet gases only
* update bibliography.bib. remove abstracts. ordered alphabetically.

## 20170629, 0.1.4.9016
* add more citations from JabRef
* note on sweet gases for now.
* as github_document

## 20170629, 0.1.4.9003
* all stat plots now show the name of the correlation
* stat tile plots can be drawn with Ppr `coarse` or `fine` interval
* deprecate `getCurvesDigitized` in favor of `getStandingKatzTpr`
* add new function `getStandingKatzPpr` which returns a short or long vector of Ppr intervals
* add new functions `isValid_correlation`,` get_z_correlations`
* add a dataframe `z_correlations` to contain z correlations info
* make title and subtitles dynamic in `z.plot.range`
* remove function `RMLSE` from stats dataframe. it was causing NaNs

## 20170629, 0.1.4.9002
* Finally fixed README images. Chaanged fig.path to man/figures/README-

## 20170629, 0.1.4.9001
* fix README images

## 20170628, 0.1.4.9000
* fix problem when passing a small vector or matrix to correlations.
* add new script stats.R that will calculate stats dataframe and plots
* add new tests for Shell and Beggs and Brill
* fix test files for DPR. it was using DAK.
* fix discontinuity in Hall-Yarborough by using "try". Got NAs at 7.00 and near.
* Add one-liner examples to README

## 20170628, 0.1.4
* switch Ann Java to R.
* remove sandbox worksheets from extdata
* move java tester notebook to scientific-computing-r

## 20170625, 0.1.3
* add Shell correlation
* add tile plot
* redo the notebooks neater
* add error statistics: APE, MAPE, RSME, etc.
* simplify correlation functions to call point and vectors. use dplyr
* clip from papers
* fix position_dodge overlapping


## 20170625, 0.1.2
* correct spelling of 'compressibility'
* add more tests to correlations. Also rda file for testing.
* simplify Ann10 with one call only. no need for one point and a vector.
* create a .jar file and put it under ./inst/java
* tried to use .onLoad with rJava but doesn't work. Did it directly in the function.


## 20170625, 0.1.1
* change to capital case requested by CRAN
* make getStandingKatzCurve() generic for points and vectors. make changes in noteboooks too.
* all plots now in ggplot2
* change defaults parameters toSave, toView to FALSE.
* Use tibble for long dataframes.
* add Java for artificial neural network and corresponding notebook.


## 20170623, 0.1.0
* released to CRAN.
* added examples
* expand use of functions for input vectors.

## 20170623, 0.0.1.9000
* fix createTidyFromMatrix to be able to plot with ggplot using group. Tpr as character, Ppr as numeric.
* add performance for HY, DAK and DPR. Show errors.
* add "results='hold'" to knitr header.
* now able to plot all the Tpr curves with ggplot2


## 20170623, 0.0.0.9012
* disable inst/doc in .gitignore (comment)

## 20170623, 0.0.0.9011
* add vignettes for correlations DAK and DPR.
* perform error analysis on DAK and DPR
* enabled build vignettes with roxygen
* now createTidyFromMatrix can work with DAK and DPR.
* add ggplot2 to imports

## 20170622, 0.0.0.9010
* add ggplot with error bars showing difference between Standing-Katz and Hall-Yarborough.
* create a set of small function for creating a tidy dataset. in utils.R
* now able to create a matrix from SK chart values given Ppr and Tpr vectors.
* new vignette showing HY plots
* add new Tpr curves 1.8, 1.9 to txt datasets
* Digitizing more Ppr points for several Tpr curves


## 20170621, 0.0.0.9009

* add vignette to show how to get data from Standing-Katz chart.
* create scripts to generate datasets of z vs. Ppr
* add function getStandingKatzCurve() that plots, saves and view a Tpr curve
* add function listStandingKatzCurves() that shows what Tpr curves have been digitized
* add function getStandingKatzMatrix() to get a table of z -values for Ppr vs Tpr table.
* add function getCurvesDigitized() that returns a numeric vector of Tpr curves avaialable.

## 20170620, 0.0.0.9008

* add first vignette to explain the plotting and saving of the SK chart digitized data 
* add script StandingKatz.R to process raw digitized data from SK chart
* remove most of the .rda files under ./data It was too crowded and unnecessary. It is bter that the users generates the data bt their own.
* renaming digitized data files .txt that follows a convention: sk_lp_tpr_105.txt for low pressure curve at Tpr=1.05, and sk_hp_tpr_150.txt for low pressure curve at Tpr=1.50.

## 20170616, 0.0.0.9006
* add notebook `read_digitized.Rmd` to correct data of digitized SK chart. Do not round data points that are not close to the frid lines. The function saves the data in a file corresponding to the name supplied to the CSV file to red. Uses assign and get.
* create rda files for various values of Tpr in Standing-Katz chart.
* add bibliography file
* add notebook with references
* add notebook with sources


## 20170615, 0.0.0.9006
* add comparison plots between Hall-Yarborough and values read from Standing-Katz charts.

## 20170614, 0.0.0.9005
* 9004 aborted. will try again wih 9005.

## 20171413, 0.0.0.9004
* fix problem with Tpr. Needed reciprocal for HY calculations.
* add SK chart in jpg and PDF.
* create table for SK chart: z values for 7 Ppr and 4 Tpr.
* made amistake with 9003. Rename repo up to 9000 old.zFactor.

## 20170613, 0.0.0.9002
* add this file NEWS.md
* change name of colum from `what` to `method`
