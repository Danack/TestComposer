

test_settings=()

test_settings+=("COMPOSER_STANDARD")
test_settings+=("COMPOSER__OPCACHE")

echo "" > testOutput.txt

current_pid=$$

echo "current_pid is ${current_pid}"

# Start a PHP server
valgrind --tool=callgrind --instr-atstart=no php -S 0.0.0.0:80 -t ./public > valgrind_output_.txt 2>&1 &

# Grab the process ID of the just started server.
server_pid=$!
echo "Server PID is ${server_pid}"

for test_setting in "${test_settings[@]}"
do

  echo "Testing with setting ${test_setting}"

  # Comment in to debug the server
  # read -p "php is running - press [Enter] to stop"

  setup_check=$(wget -q http://127.0.0.1/?test=check -O -)
  
  if [ "${setup_check}" != "Ok" ];
  then
      echo "The settings check failed. Maybe OPCache isn't working?"
      echo "Result of setup check is ${setup_check}"
      exit 1
  else
  
    callgrind_control -i on
  
    echo "Test ${test_setting} start" >> testOutput.txt
    
    echo "testOne" >> testOutput.txt
    wget -q "http://127.0.0.1/?test=testOne&setting=${test_setting}" -O - >> testOutput.txt
    echo "" >> testOutput.txt
    
    echo "testTwo" >> testOutput.txt
    wget -q "http://127.0.0.1/?test=testTwo&setting=${test_setting}" -O - >> testOutput.txt
    echo "" >> testOutput.txt
    
    # callgrind_control status
    callgrind_control -i off
  fi

done


# Kill the PHP server
# Something is wrong with the PIDs
#kill "${server_pid}"
pkill php
pkill callgrind-amd64


# Debugging for when the server fails to top.
echo "Pid was ${server_pid}"