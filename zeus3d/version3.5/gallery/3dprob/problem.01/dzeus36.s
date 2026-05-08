#============== SOURCE FILE TO CREATE THE ZEUS EXECUTABLE =============#
#
#                 B A :   3 - D   S E D O V   B L A S T
#
#  from Sedov, L. I., 1959, "Similarity and Dimensional Methods in 
#  Mechanics" (New York: Academic Press).
#
#  iord=2, iords=2, istp=0, qcon=1.0, qlin=0.2, courno=0.75, tlim=-0.1
#  nosymm  50**3, itote=1: nhy= 146, last dt=5.83496E-04, nreset=0 (dw)
#  octsymm 25**3, itote=1: nhy= 146, last dt=5.83496E-04, nreset=0 (dw)
#          25**3, itote=1: nhy= 146, last dt=6.58021E-04, nreset=154078 (avg)
#          25**3, itote=0: nhy= 149, last dt=1.87084E-05
#          50**3, itote=1: nhy= 475, last dt=2.26568E-04, nreset=0 (dw)
#         100**3, itote=1: nhy=1702, last dt=1.52699E-05, nreset=0 (dw)
#         200**3, itote=0: nhy=4622, last dt=8.45817E-06, nreset=0 (dw)
#         200**3, itote=1: nhy=4635, last dt=1.59006E-05, nreset=0 (dw)
#         200**3, itote=1: nhy=4623, last dt=8.77513E-06, nreset=~350M (avg)
#
#  octsymm => octal symmetry
#  nosymm  => no    symmetry (and thus 8 times the effort)
#
#  zone-centring of v and B: dw (downwind) or avg (two-point averages)
#
#  All runs are with outflow conditions v1(is) = min (0, v1(is)) and not 
#  min (0, v1(isp1)), as has been the design (why?) for 30 years.  With 
#  the latter, numerous negative pressure arise at the outflow boundaries.
#
#  nreset = the number of negative internal energies reset
#
#=======================================> Get files from home directory.
if(! -e dzeus36) cp ~dclarke/zeus/version3.6/dzeus36 .
if(! -e xedit21) cp ~dclarke/editor/xedit21 .
if(! -e checkin.o) cp ~dclarke/zeus/checkin.o .
#=======================> If necessary, create the directory "dzeus3.6".
if(! -e dzeus3.6) mkdir dzeus3.6
#----------------------------------------------> Create the change deck.
rm -f chgzeus
cat << EOF > chgzeus
*read zeus36.mac
*d par.42,43
       parameter     (   in = 205,   jn = 205,   kn = 205 )
       parameter     ( nxpx = 400, nypx = 400, nxrd = 300, nyrd = 300 )
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
          , speccopt='-g', specdk='plot2d','nmlsts','plot1d','tslplot'
          , libs='checkin.o -ldnmlst -ldsci01 -lgrfx03 -lpspl -lmfhdf 
  -ldf -ljpeg -lz -lX11 -lcgm -lncarg -lncarg_c -lncarg_gks -lncarg_ras
  -lngmath'                                                            \$
EOF
chmod 755 xedit21
./xedit21
#--------------------------------------> Create the input deck for ZEUS.
rm -f inzeus
cat << EOF > inzeus
 \$iocon    iotty=6, iolog=2                                            \$
 \$rescon   dtdmp=0.1, idtag='ba', resfile='zr000ba'                    \$
 \$ggen1    nbl=200, x1min=0.0, x1max=5.0, igrid=1, x1rat=1.0, lgrid=.t.\$
 \$ggen2    nbl=200, x2min=0.0, x2max=5.0, igrid=1, x2rat=1.0, lgrid=.t.\$
 \$ggen3    nbl=200, x3min=0.0, x3max=5.0, igrid=1, x3rat=1.0, lgrid=.t.\$
 \$pcon     nlim=100000, tlim=-0.1, ttotal=1.0e+7, tsave=10.0           \$
 \$hycon    qcon=0.0, qlin=0.2, courno=0.75, iord=2, iords=2, istp=0
         , itote=1                                                     \$
 \$iib      niib(1:205,1:205)=2                                         \$
 \$oib      noib(1:205,1:205)=9                                         \$
 \$ijb      nijb(1:205,1:205)=2                                         \$
 \$ojb      nojb(1:205,1:205)=9                                         \$
 \$ikb      nikb(1:205,1:205)=2                                         \$
 \$okb      nokb(1:205,1:205)=9                                         \$
 \$grvcon                                                               \$ 
 \$eqos     gamma=1.66666666666667                                      \$
 \$gcon                                                                 \$
 \$extcon   istretch=3,12,5,5, jstretch=3,12,5,5, kstretch=3,12,5,5     \$
 \$plt1con  dtplt1=0.01, iplt1mm=0
         , iplt1dir=1,2,3, iplt1=1,3,3, jplt1=3,1,3, kplt1=3,3,1
         , corl=1, np1h=2, np1v=2, norpp1=2, allxl=1
         , plt1var= 'd ', 'v ', 'p ', 'u1'
         , plt1min=  0.0,  0.0,  0.0, 10.0
         , plt1max=  4.0,  0.0,  0.0,3.0e5
         , nlplt1 =    1,    1,    1,    2                             \$
 \$plt2con  dtplt2=0.01, iplt2dir=1,2,3, lplt2=3,3,3
         , ireflp2=1,1,1, jreflp2=1,1,1
         , norpp2=2, dxvec=0.5, dyvec=0.5, ip2hdr=0, ip2ftr=0
         , plt2var='dv','m ','p ','u1'
         , pscolr=   -1,  -1,  -1,  -1
         , numcl =  100, 100, 100, 100
         , ngplt2=    1,   1,   1,  20                                 \$
 \$pixcon   ipixdir=1,2,3, dtpix=0.0005, lpix=3,3,3, ireflpx=1,1,1
         , jreflpx=1,1,1, npi=200, npj=200, ipixmm=0
         , pixvar= 'd ', 'v ', 'p ', 'u1'
         , nlpix =  100,    1,10000, 1000
         , pixmin= 0.01,  0.0, 70.0,100.0
         , pixmax=  4.0, 14.0,1.0e4,4.0e4                              \$
 \$voxcon                                                               \$
 \$usrcon                                                               \$
 \$hdfcon   dthdf=0.01, hdfvar='to'                                     \$
 \$tslcon   dttsl=0.01, dttslp=0.001, norptsl=2                         \$
 \$discon                                                               \$
 \$radcon   dtrad=0.0005, thetamin=-100.0, dtheta=0.5, phimin=-100.0
         , dphi=0.5, units='dg', itype=0, iradmm=1, iradbox=1
         , radvar= 'D ', 'VV', 'E1', 'U1'
         , nlrad =    0,    0,    0,    0
         , radmin=  0.0,  0.0,  0.0,  0.0
         , radmax=  0.0,  0.0,  0.0,  0.0                              \$
 \$pgen     r=0.0875, d0=1.0, p0=1.0e-5, d1=1.0, nrg=1.0e5, symm=8.0    \$
EOF
#============================================> MAKE the ZEUS executable.
make -f makezeus
#===================================================> Tidy up directory.
rm -f editlp inedit output xedit21
