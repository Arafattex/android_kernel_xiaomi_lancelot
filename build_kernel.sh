#!/bin/bash

# simple build scripts for compiling kernel on this repo
<<<<<<< HEAD
# supported config: merlin, lancelot
# toolchain used: aosp clang 13
=======
>>>>>>> 14d1d2cf21f8479f6fd074e48490030c81715adb
# note:
# change telegram CHATID to yours
# change OUTDIR if needed, by default its using /root directory

##------------------------------------------------------##

Help()
{
<<<<<<< HEAD
  echo "Usage: [--help|-h|-?] [--clone|-c] [--no-lto] [--dtbo]"
=======
  echo "Usage: [--help|-h|-?] [--clone|-c] [--lto]"
>>>>>>> 14d1d2cf21f8479f6fd074e48490030c81715adb
  echo "$0 <defconfig> <token> [Other Args]"
  echo -e "\t--clone: Clone compiler"
  echo -e "\t--lto: Enable Clang LTO"
  echo -e "\t--help: To show this info"
}

##------------------------------------------------------##

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
  --clone|-c)
  CLONE=true
  shift
  ;;
  --lto)
  LTO=true
  shift
  ;;
  --help|-h|-?)
  Help
  exit
  ;;
  *)
  POSITIONAL+=("$1")
  shift
  ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ -z $2 ]]; then
  echo "ERROR: Enter all needed parameters"
  usage
  exit
fi

CONFIG=$1
TOKEN=$2

echo "This is your setup config"
echo
echo "Using defconfig: ""$CONFIG""_defconfig"
<<<<<<< HEAD
<<<<<<< HEAD
echo "Clone dependencies: $([[ ! -z "$CLONE" ]] && echo "true" || echo "false")"
echo "Enable LTO Clang: $([[ ! -z "$LTO" ]] && echo "true" || echo "false")"
=======
echo "Clone dependencies: $([[ -n "$CLONE" ]] && echo "true" || echo "false")"
echo "Enable LTO Clang: $([[ -n "$LTO" ]] && echo "true" || echo "false")"
echo "Copy dtbo.img: $([[ -n "$DTBO" ]] && echo "true" || echo "false")"
>>>>>>> cf7504cb092ab431c5dbd490f0fc0a0f520c58b0
=======
echo "Clone dependencies: $([[ -n "$CLONE" ]] && echo "true" || echo "false")"
echo "Enable LTO Clang: $([[ -n "$LTO" ]] && echo "true" || echo "false")"
>>>>>>> 14d1d2cf21f8479f6fd074e48490030c81715adb
echo
read -p "Are you sure? " -n 1 -r
! [[ $REPLY =~ ^[Yy]$ ]] && exit
echo

##------------------------------------------------------##

tg_post_msg() {
  curl -s -X POST "$BOT_MSG_URL" -d chat_id="$CHATID" \
       -d "disable_web_page_preview=true" \
       -d "parse_mode=html" \
       -d text="$1"
}

##----------------------------------------------------------------##

tg_post_build() {
  curl --progress-bar -F document=@"$1" "$BOT_BUILD_URL" \
                      -F chat_id="$CHATID"  \
                      -F "disable_web_page_preview=true" \
                      -F "parse_mode=html" \
                      -F caption="$2"
}
##----------------------------------------------------------------##

zipping() {
  cd "$OUTDIR"/AnyKernel || exit 1
<<<<<<< HEAD
<<<<<<< HEAD
  rm *.zip *-dtb *dtbo.img
=======
  rm -- *.zip *-dtb *dtbo.img
  [[ $DTBO == true ]] && cp "$OUTDIR"/arch/arm64/boot/dtbo.img .
>>>>>>> cf7504cb092ab431c5dbd490f0fc0a0f520c58b0
  cp "$OUTDIR"/arch/arm64/boot/Image.gz-dtb .
  zip -r9 "$ZIPNAME"-"${DATE}".zip -- *
=======
  rm -- *.zip *-dtb
  cp "$OUTDIR"/arch/arm64/boot/Image.gz-dtb .
  zip -r9 "[$DATE][$CONFIG]$KERVER-$ZIPNAME-$HASH_HEAD.zip" -- *
>>>>>>> 14d1d2cf21f8479f6fd074e48490030c81715adb
  cd - || exit
}

##----------------------------------------------------------------##

build_kernel() {
<<<<<<< HEAD
  [[ $LTO == true ]] && echo "CONFIG_LTO_CLANG=y" >> arch/arm64/configs/"$DEFCONFIG"
  echo "-$CONFIG" > localversion
  make O="$OUTDIR" ARCH=arm64 "$DEFCONFIG"
  make -j"$PROCS" O="$OUTDIR" \
                  ARCH=arm64 \
                  CC=clang \
                  CLANG_TRIPLE=aarch64-linux-gnu- \
                  CROSS_COMPILE=aarch64-linux-android- \
                  CROSS_COMPILE_ARM32=arm-linux-androideabi- \
                  LD=ld.lld \
                  NM=llvm-nm \
                  OBJCOPY=llvm-objcopy 2> FIXME.txt
=======
  find "$OUTDIR" -name *.gz-dtb -delete
  [[ $LTO == true ]] && echo "CONFIG_LTO_CLANG=y" >> arch/arm64/configs/"$DEFCONFIG"
  echo "-Genom-R-$CONFIG" > localversion
  make O="$OUTDIR" ARCH=arm64 xiaomi_defconfig "xiaomi/$DEFCONFIG"
  make -j"$PROCS" O="$OUTDIR" \
                  ARCH=arm64 \
                  CC=clang \
                  CROSS_COMPILE=aarch64-linux-gnu- \
                  CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
                  LD=ld.lld \
                  NM=llvm-nm \
                  OBJCOPY=llvm-objcopy
>>>>>>> 14d1d2cf21f8479f6fd074e48490030c81715adb
}

##----------------------------------------------------------------##

export OUTDIR=/root

if [[ $CLONE == true ]]
then
  echo "Cloning dependencies"
<<<<<<< HEAD
  mkdir "$OUTDIR"/clang-llvm
  mkdir "$OUTDIR"/gcc64-aosp
  mkdir "$OUTDIR"/gcc32-aosp
<<<<<<< HEAD
  ! [[ -f "$OUTDIR"/clang-r428724.tar.gz ]] && wget https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/master/clang-r428724.tar.gz -P "$OUTDIR"
  tar -C "$OUTDIR"/clang-llvm/ -zxvf "$OUTDIR"/clang-r428724.tar.gz
=======
  ! [[ -f "$OUTDIR"/clang-r433403.tar.gz ]] && wget https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/master/clang-r433403.tar.gz -P "$OUTDIR"
  tar -C "$OUTDIR"/clang-llvm/ -zxvf "$OUTDIR"/clang-r433403.tar.gz
>>>>>>> cf7504cb092ab431c5dbd490f0fc0a0f520c58b0
  ! [[ -f "$OUTDIR"/android-11.0.0_r35.tar.gz ]] && wget https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/+archive/refs/tags/android-11.0.0_r35.tar.gz -P "$OUTDIR"
  tar -C "$OUTDIR"/gcc64-aosp/ -zxvf "$OUTDIR"/android-11.0.0_r35.tar.gz
  ! [[ -f "$OUTDIR"/android-11.0.0_r34.tar.gz ]] && wget http://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/+archive/refs/tags/android-11.0.0_r34.tar.gz -P "$OUTDIR"
  tar -C "$OUTDIR"/gcc32-aosp/ -zxvf "$OUTDIR"/android-11.0.0_r34.tar.gz
=======
  git clone https://github.com/rama982/clang --depth=1  "$OUTDIR"/clang-llvm
>>>>>>> 14d1d2cf21f8479f6fd074e48490030c81715adb
  git clone https://github.com/rama982/AnyKernel3 --depth=1 "$OUTDIR"/AnyKernel
fi

#telegram env
CHATID=-1001459070028
BOT_MSG_URL="https://api.telegram.org/bot$TOKEN/sendMessage"
BOT_BUILD_URL="https://api.telegram.org/bot$TOKEN/sendDocument"

# env
<<<<<<< HEAD
export DEFCONFIG=$CONFIG"_defconfig"
export TZ="Asia/Jakarta"
export KERNEL_DIR=$(pwd)
export ZIPNAME="Genom-OSS-R-$CONFIG-BETA"
export IMAGE="${OUTDIR}/arch/arm64/boot/Image.gz-dtb"
export DATE=$(date "+%Y%m%d-%H%M")
export BRANCH="$(git rev-parse --abbrev-ref HEAD)"
export PATH="${OUTDIR}/clang-llvm/bin:${OUTDIR}/gcc64-aosp/bin:${OUTDIR}/gcc32-aosp/bin:${PATH}"
=======
export DEFCONFIG=$CONFIG".config"
export TZ="Asia/Jakarta"
export KERNEL_DIR=$(pwd)
export ZIPNAME="Genom-R"
export IMAGE="${OUTDIR}/arch/arm64/boot/Image.gz-dtb"
export DATE=$(date "+%m%d")
export BRANCH="$(git rev-parse --abbrev-ref HEAD)"
export PATH="${OUTDIR}/clang-llvm/bin:${PATH}"
>>>>>>> 14d1d2cf21f8479f6fd074e48490030c81715adb
export KBUILD_COMPILER_STRING="$(${OUTDIR}/clang-llvm/bin/clang --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g')"
export KBUILD_BUILD_HOST=$(uname -a | awk '{print $2}')
export ARCH=arm64
export KBUILD_BUILD_USER=rama982
<<<<<<< HEAD
=======
export HASH_HEAD=$(git rev-parse --short HEAD)
>>>>>>> 14d1d2cf21f8479f6fd074e48490030c81715adb
export COMMIT_HEAD=$(git log --oneline -1)
export PROCS=$(nproc --all)
export DISTRO=$(cat /etc/issue)
export KERVER=$(make kernelversion)

# start build
tg_post_msg "
Build is started
<b>OS: </b>$DISTRO
<b>Date : </b>$(date)
<b>Device : </b>$CONFIG
<b>Host : </b>$KBUILD_BUILD_HOST
<<<<<<< HEAD
<b>Core Count : </b>$PROCS
=======
<b>Core Count : </b>$PROCS cores
>>>>>>> 14d1d2cf21f8479f6fd074e48490030c81715adb
<b>Branch : </b>$BRANCH
<b>Top Commit : </b>$COMMIT_HEAD
"

BUILD_START=$(date +"%s")

build_kernel

BUILD_END=$(date +"%s")
DIFF=$((BUILD_END - BUILD_START))

if [[ -f $IMAGE ]]
then
  zipping
  ZIPFILE=$(ls "$OUTDIR"/AnyKernel/*.zip)
  MD5CHECK=$(md5sum "$ZIPFILE" | cut -d' ' -f1)
  tg_post_build "$ZIPFILE" "
<b>Build took : </b>$((DIFF / 60)) minute(s) and $((DIFF % 60)) second(s)
<<<<<<< HEAD
<b>Kernel Version : </b>$KERVER
=======
>>>>>>> 14d1d2cf21f8479f6fd074e48490030c81715adb
<b>Compiler: </b>$(grep LINUX_COMPILER ${OUTDIR}/include/generated/compile.h  |  sed -e 's/.*LINUX_COMPILER "//' -e 's/"$//')
<b>Enable LTO Clang: </b>$([[ -n "$LTO" ]] && echo "true" || echo "false")
<b>MD5 Checksum : </b><code>$MD5CHECK</code>
"
else
  tg_post_msg "<b>Build took : </b>$((DIFF / 60)) minute(s) and $((DIFF % 60)) second(s) but error"
fi

# reset git
git reset --hard HEAD

##----------------*****-----------------------------##
<<<<<<< HEAD

=======
>>>>>>> 14d1d2cf21f8479f6fd074e48490030c81715adb
