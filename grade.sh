CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission &> /dev/null
echo 'Finished cloning'

if ! [ -f "student-submission/ListExamples.java" ]; then
    echo "ListExamples.java file missing make sure if the file can be found"
    exit 1
fi
cp TestListExamples.java grading-area/
cp student-submission/ListExamples.java grading-area/
cp -r lib grading-area/
cd grading-area
output=`javac -cp $CPATH *.java`
if ! [ ${?} -eq 0 ]; then
    echo "java compliation failed: $output"
    exit 1
fi
output=`java -cp $CPATH org.junit.runner.JUnitCore TestListExamples`
if ! [ ${?} -eq 0 ]; then
    grepOutput=`echo "$output" | grep -E -A 2 "[0-9]{1}\)[' ']?[a-z | A-Z |0-9]*['(']{1}[a-z|A-Z|0-9]*\)"`
    numberOfTestFailed=`echo $grepOutput | wc -l`
    echo "$numberOfTestFailed test('s') failed: $grepOutput"
else
    echo "All Test Passed"
fi
# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
