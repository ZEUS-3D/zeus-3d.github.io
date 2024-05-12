#---+----1----+----2----+----3----+--+----3----+----2----+----1----+---#
#============== SCRIPT FILE TO CREATE THE ZEUS EXECUTABLE =============#
#                                                                      #
#              Hydrodynamical Kelvin-Helmholtz instability             #
#                                                                      #
#  last dt=7.944371020710233E-04, nhy=11529                            #
#                                                                      #
#--------------------------------> Set FORTRAN compiler and problem tag.
#  Supported compilers include:
#     cf77 (Cray), f90 (Sun), g95 (g95.org), gfortran (Gnu), ifort 
#     (Intel), pgf77 (Portland Group), xlf (IBM)
#
setenv FCOMP gfortran
setenv TAG kq
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
       parameter     (   in =1005,   jn = 805,   kn =   1 )
       parameter     ( nxpx =1000, nypx = 500, nxrd =   1, nyrd =   1 )
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
 \$ggen1    nbl=500, x1min=-0.5, x1max=0.5, igrid=1, x1rat=1., lgrid=.t.\$
 \$ggen2    nbl=150, x2min=-10.0, x2max=-0.5, igrid=-2, dx2min=0.002
         , lgrid=.f.                                                   \$
 \$ggen2    nbl=500, x2min=-0.5, x2max=0.5, igrid=1, x2rat=1., lgrid=.f.\$
 \$ggen2    nbl=150, x2min=0.5, x2max=10, igrid=2, dx2min=0.002
         , lgrid=.t.                                                   \$
 \$ggen3                                                                \$
 \$pcon     nlim=999999, tlim=-12.0, ttotal=36000.0, tsave=12.0         \$
 \$hycon    qcon=2.0, qlin=0.2, courno=0.75, iord=2, istp=0
         , trnvrsn=1, itote=0                                          \$
 \$iib      niib(1:805,1    )=5                                         \$
 \$oib      noib(1:805,1    )=5                                         \$
 \$ijb      nijb(1    ,1:505)=2                                         \$
 \$ojb      nojb(1    ,1:505)=2                                         \$
 \$ikb                                                                  \$
 \$okb                                                                  \$
 \$grvcon                                                               \$
 \$ambcon                                                               \$
 \$eqos     gamma=1.66666666666667                                      \$
 \$gcon                                                                 \$
 \$extcon                                                               \$
 \$pl1con                                                               \$
 \$pl2con   dtpl2=2.6, pl2dir=3, pl2mm1=0, pl2ccol=0, pl2clin1=2
         , x2pl2mn=-0.15, x2pl2mx=0.15, pl2yl=1, pl2xl=0, numcl1=5
         , pl2ftr=0, pl2leg=0
         , pl2min1=-20.7, pl2max1=-17.4
         , pl2sca1= 'wn'                                               \$
 \$pixcon   dtpix=0.025, pixdir=3, npixi=500, npixj=500, x1pixmn=-0.5
         , x1pixmx=0.5, x2pixmn=-0.5 
         , x2pixmx=0.5, pixmm=2, pixfmt=1, ppmpix=0
         , pixvar= 'd ','wn'
         , nlpix =    0,    1                                          \$
 \$usrcon                                                               \$
 \$hdfcon                                                               \$
 \$tslcon   dttsp=0.1, norptsp=2                                        \$
 \$crkcon                                                               \$
 \$discon                                                               \$
 \$radcon                                                               \$
 \$pgen     ipert=2, delv1=1.0, shear=0.02, nodes=1                    \$
 \$ptcon    inodes=1, ncycles=0                                         \$
EOF
#============================================> MAKE the ZEUS executable.
make -f ./makezeus
#===================================================> Tidy up directory.
rm -f ./editlp ./inedit ./output ./xedit22 ./*.a
