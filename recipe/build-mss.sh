#! /bin/bash

echo "========================================================================"
echo "Building ${PKG_NAME}"
echo ""

# Ensure our GEOS will be used.
export GEOS_DIR="${PREFIX}"

# Temporary workaround when cross-compiling.
if [ "${CONDA_BUILD_CROSS_COMPILATION}" = "1" -a "${PKG_NAME}" = "mss" ]; then
    rm ${BUILD_PREFIX}/bin/python
    ln -sf ${PREFIX}/bin/python ${BUILD_PREFIX}/bin/python
fi

case "${PKG_NAME}" in
    mss)
        ${PYTHON} -m pip install . --no-deps --ignore-installed -vvv --record record.txt packages/mss
    ;;
    mss-mswms)
        ${PYTHON} -m pip install . --no-deps --ignore-installed -vvv --record record.txt packages/mss-mswms
    ;;
    mss-mscolab)
        ${PYTHON} -m pip install . --no-deps --ignore-installed -vvv --record record.txt packages/mss-mscolab
    ;;
    *)
        echo "No build instructions for ${PKG_NAME}"
        exit 1
    ;;
esac
