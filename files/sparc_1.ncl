;***************************************************************
; sparc_1.ncl    
;
; Concepts illustrated:
;   - Read two ascii files. Each contains a separate variable.
;   - Create all associated meta data for each variable
;   - Create netCDF global attributes
;   - Writing the two variables  to a netCDF 
;***************************************************************
;
; SPARC Intercomparison of Middle Atmosphere Climatologies
; ftp://sparc-ftp1.ceda.ac.uk/sparc/ref_clim/randel/temp_wind/README
;
; TO READ ASCII DATA IN FORTRAN:
;     dimension temp(12,41,33),wind(12,41,46)
;     open(10,file='temp.ascii')
;     read(10,'(10f8.3)') temp
;     close(10)
;     open(10,file='wind.ascii')
;     read(10,'(8e10.3)') wind
;     close(10)
;-----------------------------------------------
; 12 month
; 41 latitude from 80S-80N with 4 degree interval
; 33 pressure levels for temp, 46 pressure levels for zonal wind
;  from 1000mb-.0046mb p(i)=10.**(3.-(i-1)/6.)
; unit is K for temp, m/s for wind
;-----------------------------------------------
; Randel, W.J. et al., (2004) 
; The SPARC Intercomparison of Middle Atmosphere Climatologies. 
; J. Climate, 17, 986-1003, doi:10.1175/1520-0442(2004)017<0986:TSIOMC>2.0.CO;2.
;
; SPARC, 2002: 
; SPARC Intercomparison of Middle Atmosphere Climatologies. 
; SPARC Report No. 3, Edited by W. Randel, M.-L. Chanin and C. Michaut, 96 pp.
;
; Swinbank, R. and D.A. Ortland, (2003) 
; Compilation of wind data for the UARS Reference Atmosphere Project
; J. Geophys. Res., 108, D19, 4615, doi:10.1029/2002JD003135.
;-----------------------------------------------

  diri = "./"
  filw = "sparc_wind.ascii"
  filt = "sparc_temp.ascii"

  ntim = 12 
  nlat = 41            ; 80S-80N with 4 degree interval

  klev_wind = 46
  wunits = "m/s"

  klev_temp = 33
  tunits = "degK"

  month = ispan(1,ntim,1)
  month!0 = "month"
  month@long_name = "month of year"
  month@info      = "1=Jan, 2=Feb, ... , 12=Dec"

  lat   = fspan(-80, 80, nlat)
  lat!0 = "lat"
  lat@long_name = "latitude"
  lat@units = "degrees_north"
 ;print(lat)

  lev_wind  = 10.^(3.-ispan(0,klev_wind-1,1)/6.)
  lev_wind!0= "lev_wind"
  lev_wind@long_name = "pressure"
  lev_wind@units = "hPa"
 ;print(lev_wind)

  lev_temp  = 10.^(3.-ispan(0,klev_temp-1,1)/6.)
  lev_temp!0= "lev_temp"
  lev_temp@long_name = "pressure"
  lev_temp@units = "hPa"
 ;print(lev_temp)

  xw   = asciiread(diri+filw, (/klev_wind,nlat,ntim/), "float")
  xw@_FillValue = 1e36  
  xt   = asciiread(diri+filt, (/klev_temp,nlat,ntim/), "float")
  xt@_FillValue = 1e36  

  xw!0 = "lev_wind"
  xw!1 = "lat"
  xw!2 = "month"
  xw&month = month
  xw&lev_wind = lev_wind
  xw&lat   = lat

  xt!0 = "lev_temp"
  xt!1 = "lat"
  xt!2 = "month"
  xt&month = month
  xt&lev_temp = lev_temp
  xt&lat = lat

  xw@long_name = "SPARC: monthly wind climatologies"
  xw@units     =  wunits  
  xt@long_name = "SPARC: monthly temperature climatologies"
  xt@units     =  tunits 

  printVarSummary(xw)
  printMinMax(xw, 1)
  print("---")
  printVarSummary(xt)
  printMinMax(xt, 1)
  print("---")

;===================================
  nline = inttochar(10)

  filo  = "SPARC.wind_temp.nc"
  system("/bin/rm -f "+filo)              ; remove any pre-existing file
  ncdf = addfile(filo ,"c")               ; open output netCDF file

  fAtt               = True               ; assign file attributes
  fAtt@title         = "SPARC Intercomparison of Middle Atmosphere Climatologies"
  fAtt@README        = "ftp://sparc-ftp1.ceda.ac.uk/sparc/ref_clim/randel/temp_wind/README"
  fAtt@WWW           = "http://www.sparc-climate.org/"
  fAtt@WWW_data      = "http://www.sparc-climate.org/data-center/data-access/reference-climatologies/randels-climatologies/temperature-wind-climatology/"
  fAtt@referencese   = nline + \
                       "Randel, W.J. et al., (2004)                                 "+nline+\
                       "The SPARC Intercomparison of Middle Atmosphere Climatologies"+nline+\
                       "J. Climate, 17, 986-1003                                    "+nline+\
                       "doi:10.1175/1520-0442(2004)017<0986:TSIOMC>2.0.CO;2.        "+nline+\
                       "                                                            "+nline+\
                       "SPARC, 2002                                                 "+nline+\ 
                       "SPARC Intercomparison of Middle Atmosphere Climatologies    "+nline+\
                       "SPARC Report No. 3, Edited by W. Randel, M.-L. Chanin and C. Michaut, 96 pp."+nline
  fAtt@Conventions   = "None"
  fAtt@creator       = "D. Shea, NCAR"
  fAtt@creation_date = systemfunc ("date")
  fileattdef( ncdf, fAtt )            ; copy file attributes
  ncdf->WIND = xw
  ncdf->TEMP = xt
