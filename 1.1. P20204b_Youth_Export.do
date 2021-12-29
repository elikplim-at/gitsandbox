*quietly {

*** Youth_Export
** Cycle 1 Batch 1
** Youth Survey
* Nathan Sivewright Feb 2021

// This do-file: 
// 1. Deletes any previously exported and saved data sets - both local and on onedrive. 
// 2. Amends the exported SurveyCTO do-file(s) to include the sctoapi command to download the data from the SurveyCTO server
// 3. Amends the exported SurveyCTO do-file(s) to account for missing variables in the exported csv
// 4. Runs the SurveyCTO do-file(s) - importing the data and then labelling variables
// 4. Copies the output of the SurveyCTO do-file to the 'exported' folder


n: di "This could take a minute or two... Go and get a coffee"

***************************
**  erase files in local_path **
***************************
/*
local deletepathexp = "$scto_download\/"
local dtafiles : dir "`deletepathexp'" file "*.dta", respectcase	
local jsonfiles : dir "`deletepathexp'" file "*.json", respectcase	
local csvfiles : dir "`deletepathexp'" file "*.csv", respectcase
foreach file in `dtafiles' `jsonfiles' `csvfiles' {	
	local fileandpathtodelete = "`deletepathexp'"+"`file'"
	capture erase "`fileandpathtodelete'"
}
*/

***************************
**  erase files in export **
***************************
local deletepathexp = "$exported\/"
local files : dir "`deletepathexp'" file "*.dta", respectcase	
foreach file in `files'{	
	local fileandpathtodelete = "`deletepathexp'"+"`file'"
	capture erase "`fileandpathtodelete'"
}

***************************
**  erase files in corrections **
***************************
local deletepathclean = "$corrections\/"
local files : dir "`deletepathclean'" file "*.dta", respectcase	
foreach file in `files'{	
	local fileandpathtodelete = "`deletepathclean'"+"`file'"
	capture erase "`fileandpathtodelete'"
}


***************************
**  erase files in cleaning **
***************************
local deletepathclean = "$cleaning\/"
local files : dir "`deletepathclean'" file "*.dta", respectcase	
foreach file in `files'{	
	local fileandpathtodelete = "`deletepathclean'"+"`file'"
	capture erase "`fileandpathtodelete'"
}



***************************
**  Import Data **
***************************

clear
cd "$dofiles"

/*
local filesdo: dir "$scto_download" file "*.do", respectcase
foreach file of local filesdo{
clear all
intext using `"`file'"', gen(xx) length(1000)
replace xx1="clear all" in 2

if xx1=="**AMENDED DO-FILE" in 3 {
    di "Already amended"
}
else {
insobs 40, after(3)
}

replace xx1="**AMENDED DO-FILE" in 3
replace xx1="sctoapi Tekki_Fii_PV, server(mannheimc4ed) username(sivewright@c4ed.org) password(doormonkey) date($date) output(${scto_download}) media(textaudit)" in 4
replace xx1=`"import excel using "${qx}", clear"' in 5
replace xx1=`"levelsof B if strpos(A, "select"), l(l_question)"' in 6
replace xx1=`"foreach x of local l_question { "' in 7
replace xx1="gen "+"`"+"x"+"'"+"=." in 8
replace xx1="}" in 9

replace xx1=`"levelsof B if strpos(A, "or_other"), l(l_other)"' in 10
replace xx1=`"foreach y of local l_other { "' in 11
replace xx1="gen "+"`"+"y"+"'"+"_other"+"=." in 12
replace xx1="tostring " + "`" + "y" + "'" +"_other" + ", replace"  in 13
replace xx1="}" in 14

replace xx1=`"levelsof B if strpos(A, "trigger"), l(l_check)"' in 15
replace xx1=`"foreach w of local l_check { "' in 16
replace xx1="gen "+"`"+"w"+"'"+"_check"+"=." in 17
replace xx1="tostring " + "`" + "w" + "'" +"_check" + ", replace"  in 18
replace xx1="}" in 19

*replace xx1="gen resp_relationship_other=." in 20
*replace xx1="gen name=." in 20
replace xx1="drop A-X" in 21
replace xx1="tempfile extra_vars" in 22
replace xx1="save"+ " `"+"extra_vars"+"'" in 23

replace xx1=`"import excel using "${qx}", clear"' in 24
replace xx1=`"drop if inlist(A, "note", "begin group", "end group", "end repeat", "begin repeat", "")"' in 25
replace xx1=`"keep B"' in 26
replace xx1="drop in 1" in 27
replace xx1="sxpose, clear firstnames" in 28
replace xx1="tempfile transpose" in 29
replace xx1="save"+ " `"+"transpose"+"'" in 30

replace xx1=`"insheet using "${scto_download}\Tekki_Fii_PV_WIDE.csv", names clear"'  in 31
replace xx1="append using "+"`"+"extra_vars"+"'"+", force" in 32
replace xx1="append using "+"`"+"transpose"+"'"+", force" in 33
replace xx1=`"outsheet using "${scto_download}\Tekki_Fii_PV_WIDE.csv", replace c"' in 34

replace xx1="**END AMENDED SECTION" in 35

replace xx1=subinstr(xx1,"Tekki_Fii_PV", "Tekki_Fii_PV", 1) in 64
outfile xx1 using `"`file'"', runtogether replace
}
*/

do "1.0.1. import_Tekki_Fii_PV.do"

******************************
**Copy Files to Exported**
******************************
clear
cd "$scto_download"

local files: dir "$scto_download" file "*.dta", respectcase
foreach file of local files{
	di `"`file'"'
	copy `""$scto_download\/`file'"' `"$exported\/`file'"', replace
	}
	
n: di "${proj}_Export ran successfully"
*}

