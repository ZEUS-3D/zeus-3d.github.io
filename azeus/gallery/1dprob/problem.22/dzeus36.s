#---+----1----+----2----+----3----+--+----3----+----2----+----1----+---#
#============== SCRIPT FILE TO CREATE THE ZEUS EXECUTABLE =============#
#                                                                      #
#                          Falle (2002) Fig 6                          #
#                                                                      #
#  last dt=2.281870611105469E-05, nhy=2237                             #
#                                                                      #
#--------------------------------> Set FORTRAN compiler and problem tag.
#  Supported compilers include:
#     cf77 (Cray), f90 (Sun), g95 (g95.org), gfortran (Gnu), ifort 
#     (Intel), pgf77 (Portland Group), xlf (IBM)
#
setenv FCOMP gfortran
setenv TAG xu
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
 \$ggen1    nbl=1000,x1min=0.0, x1max=1.0, igrid=1, x1rat=1.0, lgrid=.t.\$
 \$ggen2                                                                \$
 \$ggen3                                                                \$
 \$pcon     nlim= 999999, tlim=-0.06, ttotal=900.0, tsave=10.0          \$
 \$hycon    qcon=2.0, qlin=0.2, courno=0.75, iord=2, iords=2, istp=0
         , trnvrsn=1, itote=1                                          \$
 \$iib      niib(1,1)=9                                                 \$
 \$oib      noib(1,1)=9                                                 \$
 \$ijb                                                                  \$
 \$ojb                                                                  \$
 \$ikb                                                                  \$
 \$okb                                                                  \$
 \$grvcon                                                               \$
 \$ambcon                                                               \$
 \$eqos     gamma=1.66666666666667                                      \$
 \$gcon                                                                 \$
 \$extcon                                                               \$
 \$pl1con   dtpl1=0.06, pl1dir=1, corl=1, aspect=0.9, npl1h=3, npl1v=3
         , norppl1=2, pl1ftr=1, allxl=1, pl1soln=9*1
         , pl1var= 'd ', 'p1', 'et', 'v1', 'v2', 'v3', 'b2', 'b3'
                 , 'ps'                                                \$
c \$pl1con   dtpl1=0.06, pl1dir=1, corl=1, aspect=0.9, npl1h=1, npl1v=1
c         , norppl1=2, pl1ftr=1, allxl=1, allyl=0, pl1hdr=0, pl1soln=1
c         , pl1var= 'd '                                                \$
 \$pl2con                                                               \$
 \$pixcon                                                               \$
 \$usrcon                                                               \$
 \$hdfcon                                                               \$
 \$tslcon                                                               \$
 \$crkcon                                                               \$
 \$discon                                                               \$
 \$radcon                                                               \$
 \$pgen     idirect=1, n0=500, d0=0.5, v10=0.0, v20=2.0, v30=0.0
         , b20=2.5, b30=0.0, e10=15.0, b10=2.0                         \$
 \$pgen     idirect=1, n0=500, d0=0.1, v10=-10.0, v20=0.0, v30=0.0
         , b20=2.0, b30=0.0, e10=0.15, b10=2.0                         \$
EOF
#============================================> MAKE the ZEUS executable.
make -f ./makezeus
#===================================================> Tidy up directory.
rm -f ./editlp ./inedit ./output ./xedit22 ./*.a
