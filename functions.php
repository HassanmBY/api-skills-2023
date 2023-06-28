<?php
    function myPrint_r($var) {
        if(MODE == 'dev'){
            echo '<pre>';
            print_r($var);
            echo '</pre>';
        }
    }  