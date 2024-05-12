#---+----1----+----2----+----3----+--+----3----+----2----+----1----+---#
#============== SCRIPT FILE TO CREATE THE ZEUS EXECUTABLE =============#
#                                                                      #
#               Super-Alfvenic turbulence (128^3 to t=80)              #
#                                                                      #
#  last dt=1.156813062612129E-03, nhy=111                              #
#                                                                      #
#--------------------------------> Set FORTRAN compiler and problem tag.
#  Supported compilers include:
#     cf77 (Cray), f90 (Sun), g95 (g95.org), gfortran (Gnu), ifort 
#     (Intel), pgf77 (Portland Group), xlf (IBM)
#
setenv FCOMP gfortran
setenv TAG zc
##=======================================> Get files from home directory.
if(! -e ./xedit22) cp ../editor/xedit22 .
if(! -e ./dnamelist.a) cp ../nmlst/dnamelist.a .
if(! -e ./dsci01.a) cp ../sci/dsci01.a .
if(! -e ./grfx03.a) cp ../grfx/grfx03.a .
if(! -e ./psplot.a) cp ../grfx/psplot.a .
if(! -e ./noncar.a) cp ../grfx/noncar.a .
#=======================> If necessary, create the directory "dzeus3.6".
if(! -e ./dzeus3.6) mkdir ./dzeus3.6
#----------------------------------------------> Create the change deck.
rm -f ./chgzeus
cat << EOF > ./chgzeus
*read zeus36.mac
*define $FCOMP
*d par.44,45
       parameter     (   in = 133,   jn = 133,   kn = 133 )
       parameter     ( nxpx = 256, nypx = 256, nxrd = 400, nyrd = 400 )
**read chguser
EOF
#=======================> Create the input deck for EDITOR, and execute.
rm -f ./inedit
cat << EOF > ./inedit
 \$editpar   inname='dzeus36', chgdk='chgzeus', idump=1, job=3
          , ipre=1, inmlst=1, iupdate=1, iutask=0, safety=0.20
          , branch='dzeus3.6', xeq='xdzeus36', makename='makezeus'
          , compiler='$FCOMP', coptions='optimise'
          , libs='checkin.o dnamelist.a dsci01.a grfx03.a psplot.a
  noncar.a'                                                            \$
EOF
chmod 755 ./xedit22
./xedit22
#--------------------------------------> Create the input deck for ZEUS.
rm -f ./inzeus
cat << EOF > ./inzeus
 \$iocon    iotty=6, iolog=2, intractv=1                                \$
 \$rescon   dtdmp=-4.0, idtag='$TAG', resfile='zr000$TAG'               \$
 \$ggen1    nbl=128, x1min=-1.0, x1max=1.0, igrid=1, x1rat=1.0,lgrid=.t.\$
 \$ggen2    nbl=128, x2min=-1.0, x2max=1.0, igrid=1, x2rat=1.0,lgrid=.t.\$
 \$ggen3    nbl=128, x3min=-1.0, x3max=1.0, igrid=1, x3rat=1.0,lgrid=.t.\$
 \$pcon     nlim=999999, tlim=-80.0, ttotal=500000.0, tsave=10.0        \$
 \$hycon    qcon=1.0, qlin=0.2, courno=0.75, iord=2, iords=2, istp=0
         , trnvrsn=1, itote=0, mind=1.0e-6                              \$
 \$iib      niib(1:133,1:133)=5                                         \$
 \$oib      noib(1:133,1:133)=5                                         \$
 \$ijb      nijb(1:133,1:133)=5                                         \$
 \$ojb      nojb(1:133,1:133)=5                                         \$
 \$ikb      nikb(1:133,1:133)=5                                         \$
 \$okb      nokb(1:133,1:133)=5                                         \$
 \$grvcon                                                               \$
 \$ambcon                                                               \$ 
 \$eqos     ciso(1)=0.1, gamma=1.66666666667                            \$
 \$gcon                                                                 \$
 \$extcon                                                               \$
 \$pl1con   dtpl1=10.0, corl=1, aspect=1.0, npl1h=2, npl1v=2, norppl1=2
         , pl1dir=1,2,3, ipl1=3,3,3, jpl1=3,3,3, kpl1=3,3,3
         , pl1var='d ','v1','v2','v3','mA','b1','b2','b3'              \$
 \$pl2con   dtpl2=10.0, norppl2=2, pl2dir=1,2,3, lpl2=3,3,3
         , pl2sca1='d ','vn','bn','mA','vv'
         , pl2vec1='  ','v ','b '
         , pl2ng1=5*0, pl2ccolr=5*2                                    \$
 \$pixcon   dtpix=0.16, pixfmt=1, pixpal=2, pixdir=1, lpix=3
         , iflippix=0, ireflpix=0
         , pixvar= 'd ', 'pb', 'mA', 'vv'
         , nlpix =    0,    0,    0,    0
         , pixmm =    2,    2,    2,    2
         , pixmin=  0.0,  0.0,  0.0,  0.0
         , pixmax=  0.0,  0.0,  0.0,  0.0                              \$
 \$usrcon                                                               \$
 \$hdfcon                                                               \$
 \$tslcon   dttsl=2.0, dttsp=0.2, norptsp=2, tspftr=1, tsphdr=1
         , ntsph=2, ntspv=2                                            \$
 \$discon                                                               \$
 \$radcon   dtrad=0.16, radfmt=1, radpal=1, radtype=2, radbox=2
         , thetamin=30.0, dtheta=1.0, phimin=20.0, dphi=0.5, units='dg'
         , incpx=10, incpy=10, pscale=0.8
         , radvar= 'D ', 'B ', 'VV', 'I ', 'FV'
         , nlrad =    0,    0,    0,  100,    0
         , radmm =    2,    2,    2,    2,    2
         , radmin=  0.0,  0.0,  0.0,  0.0,  0.0
         , radmax=  0.0,  0.0,  0.0,  0.0,  0.0                        \$
 \$pgen     d0=1.0, v0=5.0, b10=1.0e-5, b20=0.0, b30=0.0, pow=1.66667
         , kmin=3, kmax=4, ldrv=1.0, tdec=0.0, nper=1, norpsp=2        \$
EOF
#============================================> MAKE the ZEUS executable.
make -f ./makezeus
#===================================================> Tidy up directory.
rm -f ./editlp ./inedit ./output ./xedit22
