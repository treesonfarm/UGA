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
* ---  PART I : CROP AND TREE CLASSIFICATION   ---- *
* ------------------------------------------------------------ *

  *----------------------------
  *  FIRST SEASON - VISIT I
  *----------------------------

    *-- 0. Open and keeping only information we need

            use "$path_data/UGA/2010-11/AGSEC4A.dta", clear
            gen season=1
            rename a4aq8 t_area

            keep HHID prcid pltid cropID a4aq7 a4aq9 season t_area a4aq7

            append using "$path_data/UGA/2010-11/AGSEC4B.dta", keep(HHID prcid pltid cropID a4bq7 a4bq8 a4bq9 )
            replace season=2 if season==.
            replace t_area=a4bq8 if t_area==.
            ** Area is in Acres (conver to HA)
            replace t_area=t_area*0.404686
            
           
    *-- 1. Include our Classification         
        
        include "$path_work/do-files/UGA-CropClassification.do"

    * Fix Area Plot 
     gen inter_crop=(a4aq7==2|a4bq7==2)

    bys HHID prcid pltid tree_type inter_crop : egen sum_are=sum(t_area)
    
    bys HHID prcid pltid tree_type inter_crop: gen n_crop_m=_N
    replace t_area=sum_are/n_crop_m if inter_crop==1

    *-- 2. Collapsing the information
       
        gen x=1
        collapse (sum) n_parcels=x  t_area,by(HHID  prcid tree_type season)

    *-- 3. We identify whether the Parcel has more than one crop (i.e. Inter-cropped)

            bys HHID  prcid season: gen n_crops_plot=_N
            gen inter_crop=(n_crops_plot>1 & n_crops_plot!=.)
            drop n_crops_plot

    *-- 4. Reshape the data for the new crops system

            encode tree_type, gen(type_crop)
                *1 Fruit Tree
                *2 NA
                *3 Plant/Herb/Grass/Roots
                *4 Agricultural Tree (Cash Crops)
                *5 Trees for timber and fuel-wood
            drop tree_type
            order HHID prcid type_crop 
            reshape wide n_parcels t_area, i(HHID prcid season) j(type_crop)

    *--- 5. rename Variables 
            global names " Tree_Fruit NA  Plant Tree_Agri Tree_wood "
            local number "1 2 3 4 5 "
            
            local i=1
            foreach y of global names {
                local name: word `i' of `number'
                foreach h in n_parcels t_area {
                rename `h'`name' `h'_`y'
                replace `h'_`y'=0 if `h'_`y'==.
                }
                local i=`i'+1
            }

    *--- 6. Save the data

          order HHID prcid season inter_crop 
   
            save "$path_work/UGA/0_CropsClassification.dta", replace

       
