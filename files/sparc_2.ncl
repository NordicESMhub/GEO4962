;***************************************************************
; sparc_2.ncl    
;
; Concepts illustrated:
;   - Read data from the netCDF file created by sparc_1.ncl
;   - Read each months's data in a loop
;   - Custom tick mark labeling on the left axis 
;   - Use the 'nice_mnmxintvl' function to set the contour levels
;   - Panel plot for each variable
;***************************************************************
;
begin

  diri = "./"
  fili = "SPARC.wind_temp.nc"
  f    = addfile(diri+fili, "r")
  temp = f->TEMP
  wind = f->WIND

  dimw = dimsizes(wind)
  ntim = dimw(2)

;----------------------------------------------------------------------
; Prints to make sure everything looks ok.
;----------------------------------------------------------------------
  printVarSummary(temp)
  printMinMax(temp,0)

  printVarSummary(wind)
  printMinMax(wind,0)

;----------------------------------------------------------------------
; Graphics
;----------------------------------------------------------------------
  wtype = "png"           ; x11, ps, pdf, svg
 ;if(wtype.eq."png")
 ;  wtype@wkWidth  = 1500
 ;  wtype@wkHeight = 1500
 ;end if
  wks = gsn_open_wks(wtype,"sparc")

;---Set some graphical resources (options) common for both wind and temp plots
  res                      = True

  res@gsnDraw              = False    ; don't draw individual plots
  res@gsnFrame             = False    ; don't advance frame

  res@trYReverse           = True     ; reverse Y axis

;---Customize contours
  res@cnFillOn             = True     ; turn on contour fill
  res@cnLineLabelsOn       = False    ; turn off line labels
  res@cnInfoLabelOn        = False    ; turn off info label
  res@cnFillPalette        = "MPL_jet"; change the color map
  res@lbLabelBarOn         = False    ; will add labelbar in panel
  res@cnLevelSelectionMode = "ManualLevels"

;---Various titles
  res@tiYAxisString        = temp&lev_temp@long_name + " (" + temp&lev_temp@units + ")"
  res@tiXAxisString        = temp&lat@long_name
  res@gsnRightString       = ""
  res@gsnLeftString        = ""

;---Customize tickmarks
  res@tmXTOn               = False       ; turn off top tickmarks
  res@tmYROn               = False       ; turn off right tickmarks
  res@tmYLMode             = "Explicit"  ; will explicitly label left axis (later)

;---Now create individual resource lists for each variable
  tres = res
  wres = res

;---Set explicit labels on left Y axis
  tres@tmYLValues          = (/0.005,0.01,0.02,0.05,0.1,0.2,0.5,1,2,5,10,\
                               20,50,100,200,500,1000/)
  tres@tmYLLabels          = "" + tres@tmYLValues

  wres@tmYLValues          = (/5e-5,1e-4,0.0002,0.0005,0.001,0.002,0.005,\
                               0.01,0.02,0.05,0.1,0.2,0.5,1,2,5,10,20,50,\
                               100,200,500,1000/)
  wres@tmYLLabels          = "" + wres@tmYLValues

;---Fix the contour levels for both plots
  temp_mnmxint = nice_mnmxintvl( min(temp), max(temp), 18, False)
  wind_mnmxint = nice_mnmxintvl( min(wind), max(wind), 18, False)

  tres@cnMinLevelValF      = temp_mnmxint(0)
  tres@cnMaxLevelValF      = temp_mnmxint(1)
  tres@cnLevelSpacingF     = temp_mnmxint(2)

  wres@cnMinLevelValF      = wind_mnmxint(0)
  wres@cnMaxLevelValF      = wind_mnmxint(1)
  wres@cnLevelSpacingF     = wind_mnmxint(2)

;---Loop through all time steps and create a temp/wind plot for each
  plot_temp = new(ntim,graphic)    ; array to hold each plot
  plot_wind = new(ntim,graphic)
  do nt=0,ntim-1
    plot_temp(nt) = gsn_csm_contour(wks,temp(:,:,nt),tres)
    plot_wind(nt) = gsn_csm_contour(wks,wind(:,:,nt),wres)
  end do

;---Panel both sets of plots
  pres                       = True
  pres@gsnPanelLabelBar      = True
  pres@gsnMaximize           = True

  pres@gsnPanelFigureStrings            = str_upper(month_name(0))  ; "JAN", "FEB", ...
  pres@gsnPanelFigureStringsFontHeightF = 0.01

  pres@gsnPanelMainString    = fili + " - " + temp@long_name + " (" + temp@units + ")"
  gsn_panel(wks,plot_temp,(/3,4/),pres)

  pres@gsnPanelMainString    = fili + " - " + wind@long_name + " (" + wind@units + ")"
  gsn_panel(wks,plot_wind,(/3,4/),pres)
end
