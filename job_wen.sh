#!/bin/sh
#
#
#PBS -l nodes=6:ppn=16
#PBS -j oe 
#PBS -k oe

export PATH=/home/wczhou3/gcc-8.3.0/bin:$PATH
export LD_LIBRARY_PATH=/home/wczhou3/gcc-8.3.0/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/home/wczhou3/gcc-8.3.0/lib64:$LD_LIBRARY_PATH

cd /home/wczhou3/p6

# Set some environment variables 
FREE_ENERGY=`pwd`
echo "Free energy home directory set to $FREE_ENERGY"
MDP=$FREE_ENERGY/MDP
echo ".mdp files are stored in $MDP"
cd FREE_ENERGY

for (( i=0; i<21; i++ ))
do
    LAMBDA=$i

    # A new directory will be created for each value of lambda and
    # at each step in the workflow for maximum organization.

    mkdir Lambda_$LAMBDA
    cd Lambda_$LAMBDA

    ##############################
    # ENERGY MINIMIZATION STEEP  #
    ##############################
    echo "Starting minimization for lambda = $LAMBDA..." 

    mkdir EM
    cd EM

    # Iterative calls to grompp and mdrun to run the simulations

    /home/wczhou3/gmx2018.6/bin/gmx_mpi grompp -f $MDP/em_steep_$LAMBDA.mdp -c $FREE_ENERGY/methane_water.gro -p $FREE_ENERGY/topol.top -o min$LAMBDA.tpr

    /home/wczhou3/gmx2018.6/bin/gmx_mpi mdrun -deffnm min$LAMBDA

    sleep 10

    #####################
    # NVT EQUILIBRATION #
    #####################
    echo "Starting constant volume equilibration..."

    cd ../
    mkdir NVT
    cd NVT

    /home/wczhou3/gmx2018.6/bin/gmx_mpi grompp -f $MDP/nvt_$LAMBDA.mdp -c ../EM/min$LAMBDA.gro -p $FREE_ENERGY/topol.top -o nvt$LAMBDA.tpr

    /home/wczhou3/gmx2018.6/bin/gmx_mpi mdrun -deffnm nvt$LAMBDA

    echo "Constant volume equilibration complete."

    sleep 10

    #####################
    # NPT EQUILIBRATION #
    #####################
    echo "Starting constant pressure equilibration..."

    cd ../
    mkdir NPT
    cd NPT

    /home/wczhou3/gmx2018.6/bin/gmx_mpi grompp -f $MDP/npt_$LAMBDA.mdp -c ../NVT/nvt$LAMBDA.gro -p $FREE_ENERGY/topol.top -t ../NVT/nvt$LAMBDA.cpt -o npt$LAMBDA.tpr

    /home/wczhou3/gmx2018.6/bin/gmx_mpi mdrun -deffnm npt$LAMBDA

    echo "Constant pressure equilibration complete."

    sleep 10

    #################
    # PRODUCTION MD #
    #################
    echo "Starting production MD simulation..."

    cd ../
    mkdir Production_MD
    cd Production_MD

    /home/wczhou3/gmx2018.6/bin/gmx_mpi grompp -f $MDP/md_$LAMBDA.mdp -c ../NPT/npt$LAMBDA.gro -p $FREE_ENERGY/topol.top -t ../NPT/npt$LAMBDA.cpt -o md$LAMBDA.tpr

    /home/wczhou3/gmx2018.6/bin/gmx_mpi mdrun -deffnm md$LAMBDA

    echo "Production MD complete."

    # End
    echo "Ending. Job completed for lambda = $LAMBDA"

    cd $FREE_ENERGY
done

exit;
