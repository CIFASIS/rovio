#!/bin/bash
#
# Run Rosario dataset (from sequence 01 to 06)
# Parameter:
#   -Path of folder containing rosbags (files must be named sequence0*.bag)

# Get full directory name of the script no matter where it is being called from
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

function echoUsage()
{
  echo -e "Usage: ./run_rosario_sequence.sh [-p] ROSBAGS_PATH\n\
          \t -p \t Plot and show results. Even if the flag is not set, a\n\
          \t\t script to automatically plot the results will be\n\
          \t\t generated with outputs. Evo should be installed. \n\
          \t -h \t Help." >&2
}

PLOT=0
while getopts "hp" opt; do
    case "$opt" in
        h)  echoUsage
            exit 0
            ;;
        p)  PLOT=1
            ;;
        *)
            echoUsage
            exit 1
            ;;
    esac
done

shift $((OPTIND - 1))
DATASET_DIR=$1

dt=$(date '+%Y%m%d_%H%M%S')
OUTPUT_DIR=$CURRENT_DIR/outputs/rosario_${dt}
mkdir -p $OUTPUT_DIR
echo "#!/bin/bash" > $OUTPUT_DIR/plot_results.sh

trap "exit 1" INT

for i in `seq 1 6` ; do
  $CURRENT_DIR/run_rosario_sequence.sh -r -b -o $OUTPUT_DIR/trajectory_rosario_0$i.txt $DATASET_DIR/sequence0$i.bag
  echo "evo_traj tum $OUTPUT_DIR/trajectory_rosario_0$i.txt --ref $DATASET_DIR/sequence0${i}_gt.txt --align --plot --t_max_diff 0.02" >> $OUTPUT_DIR/plot_results.sh
done

chmod +x $OUTPUT_DIR/plot_results.sh

if [ $PLOT -eq 1 ] ; then
  $OUTPUT_DIR/plot_results.sh
fi