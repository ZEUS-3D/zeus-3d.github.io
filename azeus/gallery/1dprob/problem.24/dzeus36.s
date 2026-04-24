#---+----1----+----2----+----3----+--+----3----+----2----+----1----+---#
#============== SCRIPT FILE TO CREATE THE ZEUS EXECUTABLE =============#
#                                                                      #
#               Ambipolar diffusion C-shock (isothermal)               #
#                                                                      #
#  last dt=1.042980345153148E-03, nhy=2775                             #
#                                                                      #
#--------------------------------> Set FORTRAN compiler and problem tag.
#  Supported compilers include:
#     cf77 (Cray), f90 (Sun), g95 (g95.org), gfortran (Gnu), ifort 
#     (Intel), pgf77 (Portland Group), xlf (IBM)
#
setenv FCOMP gfortran
setenv TAG da
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
       parameter     (   in =8197,   jn =   1,   kn =   1 )
       parameter     ( nxpx =   1, nypx =   1, nxrd =   1, nyrd =   1 )
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
 \$ggen1    nbl=150, x1min=0.0, x1max=1.5, igrid=1, x1rat=1.0, lgrid=.t.\$
 \$ggen2                                                                \$
 \$ggen3                                                                \$
 \$pcon     nlim=9999999, tlim=-4.0, ttotal=900.0, tsave=10.0         \$
 \$hycon    qcon=1.0, qlin=0.2, courno=0.75, iord=2, iords=2, istp=0
         , trnvrsn=1, itote=0                                          \$
 \$iib                                                                  \$
 \$oib                                                                  \$
 \$ijb                                                                  \$
 \$ojb                                                                  \$
 \$ikb                                                                  \$
 \$okb                                                                  \$
 \$grvcon                                                               \$
 \$ambcon   iscyad=2, gammaad=1.0e6, mpnp=1.0, ioncnst=1, dscale=1.0e-5 \$
 \$eqos     ciso=0.1                                                    \$
 \$gcon                                                                 \$
 \$extcon                                                               \$
 \$pl1con   dtpl1=4.0, pl1dir=1, corl=1, aspect=0.9, npl1h=3, npl1v=3
         , pl1ftr=1, allxl=1, allyl=2, x1pl1mx=1.25
         , pl1var='d ','p ','et','v1','v2','mA','b2','bd','bt'
         , pl1soln=  1,   1,   1,   1,   1,   1,   1,   1,   1         \$
 \$pl2con                                                               \$
 \$pixcon                                                               \$
 \$usrcon                                                               \$
 \$hdfcon                                                               \$
 \$tslcon                                                               \$
 \$crkcon                                                               \$
 \$discon                                                               \$
 \$radcon                                                               \$
 \$pgen     idirect=1, n0= 50  , b10=0.7071, b30=0.0
         , d0=1.000, p10=0.01  , v10=5.0   , v20=0.0  , b20=0.7071     \$
 \$pgen     idirect=1, n0=100  , b10=0.7071, b30=0.0
         , d0=8.045, p10=0.0804, v10=0.621 , v20=0.840, b20=6.644      \$
EOF
#============================================> MAKE the ZEUS executable.
make -f ./makezeus
#===================================================> Tidy up directory.
rm -f ./editlp ./inedit ./output ./xedit22 ./*.a
