#---+----1----+----2----+----3----+--+----3----+----2----+----1----+---#
#============== SCRIPT FILE TO CREATE THE ZEUS EXECUTABLE =============#
#                                                                      #
#          MHD boundary conditions in cylindrical coordinates          #
#                                                                      #
#  last dt=2.252435583167637E-02, nhy=76                               #
#                                                                      #
#--------------------------------> Set FORTRAN compiler and problem tag.
#  Supported compilers include:
#     cf77 (Cray), f90 (Sun), g95 (g95.org), gfortran (Gnu), ifort 
#     (Intel), pgf77 (Portland Group), xlf (IBM)
#
setenv FCOMP gfortran
setenv TAG kx
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
       parameter     (   in = 505,   jn = 255,   kn =   1 )
       parameter     ( nxpx = 800, nypx = 400, nxrd =   1, nyrd =   1 )
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
 \$rescon   dtdmp=0.0, idtag='$TAG', resfile='zr000$TAG'                \$
 \$ggen1    nbl=50, x1min=0.0, x1max=5.0, igrid=1, x1rat=1.0, lgrid=.t. \$
 \$ggen2    nbl=50, x2min=0.0, x2max=5.0, igrid=1, x2rat=1.0, lgrid=.t. \$
 \$ggen3                                                                \$
 \$pcon     nlim=999999, tlim=-4.0, ttotal=1.0e+7, tsave=10.0           \$
 \$hycon    qcon=0.0, qlin=0.0, courno=0.75, iord=2, iords=2, istp=0
         , dtrat=0.2, trnvrsn=1, itote=1                               \$
 \$iib                                                                  \$
 \$oib      noib(1: 55,1    )=9                                         \$
 \$ijb      nijb(1    ,1: 55)=1                                         \$
 \$ojb      nojb(1    ,1: 55)=9                                         \$
 \$ikb                                                                  \$
 \$okb                                                                  \$
 \$grvcon                                                               \$
 \$ambcon                                                               \$
 \$eqos     gamma=1.66666666666667                                      \$
 \$gcon                                                                 \$
 \$extcon                                                               \$
 \$pl1con   dtpl1=4.0, pl1dir=1,2,2,2, jpl1=52,1,1,1, ipl1=1,2,3,27
         , corl=1, aspect=1.0, npl1h=1, npl1v=2, norppl1=2
         , allxl=1, allyl=2, pl1ftr=1, pl1mm=0 
         , pl1xlab='|F10|z','|F10|r','|F10|r','|F10|r'
         , x1pl1mn=-0.2, x1pl1mx=5.0
         , pl1ylab='|F10|v|BF5|f','|F10|B|BF5|f'
         , pl1var ='v3','b3'
         , pl1min =-0.2e-6,-5.2e-6
         , pl1max = 5.2e-6, 0.2e-6                                     \$
 \$pl2con   dtpl2=4.0, pl2dir=3, lpl2= 1, norppl2=2, pl2ccol=2
         , pl2clin1=2
         , pl2sca1='vn','bn'                                           \$
 \$pixcon   dtpix=0.04, pixdir=3, npixi=200, npixj=200, ireflpix=0
         , pixvar=  'v3',   'b3'
         , pixmin=   0.0,-2.5e-6
         , pixmax=2.5e-6,    0.0
         , pixmm=0, x1pixmx=5.0, iflippix=1                            \$
 \$usrcon                                                               \$
 \$hdfcon                                                               \$
 \$tslcon                                                               \$
 \$crkcon                                                               \$
 \$discon                                                               \$
 \$radcon                                                               \$
 \$pgen     ri=1.0, b1am=1.0, ioro=1, nzrot=20, mainrot=1
         , v3b1=0.0, v3b2=1.0e-6, v3b3=0.0
         , b3b1=0.0, b3b2=0.0   , b3b3=0.0                             \$
EOF
#============================================> MAKE the ZEUS executable.
make -f ./makezeus
#===================================================> Tidy up directory.
rm -f ./editlp ./inedit ./output ./xedit22 ./*.a
