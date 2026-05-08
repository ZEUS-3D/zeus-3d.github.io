#                         S H R A W I I B . Z R P
#
#    Scripts to launch a shear Alfven wave from the inner-i boundary in
#    ZRP coordinates.
#
#    last dt = 9.14495E-03, nhy = 107
#
#============== SOURCE FILE TO CREATE THE ZEUS EXECUTABLE =============#
#
#=======================================> Get files from home directory.
if(! -e dzeus35) cp ~dclarke/zeus/version3.5/dzeus35 .
if(! -e dchgz35) cp ~dclarke/zeus/version3.5/dchgz35 .
if(! -e xedit21) cp ~dclarke/editor/xedit21 .
if(! -e checkin.o) cp ~dclarke/zeus/checkin.o .
#=======================> If necessary, create the directory "dzeus3.5".
if(! -e dzeus3.5) mkdir dzeus3.5
#----------------------------------------------> Create the change deck.
rm -f chgzeus
cat << EOF > chgzeus
*read zeus35.mac
*d par.42,43
       parameter     ( in   =  55, jn   = 55,  kn   =  1 )
       parameter     ( nxpx = 200, nypx = 200, nxrd =  1, nyrd =  1 )
**read dchgz35
EOF
#=======================> Create the input deck for EDITOR, and execute.
rm -f inedit
cat << EOF > inedit
 \$editpar   inname='dzeus35'
          , ibanner=0, idump=1, job=3, safety=0.20
          , ipre=1, inmlst=1, iupdate=1, iutask=0
          , chgdk='chgzeus'
          , branch='dzeus3.5'
          , makename='makezeus', xeq='xdzeus35'
          , coptions='-g -C -ftrap=common', loptions='-g'
c         , coptions='-fast -fsimple=1', loptions='-fast'
c         , speccopt='-g', specdk='nmlsts','plot1d','plot2d'
          , libs='checkin.o -ldnmlst -ldsci01 -lgrfx03 -lpspl
  -lmfhdf -ldf -ljpeg -lz -lX11 -lcgm -lncarg -lncarg_c -lncarg_gks 
  -lncarg_ras -lngmath'                                                \$
EOF
chmod 755 xedit21
./xedit21
#--------------------------------------> Create the input deck for ZEUS.
rm -f inzeus
cat << EOF > inzeus
 \$iocon    iotty=6, iolog=2                                            \$
 \$rescon   dtdmp=0.0, idtag='yd', resfile='zr00yd'                     \$
 \$ggen1    nbl=50, x1min=0.0, x1max=5.0, igrid=1, x1rat=1.0, lgrid=.t. \$
 \$ggen2    nbl=50, x2min=0.0, x2max=5.0, igrid=1, x2rat=1.0, lgrid=.t. \$
 \$ggen3                                                                \$
 \$pcon     nlim= 999999, tlim=-4.0, ttotal=1.0e+7, tsave=10.0          \$
 \$hycon    qcon=0.0, qlin=0.0, courno=0.75, iord=2, iords=2, istp=0    \$
 \$iib                                                                  \$
 \$oib      noib(1:55,1)=9                                              \$
 \$ijb      nijb(1,1:55)=1                                              \$
 \$ojb      nojb(1,1:55)=9                                              \$
 \$ikb                                                                  \$
 \$okb                                                                  \$
 \$grvcon                                                               \$
 \$eqos     gamma=1.666666666667                                        \$
 \$gcon                                                                 \$
 \$extcon                                                               \$
 \$plt1con  iplt1dir=1,2,2,2, jplt1=52,1,1,1, iplt1=1,2,3,27
         , dtplt1=1.0, corl=1, aspect=1.0, np1h=1, np1v=2, norpp1=2
         , p1xlab='|F10|z','|F10|r','|F10|r','|F10|r'
         , x1p1mn=-0.2, x1p1mx=5.0
         , p1ylab ='|F10|v|BF5|f','|F10|B|BF5|f'
         , plt1var='v3','b3'
         , plt1min=-0.2e-6,-5.2e-6
         , plt1max= 5.2e-6, 0.2e-6
         , allxl=1, allyl=1, ip1ftr=0, iplt1mm=0                       \$
 \$plt2con  iplt2dir=3, lplt2= 1, dtplt2=1.0, norpp2=2, pscolr=2
         , pscntr=1
         , plt2var= 'vn', 'bn','dv','p '                               \$
 \$pixcon   ipixdir=3, dtpix=0.1, lpix=1, npi=200, npj=200, iref=0
         , pixvar=  'v3',   'b3'
         , pixmin=   0.0,-2.5e-6
         , pixmax=2.5e-6,    0.0
         , ipixmm=0, x1pxmx=5.0, iflippx=1                             \$
 \$voxcon                                                               \$
 \$usrcon                                                               \$
 \$hdfcon                                                               \$
 \$tslcon                                                               \$
 \$discon                                                               \$
 \$radcon                                                               \$
 \$pgen     ri=1.0, dam=1.0, e1am=1.5, b1am=1.0, ioro=1
         , v3b1=0.0, v3b2=1.0e-6, v3b3=0.0
         , b3b1=0.0, b3b2=0.0   , b3b3=0.0                             \$
EOF
#============================================> MAKE the ZEUS executable.
make -f makezeus
