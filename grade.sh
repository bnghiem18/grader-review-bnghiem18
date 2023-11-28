CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
cp -r lib *.java grading-area

#checking for correct file
if [[ -f 'student-submission/ListExamples.java' ]] 
    then 
        cp -r student-submission/ListExamples.java grading-area
    else 
        echo "File is invalid"
        exit
    fi
echo "Exited loop"

cd grading-area


javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java > CompileOutput.txt

#checking for compile error 
if [[ 'find grading-area/CompileOutput.txt -empty' ]]
    then
        echo "Compiled Successfully!"
    else
        #if failed, print out what the compile error was
        cat grading-area/CompileOutput.txt
        exit
    fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > JUnitOutput.txt

grep -A 1 "FAILURES!!!" JUnitOutput.txt > GrepCheck.txt

#checking if there are failures in the JUNIT
if grep -q "FAILURES!!!" JUnitOutput.txt 
    then
        echo "There are failures"
        result = "`grep "Tests run:" JUnitOutput.txt`"
        echo "$result"
    else
        echo "Passed all Tests"
        exit
    fi

