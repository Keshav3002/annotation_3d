#! /bin/sh

SEQ_NAME=$1
GENDER=$2
RESTART=$3

BLEND_PATH="./data/to_annotate/abhi/annotate/${SEQ_NAME}.blend"
BLEND_pkl="./data/to_annotate/abhi/annotate/${SEQ_NAME}.pkl"
BLENDER_PATH="~/Desktop/blender/blender" #if linux
win_BLENDER_PATH="D:\\blender-4.1.1-windows-x64\\blender-4.1.1-windows-x64\\blender.exe"
SYS="win" # macos


function fresh_start {
    python prepare_for_annotation.py --seq_name $SEQ_NAME --gender $GENDER
    if [ "$SYS" = "linux" ]; then
        $BLENDER_PATH $BLEND_PATH -P starter.py
    elif [ "$SYS" = "macos" ]; then
        /Applications/blender.app/Contents/MacOS/blender $BLEND_PATH -P starter.py
    elif [ "$SYS" = "win" ]; then
        $win_BLENDER_PATH $BLEND_PATH -P starter.py
    fi
    }

function resume {
    BLEND_PATH="./data/to_annotate/${SEQ_NAME}/annotate/${SEQ_NAME}.blend"
    #linux
    if [ "$SYS" = "linux" ]; then
        $BLENDER_PATH $BLEND_PATH
    elif [ "$SYS" = "macos" ]; then
        /Applications/blender.app/Contents/MacOS/blender $BLEND_PATH
    elif [ "$SYS" = "win" ]; then
        $win_BLENDER_PATH -P $BLEND_PATH
    fi
}

if [ "$RESTART" = "resume" ]; then
    if test -f "$BLEND_pkl"; then
        echo "Continuing from last saved"
        resume
    fi
elif [ "$RESTART" = "restart" ]; then
    echo "All saved progress will be removed"
    fresh_start
else
    fresh_start
fi
