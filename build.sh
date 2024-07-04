# Inspired by: https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=cewe-fotobuch

# to package a different version, change this line to _productVariant=<one of the words after '_prams_' below>
# or download a setup file from a local CEWE site, put it in the same folder as this file, and run:
# _SETUP_FILE=<filename> makepkg
_productVariant=DM_DE

declare -g -A _scriptTailMd5sums
_scriptTailMd5sums[7.1]=1b231f3988603dbec4e857e247784295
_scriptTailMd5sums[7.2]=d9edd2bb89870dc61692e73f81fe0efa
_scriptTailMd5sums[7.3]=8cf896344365958462902bfb340201cd

# locale, key account, original name, download url suffix, version, (optional) replacement name
_prams_Fotobuch=(de_DE 16523 'Mein CEWE FOTOBUCH' 'setup_Mein_CEWE_FOTOBUCH.tgz' 7.3.1 'CEWE Fotobuch')
_prams_Austria=(de_AT 29762  'CEWE Fotowelt' 'CEWE Fotowelt' 7.1.4)
_prams_Belgie=(nl_BE 28049 'CEWE Photoservice' 'CEWE Photoservice' 7.1.4)
_prams_Belgique=(fr_BE 28049 'CEWE Photoservice' 'CEWE Photoservice' 7.1.4)
_prams_Czechia=(cs_CZ 4860 'CEWE FOTOLAB fotosvet' 'CEWE FOTOLAB fotosvet' 7.1.3 "CEWE fotosvět")
_prams_France=(fr_FR 7884 'Logiciel de création CEWE' 'Logiciel de création CEWE' 7.1.5)
_prams_Fnac=(fr_FR 18455 'Atelier Photo Fnac' 'Atelier Photo Fnac' 7.1.3)
_prams_Germany=(de_DE 24441 'CEWE Fotowelt' 'CEWE Fotowelt' 7.3.1)
_prams_Italy=(it_IT 19991 'CEWE.IT Foto World' 'CEWE.IT Foto World' 7.1.5)
_prams_Luxemburg=(de_LU 32905 'CEWE Photoservice' 'CEWE Photoservice' 7.1.5)
_prams_Luxembourg=(fr_LU 32905 'CEWE Photoservice' 'CEWE Photoservice' 7.1.4)
_prams_Netherlands=(nl_NL 28035 'CEWE Fotoservice' 'CEWE Fotoservice' 7.1.4)
_prams_Poland=(pl_PL 29241 'CEWE Fotoswiat' 'CEWE Fotoswiat' 7.1.4 'CEWE Fotoświat')
_prams_Slovakia=(sk_SK 31916 'CEWE fotosvet' 'CEWE fotosvet' 7.1.3)
_prams_Slovenia=(sl_SI 17409 'CEWE Fotosvet' 'CEWE Fotosvet' 7.1.5)
_prams_Spain=(es_ES 29227 'Taller CEWE' 'Taller CEWE' 7.1.3)
_prams_UK=(en_GB 12611 'CEWE Creator' 'CEWE Creator' 7.1.3)
# DM
_prams_DM_DE=(de_DE 1230 'Fotoparadies' 'x_x_x_x_1320_x_01320-1D8yb69q7Wl6o/linux')
# Rossmann
_prams_Rossmann_DE=(de_DE 30400 'Rossmann' 'ref_sem_yah_K14832970-VT!1210562649500483!kwd-75660379415115!!!c_30400_x_30400-NEqODQFOYxUy7/linux')


declare -n _prams=_prams_$_productVariant
id="com.cewe.${_productVariant}"
echo "Building for $id"
sed "s|@id@|$id|" com.cewe.cewefotobuch.yml.conf > $id.yml
sed -i "s|@command@|cewefotobuch_${_prams[0]}_${_prams[1]}|" $id.yml

# For testing hardcode it
url="https://dls.photoprintit.com/api/getClient/1320-de_DE/hps/x_x_x_x_1320_x_01320-1D8yb69q7Wl6o/linux"
sed -i "s|@source_url@|$url|" $id.yml

wget -O linux.tgz $url
tar xf linux.tgz
perl ./install --update --keepPackages --installdir=/tmp --workingDir=downloadedFiles

sha256_number='15c5b036c05c123727b4358b5eb557c5439b841843cf0c09ca24a2f0814f2338'
sed -i "s|@sha256_number@|$sha256_number|" $id.yml


flatpak-builder --verbose --force-clean --repo="${id}REPO" build $id.yml
