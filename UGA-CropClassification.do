*-------------------------------------------------------------*
*-------------------------------------------------------------*
*                     Trees on Farm:                          *
*    Prevalence, Economic Contribution, and                   *
*   Determinants of Trees on Farms across Sub-Saharan Africa  *
*															  *
*			https://treesonfarm.github.io					  *
*-------------------------------------------------------------*
*   Miller, D.; Muñoz-Mora, J.C. and Christiaense, L.         *
*                                                             *
*                     Nov 2016                                *
*                                                             *
*             World Bank and PROFOR                           *
*-------------------------------------------------------------*
*                   Replication Codes                         *
*-------------------------------------------------------------*
*-------------------------------------------------------------*


cap gen tree_type=""
replace tree_type="Fruit Tree" if cropID==710
replace tree_type="Fruit Tree" if cropID==700
replace tree_type="Fruit Tree" if cropID==750
replace tree_type="Fruit Tree" if cropID==760
replace tree_type="Fruit Tree" if cropID==770
replace tree_type="NA" if cropID==930
replace tree_type="Plant/Herb/Grass/Roots" if cropID==640
replace tree_type="Plant/Herb/Grass/Roots" if cropID==111
replace tree_type="Plant/Herb/Grass/Roots" if cropID==870
replace tree_type="Plant/Herb/Grass/Roots" if cropID==420
replace tree_type="Plant/Herb/Grass/Roots" if cropID==530
replace tree_type="Plant/Herb/Grass/Roots" if cropID==620
replace tree_type="Plant/Herb/Grass/Roots" if cropID==330
replace tree_type="Plant/Herb/Grass/Roots" if cropID==510
replace tree_type="Plant/Herb/Grass/Roots" if cropID==320
replace tree_type="Plant/Herb/Grass/Roots" if cropID==150
replace tree_type="Plant/Herb/Grass/Roots" if cropID==340
replace tree_type="Plant/Herb/Grass/Roots" if cropID==120
replace tree_type="Plant/Herb/Grass/Roots" if cropID==450
replace tree_type="Plant/Herb/Grass/Roots" if cropID==720
replace tree_type="Plant/Herb/Grass/Roots" if cropID==223
replace tree_type="Plant/Herb/Grass/Roots" if cropID==780
replace tree_type="Plant/Herb/Grass/Roots" if cropID==440
replace tree_type="Plant/Herb/Grass/Roots" if cropID==910
replace tree_type="Plant/Herb/Grass/Roots" if cropID==130
replace tree_type="Plant/Herb/Grass/Roots" if cropID==610
replace tree_type="Plant/Herb/Grass/Roots" if cropID==920
replace tree_type="Plant/Herb/Grass/Roots" if cropID==310
replace tree_type="Plant/Herb/Grass/Roots" if cropID==840
replace tree_type="Plant/Herb/Grass/Roots" if cropID==141
replace tree_type="Plant/Herb/Grass/Roots" if cropID==221
replace tree_type="Plant/Herb/Grass/Roots" if cropID==470
replace tree_type="Plant/Herb/Grass/Roots" if cropID==460
replace tree_type="Plant/Herb/Grass/Roots" if cropID==850
replace tree_type="Plant/Herb/Grass/Roots" if cropID==222
replace tree_type="Plant/Herb/Grass/Roots" if cropID==520
replace tree_type="Plant/Herb/Grass/Roots" if cropID==650
replace tree_type="Plant/Herb/Grass/Roots" if cropID==224
replace tree_type="Plant/Herb/Grass/Roots" if cropID==630
replace tree_type="Plant/Herb/Grass/Roots" if cropID==430
replace tree_type="Plant/Herb/Grass/Roots" if cropID==410
replace tree_type="Plant/Herb/Grass/Roots" if cropID==940
replace tree_type="Plant/Herb/Grass/Roots" if cropID==210
replace tree_type="Plant/Herb/Grass/Roots" if cropID==112
replace tree_type="Plant/Herb/Grass/Roots" if cropID==741 
replace tree_type="Plant/Herb/Grass/Roots" if cropID==742 
replace tree_type="Plant/Herb/Grass/Roots" if cropID==744
replace tree_type="Tree Cash Crops" if cropID==860
replace tree_type="Tree Cash Crops" if cropID==820
replace tree_type="Tree Cash Crops" if cropID==830
replace tree_type="Tree Cash Crops" if cropID==810
replace tree_type="Trees for timber and fuelwood" if cropID==880
replace tree_type="Trees for timber and fuelwood" if cropID==970
replace tree_type="Trees for timber and fuelwood" if cropID==990
replace tree_type="Trees for timber and fuelwood" if cropID==950
replace tree_type="Trees for timber and fuelwood" if cropID==960
replace tree_type="Plant/Herb/Grass/Roots" if cropID==991
replace tree_type="NA" if tree_type==""


