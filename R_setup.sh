#!/bin/bash
SCRIPTPATH=`dirname $0`
usage(){
cat << EOF

USAGE: sh R_setup.sh -i -l [R-library_directory] 

OPTIONS:
	-i 	install preset packages, only needed if specifying a new library (this will take a while)
	-l  specify a directory for your R-library, if this has not been 
   		set previously and you do not specify with this flag then the 
   		default will be /mnt/research/germs/R/library.

EOF
}
while getopts ":hil" OPTION; do
     case $OPTION in
         h)
            usage
            exit 1
            ;;
         i)
			INSTALL=TRUE
            ;;
         l)
			if [ -z ${R_LIBS_USER+x} ]
            	then R_LIBS_USER=echo "${@: -1}";
        		else echo "R-library is already set, do you wish to create a new libary in echo "${@: -1}"?\\n";
					read -p " [y/N] " ans;
					case "$ans" in
						[yY][eE][sS]|[yY]) 
					 		R_LIBS_USER=echo "${@: -1}";
							;;
						*)
							:
					 		;;
					esac
	        fi
	        echo "export R_LIBS_USER=$R_LIBS_USER" >> ~/.bashrc
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


if [ -z ${R_LIBS_USER+x} ]
	then echo "WARNING: R-library is not set and -l argument is missing. R-library will be automatically set to /mnt/research/germs/R/library ?";
		read -p " [y/N] " ans;
		case "$ans" in
			[yY][eE][sS]|[yY]) 
		 		R_LIBS_USER=/mnt/research/germs/R/library;
		        echo "export R_LIBS_USER=$R_LIBS_USER" >> ~/.bashrc
				;;
			*)
				usage
            	exit 1
		 		;;
		esac
fi

if grep -Fxq "module load R-Core" ~/.bashrc
	then
    	:
	else
    	echo "module load R-Core" >> ~/.bashrc
fi

source ~/.bashrc
if [ -e $R_LIBS_USER ] ;
	then : ;
	else mkdir -p $R_LIBS_USER ;
fi

if [ -z $INSTALL ] ;
	then : ;
	else Rscript --vanilla $SCRIPTPATH/library_setup.R $R_LIBS_USER ;
fi
