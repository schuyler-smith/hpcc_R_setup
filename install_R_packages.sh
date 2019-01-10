#!/bin/bash
SCRIPTPATH=`dirname $0`
usage(){
cat << EOF

USAGE: sh install_R_packages.sh -b/g/u [package_name] ... 

REQUIRED:
		must have a least 1 package name given to run the script.

OPTIONS:
	-b 	specify the package(s) is hosted on the bioconductor server and not Cran.
	-g  specify the package(s) is hosted on github and not Cran.
    -u  updates all CRAN packages in specified library

EOF
}
while getopts ":hbgu" OPTION; do
     case $OPTION in
         h)
            usage
            exit 1
            ;;
         b)
			BIO=bioc_packages
            ;;
         g)
			GIT=github_packages
            ;;
         u)
            UPDATE=update_packages
            ;;            
         :)
			echo "Option -$OPTARG requires an argument." >&2
      		exit 1
			;;
         ?) echo "Invalid option: -$OPTARG\\nUse \"sh $0 -h\" to see usage and list of legal arguments." >&2
            exit 1
            ;;
     esac
done
shift $((OPTIND -1))

if [ -z ${R_LIBS_USER+x} ]
	then echo "ERROR: R-library is not set. Run sh R_setup.sh to set your package library.\\n";
		usage
        exit 1
fi
module load R-Core
Rscript $SCRIPTPATH/package_installer.R $R_LIBS_USER $BIO $GIT $UPDATE $@