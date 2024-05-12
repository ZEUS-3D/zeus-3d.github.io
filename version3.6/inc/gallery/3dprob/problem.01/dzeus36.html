#---+----1----+----2----+----3----+--+----3----+----2----+----1----+---#
#============== SCRIPT FILE TO CREATE THE ZEUS EXECUTABLE =============#
#                                                                      #
#                        Sedov (1959) blast wave                       #
#                                                                      #
#  last dt=1.871227038688548E-05, nhy=4610                             #
#                                                                      #
#--------------------------------> Set FORTRAN compiler and problem tag.
#  Supported compilers include:
#     cf77 (Cray), f90 (Sun), g95 (g95.org), gfortran (Gnu), ifort 
#     (Intel), pgf77 (Portland Group), xlf (IBM)
#
setenv FCOMP gfortran
setenv TAG qf
#=======================================> Get files from home directory.
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
       parameter     (   in = 205,   jn = 205,   kn = 205 )
       parameter     ( nxpx = 400, nypx = 400, nxrd = 300, nyrd = 300 )
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
 \$iocon    iotty=6, iolog=2                                            \$
 \$rescon   dtdmp=0.0, idtag='$TAG', resfile='zr000$TAG'                \$
 \$ggen1    nbl=200, x1min=0.0, x1max=5.0, igrid=1, x1rat=1.0, lgrid=.t.\$
 \$ggen2    nbl=200, x2min=0.0, x2max=5.0, igrid=1, x2rat=1.0, lgrid=.t.\$
 \$ggen3    nbl=200, x3min=0.0, x3max=5.0, igrid=1, x3rat=1.0, lgrid=.t.\$
 \$pcon     nlim=100000, tlim=-0.1, ttotal=1.0e+7, tsave=10.0           \$
 \$hycon    qcon=0.0, qlin=0.2, courno=0.75, iord=2, iords=2, istp=0
         , trnvrsn=1, itote=1, avordw=2, voutbc=2                      \$
 \$iib      niib(1:205,1:205)=2                                         \$
 \$oib      noib(1:205,1:205)=9                                         \$
 \$ijb      nijb(1:205,1:205)=2                                         \$
 \$ojb      nojb(1:205,1:205)=9                                         \$
 \$ikb      nikb(1:205,1:205)=2                                         \$
 \$okb      nokb(1:205,1:205)=9                                         \$
 \$grvcon                                                               \$ 
 \$ambcon                                                               \$ 
 \$eqos     gamma=1.66666666666667                                      \$
 \$gcon                                                                 \$
 \$extcon   istretch=3,12,5,5, jstretch=3,12,5,5, kstretch=3,12,5,5     \$
 \$pl1con   dtpl1=0.01, norppl1=2, corl=1, npl1h=1, npl1v=1, allxl=2
         , pl1dir=1,2,3, ipl1=1,3,3, jpl1=3,1,3, kpl1=3,3,1
         , pl1mm=0
         , pl1var= 'd ', 'v ', 'p1', 'u1'
         , pl1min= -0.2,  0.0,-10.0, 10.0
         , pl1max=  4.2,  0.0,260.0,1.0e7
         , nlpl1 =    1,    1,    1,    2                              \$
 \$pl2con   dtpl2=0.01, norppl2=2, pl2ftr=1, pl2yl=1, pl2leg=1
         , pl2dir=3, lpl2=3, ireflpl2=1, jreflpl2=1
         , pl2sca1='d ','m ','p1','u1'
         , pl2vec1='  ','v '
         , pl2ccol=   1,   1,   1,   1
         , pl2ng1 =  50,   1,   1,  20                                 \$
 \$pixcon   dtpix=0.0005, pixpal=1, pixfmt=1
         , pixdir=1,2,3, lpix=3,3,3, npixi=3*200, npixj=3*200
         , ireflpix=1,1,1, jreflpix=1,1,1
         , pixvar= 'd ', 'v ', 'p1', 'u1'
         , nlpix =  100,    1,10000, 1000
         , pixmm =    0,    0,    0,    0
         , pixmin= 0.01,  0.0, 70.0,100.0
         , pixmax=  4.0, 14.0,1.0e4,4.0e4                              \$
 \$usrcon                                                               \$
 \$hdfcon                                                               \$
 \$tslcon   dttsl=0.01, dttsp=0.001, norptsp=2                          \$
 \$discon                                                               \$
 \$radcon   dtrad=0.0005, thetamin=-100.0, dtheta=0.5, phimin=-100.0
         , dphi=0.5, units='dg', radtype=0, radbox=2, radfmt=1
         , radpal=1
         , radvar= 'D ', 'VV', 'P1', 'T '
         , nlrad =    0,  -50,    0,    1
         , radmm =    2,    0,    0,    2
         , radmin=  0.0,-600.,  0.0,  0.0
         , radmax=  0.0,  80.,  0.0,  0.0                              \$
 \$pgen     r=0.0875, d0=1.0, p0=1.0e-5, d1=1.0, nrg=1.0e5, symm=8.0    \$
EOF
#============================================> MAKE the ZEUS executable.
make -f ./makezeus
#===================================================> Tidy up directory.
#rm -f ./checkin.o ./editlp ./inedit ./output ./xedit22
rm -f ./editlp ./inedit ./output ./xedit22
