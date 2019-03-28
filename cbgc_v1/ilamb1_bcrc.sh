#!/bin/bash -l
#SBATCH --job-name=ilamb1_bcrc
#SBATCH --partition=regular
#SBATCH --qos=premium
#SBATCH --account=acme
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --exclusive
#SBATCH --mail-type=all
#SBATCH --mail-user=jinyuntang@lbl.gov

module load nco

export modeldir=/global/cscratch1/sd/jinyun/acme_scratch/edison/CBGC/20190309.BCRC_CNPECACNT_20TR.ne30_oECv3.edison/run
#export modeldir=/global/cscratch1/sd/qzhu/acme_scratch/edison/CBGC/
#export outdir=/global/cscratch1/sd/qzhu/acme_scratch/edison/ILAMB/glb_tr1/
export outdir=/global/cscratch1/sd/jinyun/CBGC_v1/data_postprocess/bcrc

rm -rf ${outdir}/*
mkdir -p ${outdir}
cd ${modeldir}

#ncrcat -v GPP,NPP,NEP,cn_scalar,cp_scalar,FPI,FPI_P,FPG,FPG_P,PCT_NAT_PFT,F_N2O_DENIT,SMIN_NO3_LEACHED,LEAFC,LEAFN,LEAFP,TOTVEGC,TOTVEGN,TOTVEGP,NFIX_TO_SMINN,SMINN_TO_PLANT,ACTUAL_IMMOB,GROSS_NMIN,SMINP_TO_PLANT,ACTUAL_IMMOB_P,GROSS_PMIN,TOTLITC,CWDC ALMv1.nc ECAr17.1.GOLUM.nc

mkdir -p ${outdir}/gpp
ncrcat -v GPP *clm2.h0.*.nc ${outdir}/gpp/gpp_ALMv1_ECA_CNP_historical.nc 
ncatted -O -a units,GPP,m,c,"g m-2 s-1"  ${outdir}/gpp/gpp_ALMv1_ECA_CNP_historical.nc
ncrename -v GPP,gpp ${outdir}/gpp/gpp_ALMv1_ECA_CNP_historical.nc

mkdir -p ${outdir}/npp
ncrcat -v NPP *clm2.h0.*.nc ${outdir}/npp/npp_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,NPP,m,c,"g m-2 s-1"  ${outdir}/npp/npp_ALMv1_ECA_CNP_historical.nc
ncrename -v NPP,npp ${outdir}/npp/npp_ALMv1_ECA_CNP_historical.nc

mkdir -p ${outdir}/nbp
ncrcat -v NBP *clm2.h0.*.nc ${outdir}/nbp/nbp_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,NBP,m,c,"g m-2 s-1"  ${outdir}/nbp/nbp_ALMv1_ECA_CNP_historical.nc
ncrename -v NBP,nbp ${outdir}/nbp/nbp_ALMv1_ECA_CNP_historical.nc


mkdir -p ${outdir}/tas
ncrcat -v TSA *clm2.h0.*.nc ${outdir}/tas/tas_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,TSA,m,c,"K"  ${outdir}/tas/tas_ALMv1_ECA_CNP_historical.nc
ncrename -v TSA,tas ${outdir}/tas/tas_ALMv1_ECA_CNP_historical.nc


mkdir -p ${outdir}/cVeg
ncrcat -v TOTVEGC *clm2.h0.*.nc ${outdir}/cVeg/cVeg_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,TOTVEGC,m,c,"g m-2"  ${outdir}/cVeg/cVeg_ALMv1_ECA_CNP_historical.nc
ncrename -v TOTVEGC,cVeg ${outdir}/cVeg/cVeg_ALMv1_ECA_CNP_historical.nc

mkdir -p ${outdir}/cSoil
ncrcat -v TOTSOMC_1m *clm2.h0.*.nc ${outdir}/cSoil/cSoil_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,TOTSOMC_1m,m,c,"g m-2"  ${outdir}/cSoil/cSoil_ALMv1_ECA_CNP_historical.nc
ncrename -v TOTSOMC_1m,cSoil ${outdir}/cSoil/cSoil_ALMv1_ECA_CNP_historical.nc

mkdir -p ${outdir}/rain
ncrcat -v RAIN *clm2.h0.*.nc ${outdir}/rain/rain_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,RAIN,m,c,"kg m-2 s-1"  ${outdir}/rain/rain_ALMv1_ECA_CNP_historical.nc

mkdir -p ${outdir}/snow
ncrcat -v SNOW *clm2.h0.*.nc ${outdir}/snow/snow_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,SNOW,m,c,"kg m-2 s-1"  ${outdir}/snow/snow_ALMv1_ECA_CNP_historical.nc

mkdir -p ${outdir}/burntArea
ncrcat -v FAREA_BURNED *clm2.h0.*.nc ${outdir}/burntArea/BurntArea_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,FAREA_BURNED,m,c,"%"  ${outdir}/burntArea/BurntArea_ALMv1_ECA_CNP_historical.nc
ncap2 -s "burntArea=FAREA_BURNED*3600*24*30*100" ${outdir}/burntArea/BurntArea_ALMv1_ECA_CNP_historical.nc ${outdir}/burntArea/BurntArea1_ALMv1_ECA_CNP_historical.nc
ncks -v burntArea ${outdir}/burntArea/BurntArea1_ALMv1_ECA_CNP_historical.nc ${outdir}/burntArea/burntArea_ALMv1_ECA_CNP_historical.nc
rm ${outdir}/burntArea/BurntArea_ALMv1_ECA_CNP_historical.nc
rm ${outdir}/burntArea/BurntArea1_ALMv1_ECA_CNP_historical.nc

mkdir -p ${outdir}/ra
ncrcat -v AR *clm2.h0.*.nc ${outdir}/ra/ra_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,AR,m,c,"g m-2 s-1"  ${outdir}/ra/ra_ALMv1_ECA_CNP_historical.nc
ncrename -v AR,ra ${outdir}/ra/ra_ALMv1_ECA_CNP_historical.nc

mkdir -p ${outdir}/rh
ncrcat -v HR *clm2.h0.*.nc ${outdir}/rh/rh_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,HR,m,c,"g m-2 s-1"  ${outdir}/rh/rh_ALMv1_ECA_CNP_historical.nc
ncrename -v HR,rh ${outdir}/rh/rh_ALMv1_ECA_CNP_historical.nc

mkdir -p ${outdir}/lai
ncrcat -v TLAI *clm2.h0.*.nc ${outdir}/lai/lai_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,TLAI,m,c,"1"  ${outdir}/lai/lai_ALMv1_ECA_CNP_historical.nc
ncrename -v TLAI,lai ${outdir}/lai/lai_ALMv1_ECA_CNP_historical.nc

# EFLX_LH_TOT -> EFLX_LH_TOT_R # latent heat flux
mkdir -p ${outdir}/hfls
ncrcat -v EFLX_LH_TOT *clm2.h0.*.nc ${outdir}/hfls/hfls_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,EFLX_LH_TOT,m,c,"W m-2"  ${outdir}/hfls/hfls_ALMv1_ECA_CNP_historical.nc
ncrename -v EFLX_LH_TOT,hfls ${outdir}/hfls/hfls_ALMv1_ECA_CNP_historical.nc

# FSH -> FSH_R # sensible heat flux
mkdir -p ${outdir}/hfss
ncrcat -v FSH *clm2.h0.*.nc ${outdir}/hfss/hfss_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,FSH,m,c,"W m-2"  ${outdir}/hfss/hfss_ALMv1_ECA_CNP_historical.nc
ncrename -v FSH,hfss ${outdir}/hfss/hfss_ALMv1_ECA_CNP_historical.nc

mkdir -p ${outdir}/ps
ncrcat -v PBOT *clm2.h0.*.nc ${outdir}/ps/ps_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,PBOT,m,c,"Pa"  ${outdir}/ps/ps_ALMv1_ECA_CNP_historical.nc
ncrename -v PBOT,ps ${outdir}/ps/ps_ALMv1_ECA_CNP_historical.nc

 # FIRE -> FIRE_R # emitted longwave radiation
 mkdir -p ${outdir}/rlus
ncrcat -v FIRE *clm2.h0.*.nc ${outdir}/rlus/rlus_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,FIRE,m,c,"W m-2"  ${outdir}/rlus/rlus_ALMv1_ECA_CNP_historical.nc
ncrename -v FIRE,rlus ${outdir}/rlus/rlus_ALMv1_ECA_CNP_historical.nc

# FLDS # atmospheric longwave radiation
mkdir -p ${outdir}/rlds
ncrcat -v FLDS *clm2.h0.*.nc ${outdir}/rlds/rlds_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,FLDS,m,c,"W m-2"  ${outdir}/rlds/rlds_ALMv1_ECA_CNP_historical.nc
ncrename -v FLDS,rlds ${outdir}/rlds/rlds_ALMv1_ECA_CNP_historical.nc

# FSR # reflected solar radiation
# FSRND # direct nir reflected solar radiation
# FSRNI # diffuse nir reflected solar radiation
# FSRVD # direct vis reflected solar radiation
# FSRVI # diffuse vis reflected solar radiation
mkdir -p ${outdir}/rsus
ncrcat -v FSR *clm2.h0.*.nc ${outdir}/rsus/rsus_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,FSR,m,c,"W m-2"  ${outdir}/rsus/rsus_ALMv1_ECA_CNP_historical.nc
ncrename -v FSR,rsus ${outdir}/rsus/rsus_ALMv1_ECA_CNP_historical.nc
#ncrcat -v FSRND ALMv1.nc ${outdir}/rsus_others/FSRND_ALMv1_ECA_CNP_historical.nc
#ncrcat -v FSRNI ALMv1.nc ${outdir}/rsus_others/FSRNI_ALMv1_ECA_CNP_historical.nc
#ncrcat -v FSRVD ALMv1.nc ${outdir}/rsus_others/FSRVD_ALMv1_ECA_CNP_historical.nc
#ncrcat -v FSRVI ALMv1.nc ${outdir}/rsus_others/FSRVI_ALMv1_ECA_CNP_historical.nc

# FSDS # atmospheric incident solar radiation
# FSDSND # direct nir incident solar radiation
# FSDSNI # diffuse nir incident solar radiation
# FSDSVD # direct vis incident solar radiation
# FSDSVI # diffuse vis incident solar radiation
mkdir -p ${outdir}/rsds
ncrcat -v FSDS *clm2.h0.*.nc ${outdir}/rsds/rsds_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,FSDS,m,c,"W m-2"  ${outdir}/rsds/rsds_ALMv1_ECA_CNP_historical.nc
ncrename -v FSDS,rsds ${outdir}/rsds/rsds_ALMv1_ECA_CNP_historical.nc
#ncrcat -v FSDSND ALMv1.nc ${outdir}/rsds_others/FSDSND_ALMv1_ECA_CNP_historical.nc
#ncrcat -v FSDSNI ALMv1.nc ${outdir}/rsds_others/FSDSNI_ALMv1_ECA_CNP_historical.nc
#ncrcat -v FSDSVD ALMv1.nc ${outdir}/rsds_others/FSDSVD_ALMv1_ECA_CNP_historical.nc
#ncrcat -v FSDSVI ALMv1.nc ${outdir}/rsds_others/FSDSVI_ALMv1_ECA_CNP_historical.nc

#mkdir -p ${outdir}/sftlf
#ncrcat -v PCT_LANDUNIT ALMv1.nc ${outdir}/sftlf/sftlf_ALMv1_ECA_CNP_historical.nc
#ncatted -O -a units,PCT_LANDUNIT,m,c,"%"  ${outdir}/sftlf/sftlf_ALMv1_ECA_CNP_historical.nc
#ncrename -v PCT_LANDUNIT,sftlf ${outdir}/sftlf/sftlf_ALMv1_ECA_CNP_historical.nc


mkdir -p ${outdir}/tws
ncrcat -v TWS *clm2.h0.*.nc ${outdir}/tws/tws_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,TWS,m,c,"mm"  ${outdir}/tws/tws_ALMv1_ECA_CNP_historical.nc
ncrename -v TWS,tws  ${outdir}/tws/tws_ALMv1_ECA_CNP_historical.nc

mkdir -p ${outdir}/qsoil
ncrcat -v QSOIL *clm2.h0.*.nc ${outdir}/qsoil/qsoil_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,QSOIL,m,c,"kg m-2 s-1"  ${outdir}/qsoil/qsoil_ALMv1_ECA_CNP_historical.nc

mkdir -p ${outdir}/qvege
ncrcat -v QVEGE *clm2.h0.*.nc ${outdir}/qvege/qvege_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,QVEGE,m,c,"kg m-2 s-1"  ${outdir}/qvege/qvege_ALMv1_ECA_CNP_historical.nc

mkdir -p ${outdir}/qvegt
ncrcat -v QVEGT *clm2.h0.*.nc ${outdir}/qvegt/qvegt_ALMv1_ECA_CNP_historical.nc
ncatted -O -a units,QVEGT,m,c,"kg m-2 s-1"  ${outdir}/qvegt/qvegt_ALMv1_ECA_CNP_historical.nc

mkdir -p ${outdir}/et
cp ${outdir}/qsoil/qsoil_ALMv1_ECA_CNP_historical.nc ${outdir}/et/ets_ALMv1_ECA_CNP_historical.nc
ncks -A ${outdir}/qvegt/qvegt_ALMv1_ECA_CNP_historical.nc ${outdir}/et/ets_ALMv1_ECA_CNP_historical.nc
ncks -A ${outdir}/qvege/qvege_ALMv1_ECA_CNP_historical.nc ${outdir}/et/ets_ALMv1_ECA_CNP_historical.nc
ncap2 -s 'et=QSOIL+QVEGE+QVEGT' ${outdir}/et/ets_ALMv1_ECA_CNP_historical.nc ${outdir}/et/et_new_ALMv1_ECA_CNP_historical.nc
ncks -v et ${outdir}/et/et_new_ALMv1_ECA_CNP_historical.nc ${outdir}/et/et_ALMv1_ECA_CNP_historical.nc
ncatted -O -a long_name,et,o,c,"evapotranspiration" ${outdir}/et/et_ALMv1_ECA_CNP_historical.nc
rm ${outdir}/et/ets_ALMv1_ECA_CNP_historical.nc
rm ${outdir}/et/et_new_ALMv1_ECA_CNP_historical.nc

mkdir -p ${outdir}/pr
cp ${outdir}/rain/rain_ALMv1_ECA_CNP_historical.nc ${outdir}/pr/rain_snow_ALMv1_ECA_CNP_historical.nc
ncks -A ${outdir}/snow/snow_ALMv1_ECA_CNP_historical.nc ${outdir}/pr/rain_snow_ALMv1_ECA_CNP_historical.nc
ncap2 -s 'pr=RAIN+SNOW' ${outdir}/pr/rain_snow_ALMv1_ECA_CNP_historical.nc ${outdir}/pr/pr_new_ALMv1_ECA_CNP_historical.nc
ncks -v pr ${outdir}/pr/pr_new_ALMv1_ECA_CNP_historical.nc ${outdir}/pr/pr_ALMv1_ECA_CNP_historical.nc
ncatted -O -a long_name,pr,o,c,"precipitation" ${outdir}/pr/pr_ALMv1_ECA_CNP_historical.nc
rm ${outdir}/pr/rain_snow_ALMv1_ECA_CNP_historical.nc
rm ${outdir}/pr/pr_new_ALMv1_ECA_CNP_historical.nc

mkdir -p ${outdir}/btran
ncrcat -v BTRAN  *clm2.h0.* ${outdir}/btran/btran_ALMv1_ECA_CNP_historical.nc

