#============== SOURCE FILE TO CREATE THE ZEUS EXECUTABLE =============#
#                                                                      #
#                    A Q :   2 - D   H D   S H R L Y R                 #
#                                                                      #
#=======================================> Get files from home directory.
if(! -e dzeus36) cp /home/dclarke/zeus/version3.6/dzeus36 .
if(! -e xedit21) cp /home/dclarke/editor/xedit21 .
if(! -e checkin.o) cp /home/dclarke/zeus/checkin.o .
#=======================> If necessary, create the directory "dzeus3.6".
if(! -e dzeus3.6) mkdir dzeus3.6
#----------------------------------------------> Create the change deck.
rm -f chgzeus
cat << EOF > chgzeus
*read zeus36.mac
*d par.42,43
       parameter     (   in = 517,   jn = 805,   kn =   1 )
       parameter     ( nxpx = 512, nypx =1000, nxrd =   1, nyrd =   1 )
EOF
#=======================> Create the input deck for EDITOR, and execute.
rm -f inedit
cat << EOF > inedit
 \$editpar   inname='dzeus36'
          , ibanner=0, idump=1, job=3, safety=0.20
          , ipre=1, inmlst=1, iupdate=1, iutask=0
          , chgdk='chgzeus'
          , branch='dzeus3.6'
          , makename='makezeus', xeq='xdzeus36'
c         , coptions='-g -C -ftrap=common', loptions='-g'
          , coptions='-fast -fsimple=1', loptions='-fast'
          , speccopt='-g', specdk='corona','phistv','nmlsts','plot1d'
c         , libs='checkin.o -ldnmlst -ldsci01 -lgrfx03 -lpspl -lnoncar \$
c         , libs='checkin.o -ldnmlst -ldsci01 -lgrfx03 -lpspl -lnoncar 
c -lmfhdf -ldf -ljpeg -lz -lX11 -lcgm'                                 \$
          , libs='checkin.o -ldnmlst -ldsci01 -lgrfx03 -lnopspl -lmfhdf 
  -ldf -ljpeg -lz -lX11 -lcgm -lncarg -lncarg_c -lncarg_gks -lncarg_ras
  -lngmath'                                                            \$
EOF
chmod 755 xedit21
./xedit21
#--------------------------------------> Create the input deck for ZEUS.
rm -f inzeus
cat << EOF > inzeus
 \$iocon    iotty=6, iolog=2, intractv=1                                \$
 \$rescon   dtdmp=12.0, idtag='aq', resfile='zr00aq'                    \$
 \$ggen1    nbl=512, x1min=-0.5, x1max=0.5, igrid=1, x1rat=1.0,lgrid=.t.\$
 \$ggen2    nbl=512, x2min=-0.5, x2max=0.5, igrid=1, x2rat=1.0,lgrid=.t.\$
 \$ggen3                                                                \$
 \$pcon     nlim= 999999, tlim=-12.0, ttotal=36000.0, tsave=10.0        \$
 \$hycon    qcon=2.0, qlin=0.2, courno=0.5, iord=2, istp=0, itote=1     \$
 \$iib      niib(1:517,1:1  )=5                                         \$
 \$oib      noib(1:517,1:1  )=5                                         \$
 \$ijb      nijb(1:1  ,1:517)=2                                         \$
 \$ojb      nojb(1:1  ,1:517)=2                                         \$
 \$ikb                                                                  \$
 \$okb                                                                  \$
 \$grvcon                                                               \$
 \$eqos     gamma=1.6666666666667                                       \$
 \$gcon                                                                 \$
 \$extcon                                                               \$
 \$plt1con                                                              \$
 \$plt2con  iplt2dir=3,3, dtplt2=1.0, iplt2mm=1, dxvec=0.05, dyvec=0.05
         , norpp2=2, numcl=2*15, pscolr=2*0, ip2ylab=1,0, ip2xlab=1,0
         , ip2hdr=1,0, ip2ftr=1,0, x2p2mn=-0.5,-0.1, x2p2mx=0.5,0.1
         , plt2var= 'dv', 'wn'                                         \$
 \$pixcon   ipixdir=3, dtpix=0.025, ipixmm=0, npi=512, npj=512
         , pixvar =   'd ',   'p ',   'v1',   'v2',   'vv',   'wn' 
         , nlpix  =      0,      0,      0,      0,      0,      0
         , pixmin =   0.45,   0.18,   -0.9,   -0.6,    0.0,    0.0
         , pixmax =   1.15,   0.79,    0.9,    0.6,    0.0,    0.0     \$
 \$voxcon                                                               \$
 \$usrcon                                                               \$
 \$hdfcon                                                               \$
 \$tslcon   dttsl=1.0, dttslp=0.025                                     \$
 \$discon                                                               \$
 \$radcon                                                               \$
 \$pgen     ipert=2, delv1=1.0, shear=0.02                              \$
EOF
#============================================> MAKE the ZEUS executable.
make -f makezeus
#===================================================> Tidy up directory.
rm -f editlp inedit output xedit21
