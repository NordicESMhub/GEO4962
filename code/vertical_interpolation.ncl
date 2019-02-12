f = addfile (input_filename , "r")  
  hyam = f->hyam                    
  hybm = f->hybm
  PSFC = f->PS
  P0mb = 0.01*f->P0
  PHIS = f->PHIS                       ; surface geopotential [2D]

  T    = f->T                          ; temperature at hybrid levels
  Z    = f->Z3                         ; geo hgt at hybrid levels
  U    = f->U                          ; zonal wind
  
  nlev = dimsizes(hyam)                ; number of vertical levels
  tbot = T(:,nlev-1,:,:)               ; bot temp level [clarity]
 
                                       ; specify levels to be interpolated
;  lev_p   = (/1000.0, 900., 850., 700., 500., 300., 200. , 100., 50., 20., 10./)
  lev_p!0         = "lev_p"            ; variable and dimension name the same
  lev_p&lev_p     = lev_p              ; create coordinate variable
  lev_p@long_name = "pressure"         ; attach some attributes
  lev_p@units     = "hPa"
  lev_p@positive  = "down"
  
; type of interpolation: 1 = linear, 2 = log, 3 = loglog
  intyp = 2                             ; 1=linear, 2=log, 3=log-log
  kxtrp = True                          ; True=extrapolate
  
  varflg = 1                           ; temperature is variable
  TonP     = vinth2p_ecmwf(T,hyam,hybm,lev_p,PSFC,intyp,P0mb, \
                 1,kxtrp,varflg,tbot,PHIS)

   varflg = 0
   UonP = vinth2p_ecmwf(U,hyam,hybm,lev_p,PSFC,intyp,P0mb,1,kxtrp, varflg,tbot,PHIS)
  
;    ncdf = addfile("simple.nc" ,"c")  ; open output netCDF file
    ncdf = addfile(output_filename ,"c")  ; open output netCDF file

  ;===================================================================
  ; create global attributes of the file (optional)
  ;===================================================================
  fAtt               = True            ; assign file attributes
  fAtt@title         = "NCL Simple Approach to netCDF Creation"
  fAtt@source_file   =  "original-file.nc"
  fAtt@Conventions   = "None"
  fAtt@creation_date = systemfunc ("date")
  fileattdef( ncdf, fAtt )            ; copy file attributes

  ;===================================================================
  ; make time an UNLIMITED dimension; recommended  for most applications
  ;===================================================================
  filedimdef(ncdf,"time",-1,True)
  ;===================================================================
  ; output variables directly; NCL will call appropriate functions
  ; to write the meta data associated with each variable
  ;===================================================================
   ncdf->T  = TonP                          ; 4D
   ncdf->U  = UonP                          ; 4D

