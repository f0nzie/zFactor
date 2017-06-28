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
*  create scripts to generate datasets of z vs. Ppr
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
