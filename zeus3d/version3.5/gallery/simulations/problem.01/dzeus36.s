#============== SOURCE FILE TO CREATE THE ZEUS EXECUTABLE =============#
#                                                                      #
#    D R I V E N   S U P E R - A L F V E N I C   T U R B U L E N C E   #
#                                                                      #
#=======================================> Get files from home directory.
if(! -e dzeus36) cp ~dclarke/zeus/version3.6/dzeus36 .
if(! -e xedit21) cp ~dclarke/editor/xedit21 .
if(! -e checkin.o) cp ~dclarke/zeus/checkin.o .
if(! -e libdnmlst.a) cp ~dclarke/libs/libdnmlst.a .
if(! -e libdsci01.a) cp ~dclarke/libs/libdsci01.a .
if(! -e libgrfx03.a) cp ~dclarke/libs/libgrfx03.a .
if(! -e libpspl.a) cp ~dclarke/libs/libpspl.a .
if(! -e libnoncar.a) cp ~dclarke/libs/libnoncar.a .
#if(! -e libmfhdf.a) cp ~dclarke/libs/libmfhdf.a .
#if(! -e libdf.a) cp ~dclarke/libs/libdf.a .
#if(! -e libsz.a) cp ~dclarke/libs/libsz.a .
#if(! -e libjpeg.a) cp ~dclarke/libs/libjpeg.a .
#if(! -e libz.a) cp ~dclarke/libs/libz.a .
#=======================> If necessary, create the directory "dzeus3.6".
if(! -e dzeus3.6) mkdir dzeus3.6
#----------------------------------------------> Create the change deck.
rm -f chgzeus
cat << EOF > chgzeus
*read zeus36.mac
*d par.42,43
       parameter     (   in = 133,  jn =  133,   kn = 133 )
       parameter     ( nxpx = 256, nypx = 256, nxrd = 400, nyrd = 400 )
EOF
#=======================> Create the input deck for EDITOR, and execute.
rm -f inedit
cat << EOF > inedit
 \$editpar   inname='dzeus36'
          , ibanner=0, idump=1, job=3, safety=0.20
          , ipre=1, inmlst=1, iupdate=1, iutask=2
          , chgdk='chgzeus'
          , branch='dzeus3.6'
          , makename='makezeus', xeq='xdzeus36'
c         , coptions='-g -fbounds-check', loptions='-g'
          , coptions='-O2', loptions='-O2'
          , libs='checkin.o libdnmlst.a libdsci01.a libgrfx03.a 
  libpspl.a libnoncar.a'                                               \$
EOF
chmod 755 xedit21
./xedit21
#--------------------------------------> Create the input deck for ZEUS.
rm -f inzeus
cat << EOF > inzeus
 \$iocon    iotty=6, iolog=2, intractv=1                                \$
 \$rescon   dtdmp=-10.0, idtag='az', resfile='zr000az'                  \$
 \$ggen1    nbl=128, x1min=-1.0, x1max=1.0, igrid=1, x1rat=1.0,lgrid=.t.\$
 \$ggen2    nbl=128, x2min=-1.0, x2max=1.0, igrid=1, x2rat=1.0,lgrid=.t.\$
 \$ggen3    nbl=128, x3min=-1.0, x3max=1.0, igrid=1, x3rat=1.0,lgrid=.t.\$
 \$pcon     nlim= 999999, tlim=160.0, ttotal=500000.0, tsave=10.0       \$
 \$hycon    qcon=1.0, qlin=0.2, courno=0.75, iord=2, iords=2, istp=0
         , itote=0, iscyqq=0, mind=1.0e-6                              \$
 \$iib      niib(1:133,1:133)=5                                         \$
 \$oib      noib(1:133,1:133)=5                                         \$
 \$ijb      nijb(1:133,1:133)=5                                         \$
 \$ojb      nojb(1:133,1:133)=5                                         \$
 \$ikb      nikb(1:133,1:133)=5                                         \$
 \$okb      nokb(1:133,1:133)=5                                         \$
 \$grvcon                                                               \$
 \$eqos     ciso(1)=0.1, gamma=1.66666666667                            \$
 \$gcon                                                                 \$
 \$extcon                                                               \$
 \$plt1con  dtplt1=10.0, corl=1, aspect=1.0, np1h=2, np1v=2, norpp1=2
         , iplt1dir=1,2,3, iplt1=3,3,3, jplt1=3,3,3, kplt1=3,3,3
         , plt1var='d ','v1','v2','v3','ma','b1','b2','b3'             \$
 \$plt2con  dtplt2=10.0, norpp2=2
         , iplt2dir=1,2,3, lplt2=3,3,3, dxvec=3*0.1, dyvec=3*0.1
         , plt2var='d ','va','ba','ma','vv'
         , ngplt2=6*0, pscolr=6*2, pscntr=6*1                          \$
 \$pixcon   dtpix=0.2, ipixmm=1
         , ipixdir=1,2,3, lpix=3,3,3, iflippx=3*1, ireflpx=3*0
         , pixvar= 'd ', 'pb', 'ma', 'vv'
         , nlpix =    0,    0,    0,    0
         , pixmin=  0.0,  0.0,  0.0,  0.0
         , pixmax=  0.0,  0.0,  0.0,  0.0                              \$
 \$voxcon                                                               \$
 \$usrcon                                                               \$
 \$hdfcon                                                               \$
 \$tslcon   dttsl=2.0, dttslp=0.2, norptsl=2, itslpftr=1, itslphdr=1    \$
 \$discon                                                               \$
 \$radcon   dtrad=0.2, thetamin=30.0, dtheta=1.0, phimin=20.0, dphi=1.0
         , units='dg', itype=0, iradmm=1, iradbox=1
         , radvar= 'D ', 'B ', 'VV', 'W ', 'MA'
         , nlrad =    0,    0,    0,    0,    0
         , radmin=  0.0,  0.0,  0.0,  0.0,  0.0
         , radmax=  0.0,  0.0,  0.0,  0.0,  0.0                        \$
 \$pgen     d0=1.0, v0=5.0, b10=1.0e-7, b20=0.0, b30=0.0, pow=1.66667
         , kmin=3, kmax=4, ldrv=1.0, tdec=0.0, nper=1, norpsp=2        \$
EOF
#============================================> MAKE the ZEUS executable.
make -f makezeus
#===================================================> Tidy up directory.
rm -f inedit output editlp chgedit chgedit.m
