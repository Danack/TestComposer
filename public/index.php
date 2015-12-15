<?php

use Composer\Autoload\ClassLoader;

$autoloader = require __DIR__.'/../vendor/autoload.php';

$optimizeSetting = "Not recognized";

if (isset($_GET['setting'])) {
    $optimizeSetting = $_GET['setting'];
}

if (strcmp("COMPOSER__OPCACHE", $optimizeSetting) === 0) {
    $autoloader->setSearchModes([
        ClassLoader::SEARCHMODE_OPCACHE,
        ClassLoader::SEARCHMODE_FILE
    ]);
}
if (strcmp("COMPOSER_STANDARD", $optimizeSetting) === 0) {
    $autoloader->setSearchModes([
        ClassLoader::SEARCHMODE_FILE
    ]);
}

$test = null;
if (isset($_GET['test'])) {
    $test = $_GET['test'];
}

$test = 'testOne';

$tests = [
    'check',
    'testOne', 
    'testTwo'
];


if (in_array($test, $tests)) {
    call_user_func($test);
}

echo "Ok $optimizeSetting";

function check()
{
    if (function_exists('opcache_get_status') == false) {
        echo "opcache_get_status function does not exist";
        return;
    }

    $status = opcache_get_status();
}

function testOne()
{
    $instance = new PerfTest\PerfOne\Test1();
}

function testTwo()
{
    $instance = new PerfTest\PerfTwo\Test1();
}