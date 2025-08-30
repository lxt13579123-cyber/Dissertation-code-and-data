clear
use Clean.dta
encode secu_code,gen(id)
xtset id year
gen Post=(year>=treat_year)
replace Post=1 if year>=2017 & treat_year==.
egen GreenCity=mean(treat_year),by(citycode)
replace GreenCity=(GreenCity!=.)
gen Treated=GreenCity*Post
gen ind=substr(sic_code,1,1)
gen CarbonIntensive=(ind=="B" | sic_code=="C20" | sic_code=="C21" | sic_code=="C22" | sic_code=="C25" | sic_code=="C26" | (sic_code!="D46" & ind=="D") | ind=="E")
gen lnSize=ln(Size)
gen lnGDPpc=ln(GDPpc)
gen lnPopDensity=ln(PopDensity)
replace GDPpc=GDPpc/10^3 

sum2docx ROA GPnum Size Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 GDPpc PopDensity FinCapacity Openness Sec3Rate using sum.docx,replace stats(mean sd min p25 median p75 max skewness kurtosis)
corr2docx ROA GPnum Size Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 GDPpc PopDensity FinCapacity Openness Sec3Rate using corr.docx,replace

xtreg ROA Post GreenCity Treated,re
est store r1
xtreg ROA Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5,re
est store r2
xtreg ROA Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate,re
est store r3
xtreg ROA Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate i.year,re
est store r4
xtreg ROA Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate i.year i.citycode,re
est store r5
xtreg ROA Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate i.year i.citycode,fe
est store r6
esttab _all using ROA_baseline.rtf,se(a2) b(a2) replace nogap compress keep(Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate _cons) star(* 0.1 ** 0.05 *** 0.01)

xtreg GPnum Post GreenCity Treated,re
est store r1
xtreg GPnum Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5,re
est store r2
xtreg GPnum Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate,re
est store r3
xtreg GPnum Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate i.year,re
est store r4
xtreg GPnum Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate i.year i.citycode,re
est store r5
xtreg GPnum Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate i.year i.citycode,fe
est store r6
esttab _all using GPnum_baseline.rtf,se(a2) b(a2) replace nogap compress keep(Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate _cons) star(* 0.1 ** 0.05 *** 0.01)

est clear
xtreg ROA Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate i.year i.citycode if SOE,fe
est store r1
xtreg GPnum Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate i.year i.citycode if SOE,fe
est store r2
xtreg ROA Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate i.year i.citycode if SOE==0,fe
est store r3
xtreg GPnum Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate i.year i.citycode if SOE==0,fe
est store r4
esttab _all using Ownership_Heterogeneity.rtf,se(a2) b(a2) replace nogap compress keep(Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate _cons) star(* 0.1 ** 0.05 *** 0.01)

est clear
xtreg ROA Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate i.year i.citycode if CarbonIntensive,fe
est store r1
xtreg GPnum Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate i.year i.citycode if CarbonIntensive,fe
est store r2
xtreg ROA Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate i.year i.citycode if CarbonIntensive==0,fe
est store r3
xtreg GPnum Post GreenCity Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate i.year i.citycode if CarbonIntensive==0,fe
est store r4
esttab _all using IndustrialSector_Heterogeneity.rtf,se(a2) b(a2) replace nogap compress keep(Treated lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate _cons) star(* 0.1 ** 0.05 *** 0.01)

gen time=year-treat_year
replace time=100 if time==.
tab time, gen(evt)
drop evt32
forvalues i=1/31{
	gen evt`i'_did=evt`i'*treat
	drop evt`i'
}
drop evt18_did

xtreg GPnum evt* lnSize Tangibility Leverage SalesGrowth AssetTurnover Duality NED HHI5 GP0 lnGDPpc lnPopDensity FinCapacity Openness Sec3Rate i.year i.citycode,fe


gen time=_n-17
gen lower_ci = coef - 1.96 * se
gen upper_ci = coef + 1.96 * se
twoway (rcap lower_ci upper_ci time, color(lightblue)) (scatter coef time, msymbol(o) mcolor(black)) if abs(time)<=15, ///
   ytitle("Coefficient") xtitle("Event Time") xlab(-15(5)15) legend(off)



