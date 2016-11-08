*-------------------------------------------------------------*
*-------------------------------------------------------------*
*                     Trees on Farm:                          *
*    Prevalence, Economic Contribution, and                   *
*   Determinants of Trees on Farms across Sub-Saharan Africa  *
*                                                             *
*             https://treesonfarm.github.io                   *
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

* ------------------------------------------------------------ *
* ---  PART II : Income Generated   ---- *
* ------------------------------------------------------------ *

  *----------------------------
  *  FIRST SEASON - VISIT I
  *----------------------------

    *-- 0. Open and keeping only information we need

            use "$path_data/UGA/2010-11/AGSEC5A.dta", clear

            rename a5aq8 value_sold
            rename a5aq6a q_harvest
            rename a5aq7a q_sold
            rename a5aq13 q_selfcosumption
            rename a5aq12 q_gift
            rename a5aq15 q_lost

            keep HHID prcid pltid cropID value_sold q_*
           
    *-- 1. Include our Classification         
        
        include "$path_work/do-files/UGA-CropClassification.do"
        
        
    *-- 4. Fixing value
        foreach i in q_harvest q_sold q_selfcosumption q_gift q_lost {
            replace `i'=0 if `i'==.
        }


        gen total=q_sold+q_selfcosumption+q_gift+q_lost


        gen x=(total>q_harvest)
        drop if x==1
        gen q_other=q_harvest-total


    *-- 2. Collapsing the information 

        foreach i in _sold _selfcosumption _gift _lost _other {
            gen share_q`i'=q`i'/q_harvest
        }

      collapse (sum) value_sold (mean) share_q_* ,by(HHID tree_type)


    *-- 4. Merge HH information 
          merge n:1 HHID using "$path_data/UGA/2010-11/GSEC1.dta", keepusing(region urban stratum comm h1aq1 wgt10  hh_status) nogenerate

    *-- 3. Save the data set

      save "$path_work/UGA/1_CropsSells.dta", replace



