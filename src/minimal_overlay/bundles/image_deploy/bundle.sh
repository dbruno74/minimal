#!/bin/sh

set -e

./01_get.sh
. ../../common.sh

mkdir -p $DEST_DIR/etc/autorun
mkdir -p $DEST_DIR/root
cp $SRC_DIR/99_deploy_uc20.sh $DEST_DIR/etc/autorun
cp $OVERLAY_SOURCE_DIR/ubuntu-core-20-amd64.img.xz $DEST_DIR/root


chmod +x $DEST_DIR/etc/autorun/99_deploy_uc20.sh

install_to_overlay

# In the end we print message that our bundle has been installed and we return
# to the overlay source folder.
echo "Bundle '$BUNDLE_NAME' has been installed."

cd $SRC_DIR

