  input_filename = "f2000.T31T31.control.cam.h0_TUmean.nc"
  output_prefix = "f2000.T31T31.control.cam.h0_TUmean_pl"
  f = addfile (input_filename , "r")  
  hyam = f->hyam(0,:)                    
  hybm = f->hybm(0,:)
  PSFC = f->PS
  P0mb = 0.01*f->P0(0)
  PHIS = f->PHIS                       ; surface geopotential [2D]

  T    = f->T                          ; temperature at hybrid levels
  U    = f->U                          ; zonal wind
  
  nlev = dimsizes(hyam)                ; number of vertical levels
  tbot = T(:,nlev-1,:, :)                ; bot temp level [clarity]
 
                                       ; specify levels to be interpolated
  lev_p   = (/1000.0, 900., 850., 700., 500., 300., 200. , 100., 50., 20., 10./)
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
  
   ; write one file per month

   do month=1,12
     strs = (/ output_prefix, "_", tostring(month), ".nc" /)
     output_filename = str_concat(strs)
     ncdf = addfile(output_filename ,"c")  ; open output netCDF file

    ;===================================================================
    ; create global attributes of the file (optional)
    ;===================================================================
    fAtt               = True            ; assign file attributes
    fAtt@title         = "NCL Simple Approach to netCDF Creation"
    fAtt@source_file   =  input_filename
    fAtt@Conventions   = "None"
    fAtt@creation_date = systemfunc ("date")
    fileattdef( ncdf, fAtt )            ; copy file attributes

    ;===================================================================
    ; make time an UNLIMITED dimension; recommended  for most applications
    ;===================================================================
    ;filedimdef(ncdf,"time",-1,True)
    ;===================================================================
    ; output variables directly; NCL will call appropriate functions
    ; to write the meta data associated with each variable
    ;===================================================================
    ; month -1 because with ncl indices start from 0
     ncdf->T  = TonP(month-1,:,:,:)                          ; 2D
     ncdf->U  = UonP(month-1,:,:,:)                          ; 2D
     delete(ncdf)
   end do
