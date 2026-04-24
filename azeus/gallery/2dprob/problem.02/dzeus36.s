#---+----1----+----2----+----3----+--+----3----+----2----+----1----+---#
#============== SCRIPT FILE TO CREATE THE ZEUS EXECUTABLE =============#
#                                                                      #
#                        2-D Shear Alfven waves                        #
#                                                                      #
#  last dt=1.184072921305187E-03, nhy=693                              #
#                                                                      #
#--------------------------------> Set FORTRAN compiler and problem tag.
#  Supported compilers include:
#     cf77 (Cray), f90 (Sun), g95 (g95.org), gfortran (Gnu), ifort 
#     (Intel), pgf77 (Portland Group), xlf (IBM)
#
setenv FCOMP gfortran
setenv TAG kb
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
       parameter     (   in = 205,   jn = 205,   kn =   1 )
       parameter     ( nxpx = 300, nypx = 300, nxrd =   1, nyrd =   1 )
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
 \$ggen1    nbl=100, x1min=-.25, x1max=.25, igrid=1, x1rat=1., lgrid=.t.\$
 \$ggen2    nbl=100, x2min=-.25, x2max=.25, igrid=1, x2rat=1., lgrid=.t.\$
 \$ggen3                                                                \$
 \$pcon     nlim= 999999, tlim=-1.0, ttotal=2000.0, tsave=10.0          \$
 \$hycon    qcon=0.0, qlin=0.0, courno=0.5, iord=2, istp=0
c \$hycon    qcon=0.0, qlin=0.0, courno=1.7320508, iord=2, istp=0
         , dtrat=0.2, trnvrsn=1, itote=1                               \$
 \$iib      niib(1:105,1    )=5                                         \$
 \$oib      noib(1:105,1    )=5                                         \$
 \$ijb      nijb(1    ,1:105)=5                                         \$
 \$ojb      nojb(1    ,1:105)=5                                         \$
 \$ikb                                                                  \$
 \$okb                                                                  \$
 \$grvcon                                                               \$
 \$ambcon                                                               \$
 \$eqos                                                                 \$
 \$gcon                                                                 \$
 \$extcon                                                               \$
 \$pl1con                                                               \$
 \$pl2con   pl2dir=3, dtpl2=1.0, norppl2=2, pl2xl=1, pl2yl=1, pl2ftr=1
         , pl2ccol=2, pl2leg=1 
         , pl2sca1='vn','bn'                                           \$
 \$pixcon   dtpix=0.004, pixdir=3, npixi=300, npixj=300, pixmm=2
         , pixfmt=1, ppmpix=0, iflippix=1
         , pixvar='vn','bn'                                            \$
 \$usrcon                                                               \$
 \$hdfcon                                                               \$
 \$tslcon                                                               \$
 \$crkcon                                                               \$
 \$discon                                                               \$
 \$radcon                                                               \$
 \$pgen      nbox=2
         , ibot=   1,  33, jbot=   1,  33
         , itop= 104,  72, jtop= 104,  72
         , dbox= 1.0, 1.0, e1box=0.9, 0.9
         , v3box=0.0,.001, v1box=0.0, 0.0
         , v2box=0.0, 0.0, b3box=0.0, 0.0
         , b1box=1.0, 1.0, b2box=1.0, 1.0                              \$
EOF
#============================================> MAKE the ZEUS executable.
make -f ./makezeus
#===================================================> Tidy up directory.
rm -f ./editlp ./inedit ./output ./xedit22
