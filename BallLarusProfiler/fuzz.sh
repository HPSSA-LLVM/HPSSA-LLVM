testDir="tests"
outputDir="output"
buildDir="build"

mkdir -p $testDir 
mkdir -p $outputDir
mkdir -p $buildDir

dd if=/dev/random of=$testDir/input02.txt bs=32 count=1
dd if=/dev/random of=$testDir/input03.txt bs=32 count=1
head -c 32 /dev/zero > $testDir/input04.txt
dd if=/dev/random of=$testDir/input05.txt bs=32 count=1
head -c 32 /dev/zero > $testDir/input06.txt

afl-fuzz -i "$testDir/" -o "$outputDir/" -m 8G ./instprogram.o