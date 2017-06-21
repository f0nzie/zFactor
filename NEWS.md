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
