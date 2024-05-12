#---+----1----+----2----+----3----+--+----3----+----2----+----1----+---#
#============== SCRIPT FILE TO CREATE THE ZEUS EXECUTABLE =============#
#                                                                      #
#      Orszag-Tang magnetic vortex (1998, J. Fluid Mech., 90, 129)     #
#                                                                      #
#  last dt=1.969557530483087E-04, nhy=500                              #
#                                                                      #
#--------------------------------> Set FORTRAN compiler and problem tag.
#  Supported compilers include:
#     cf77 (Cray), f90 (Sun), g95 (g95.org), gfortran (Gnu), ifort 
#     (Intel), pgf77 (Portland Group), xlf (IBM)
#
setenv FCOMP gfortran
setenv TAG kk
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
       parameter     ( in   = 517, jn   = 517, kn   = 1 )
       parameter     ( nxpx = 512, nypx = 512, nxrd = 1, nyrd = 1 )
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
 \$ggen1    nbl=256, x1min=0.0, x1max=1.0, igrid=1, x1rat=1.0, lgrid=.t.\$
 \$ggen2    nbl=256, x2min=0.0, x2max=1.0, igrid=1, x2rat=1.0, lgrid=.t.\$
 \$ggen3                                                                \$
 \$pcon     nlim=99999, tlim=-0.5, ttotal=1.0e+7, tsave=10.0            \$
 \$hycon    qcon=1.0, qlin=0.1, courno=0.75, iord=2, iords=2, istp=0
         , trnvrsn=1, itote=1                                          \$
 \$iib      niib(1:261,1:  1)=5                                         \$
 \$oib      noib(1:261,1:  1)=5                                         \$
 \$ijb      nijb(1:  1,1:261)=5                                         \$
 \$ojb      nojb(1:  1,1:261)=5                                         \$
 \$ikb                                                                  \$
 \$okb                                                                  \$
 \$grvcon                                                               \$
 \$ambcon                                                               \$
 \$eqos     gamma=1.66666666666667                                      \$
 \$gcon                                                                 \$
 \$extcon                                                               \$
 \$pl1con                                                               \$
 \$pl2con   dtpl2=0.5, pl2dir=3, lpl2=1, norppl2=2, pl2yl=1, pl2ftr=1
         , pl2mm1=0, npl2i=128, npl2j=128
         , pl2sca1 ='d ','Vv','wn','pb','et'
         , pl2sca2 ='  ','  ','  ','an'
         , pl2vec1 ='v '
         , pl2ng1  =   0, -10,   0,   5,   0
         , pl2ccol =   2,   1,   2,   2,   2
         , pl2min1 = 0.0,-120.,-70.,0.0, 0.0
         , pl2max1 = 0.0,15.0, 70.,0.32, 0.0
         , numcl2  =   0,   0,   0,  10                                \$
 \$pixcon   dtpix=0.0025, pixdir=3, npixi=400, npixj=400, pixmm=0
         , pixfmt=1, ppmpix=0, iflippix=1
         , pixvar='d ','Vv','wn','pb','et'
         , nlpix  =   0, -10,   0,   5,   0
         , pixpal =   2,   1,   2,   2,   2
         , pixmin =0.05,-120.,-70.,0.0,0.04
         , pixmax = 0.5,15.0, 70.,0.32, 1.0                            \$
 \$usrcon                                                               \$
 \$hdfcon                                                               \$
 \$tslcon   dttsl=0.05, dttsp=0.005                                     \$
 \$discon                                                               \$
 \$radcon                                                               \$
 \$pgen     v0=1.0                                                      \$
EOF
#============================================> MAKE the ZEUS executable.
make -f ./makezeus
#===================================================> Tidy up directory.
rm -f ./editlp ./inedit ./output ./xedit22
