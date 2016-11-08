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
* --- PLOT SIZE AND HH WITH PLOTS   ---- *
* ------------------------------------------------------------ *
* We merge owns plot (AGSEC2B.dta) + plot that they have rights (AGSEC2A.dta)
    
    *-- 1. Open and append the data
        use "$path_data/UGA/2010-11/AGSEC2A.dta", clear
        gen land_rights=1
        append using "$path_data/UGA/2010-11/AGSEC2B.dta"
        replace land_rights=0 if land_rights==.
        label def land_rights 1 "Land Holding" 2 "Access To Right"
        label val land_rights land_rights
   
    *-- 2. Fix the Parcel Size 
        gen parcel_size_gps=a2aq4*0.404686
        replace parcel_size_gps=a2bq4*0.404686 if parcel_size_gps==.

        gen parcel_size_farmer=a2aq5*0.404686
        replace parcel_size_farmer=a2bq5*0.404686 if parcel_size_farmer==.

        replace parcel_size_farmer=parcel_size_gps if parcel_size_farmer==.
 
    *-- 3. Data about the main use

       keep HHID prcid parcel_size_farmer a2aq13a a2aq13b a2bq15a a2bq15b land_rights

       order HHID prcid land_rights parcel_size_farmer

       replace a2aq13a=a2bq15a if land_rights==0
       replace a2aq13b=a2bq15b if land_rights==0

       drop a2bq15a a2bq15b

       rename a2aq13a parcel_use1
       rename a2aq13b parcel_use2

    *-- 4. Reshape for seasons

      reshape long parcel_use, i(HHID prcid) j(season 1 2)

    *-- 5. Merge the data with Crops information
      sort HHID prcid season
      merge 1:1 HHID prcid season using "$path_work/UGA/0_CropsClassification.dta", nogenerate 

          preserve
          keep HHID prcid season t_area_*
          collapse (sum) t_area_*, by(HHID prcid)
          gen total=t_area_Tree_Fruit+t_area_NA+t_area_Plant+t_area_Tree_Agri+t_area_Tree_wood

            foreach i in _Tree_Fruit _NA _Plant _Tree_Agri _Tree_wood {
              gen s`i'=t_area`i'/total
            }

            save "$path_work/UGA/UGA_Share.dta", replace
          restore

      foreach i in n_parcels_Tree_Fruit n_parcels_Tree_Agri n_parcels_Tree_wood n_parcels_NA n_parcels_Plant {
        replace `i'=(`i'>0 & `i'!=.)
      }

    *-- 6. Putting the data at HH level

      * Those non-cultivated plots with forest
      replace  n_parcels_Tree_wood=n_parcels_Tree_wood+1 if parcel_use==7

      foreach i in  _Tree_Fruit _Tree_Agri _Tree_wood _NA _Plant {
        gen inter_n`i'=inter_crop*n_parcels`i'
      }

      foreach i in t_area_Tree_Fruit t_area_Tree_Agri t_area_Tree_wood {
        replace `i'=0 if `i'==.
      }


      gen t_area_pre_trees=parcel_size_farmer if t_area_Tree_Fruit>0| t_area_Tree_Agri>0| t_area_Tree_wood>0
      replace t_area_pre_trees=0 if t_area_pre_trees==.

      foreach i in _Tree_Fruit _Tree_Agri _Tree_wood {
      gen t_area_pre`i'=parcel_size_farmer if t_area`i'>0
      replace t_area_pre`i'=0 if t_area_pre`i'==.
    }

      gen x=1

    collapse (sum)  n_parcels_* inter_n*  t_area_* inter_crop farm_size=parcel_size_farmer n_plots=x, by(HHID season)


    *-- 6. Merge with household data

    merge n:1 HHID using "$path_data/UGA/2010-11/GSEC1.dta", keepusing(region urban stratum comm h1aq1 wgt10  hh_status) nogenerate

     save "$path_work/UGA/1_Plot-Crop_Information.dta", replace










