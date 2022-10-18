<?php
    $correct = false;
    if($_SERVER['REQUEST_METHOD'] === 'POST')
    {
        $correct = true;
        $plugboard = array();
        for($i = ord('A'); $i <= ord('Z'); $i++)
        {
            if(isset($_POST['plugboard-' . strtolower(chr($i))]))
            {
                $plugboard[] = strtoupper($_POST['plugboard-' . strtolower(chr($i))]);
            }
            else
            {
                $correct = false;
                break;
            }
        }
        if($correct)
        {
            for($i = 0; $i < 26; $i++)
            {
                if(strlen($plugboard[$i]) != 1 || ord($plugboard[$i]) < ord('A') || ord($plugboard[$i]) > ord('Z') || ord($plugboard[ord($plugboard[$i]) - ord('A')]) - ord('A') != $i)
                {
                    $correct = false;
                    break;
                }
            }
            if($correct)
            {
                if(!isset($_POST['rotor-1']) || !isset($_POST['rotor-2']) || !isset($_POST['rotor-3']) || !is_numeric($_POST['rotor-1']) || !is_numeric($_POST['rotor-2']) || !is_numeric($_POST['rotor-3']) || (int)$_POST['rotor-1'] != $_POST['rotor-1'] || (int)$_POST['rotor-2'] != $_POST['rotor-2'] || (int)$_POST['rotor-3'] != $_POST['rotor-3'] || $_POST['rotor-1'] < 1 || $_POST['rotor-1'] > 5 || $_POST['rotor-2'] < 1 || $_POST['rotor-2'] > 5 || $_POST['rotor-3'] < 1 || $_POST['rotor-3'] > 5 || $_POST['rotor-1'] == $_POST['rotor-2'] || $_POST['rotor-2'] == $_POST['rotor-3'] || $_POST['rotor-3'] == $_POST['rotor-1'])
                {
                    $correct = false;
                }
                elseif(!isset($_POST['rotor-1-setting']) || !isset($_POST['rotor-2-setting']) || !isset($_POST['rotor-3-setting']) || strlen($_POST['rotor-1-setting']) != 1 || strlen($_POST['rotor-2-setting']) != 1 || strlen($_POST['rotor-3-setting']) != 1 || ord(strtoupper($_POST['rotor-1-setting'])) < ord('A') || ord(strtoupper($_POST['rotor-1-setting'])) > ord('Z') || ord(strtoupper($_POST['rotor-2-setting'])) < ord('A') || ord(strtoupper($_POST['rotor-2-setting'])) > ord('Z') || ord(strtoupper($_POST['rotor-3-setting'])) < ord('A') || ord(strtoupper($_POST['rotor-3-setting'])) > ord('Z'))
                {
                    $correct = false;
                }
                elseif(!isset($_POST['rotor-1-position']) || !isset($_POST['rotor-2-position']) || !isset($_POST['rotor-3-position']) || strlen($_POST['rotor-1-position']) != 1 || strlen($_POST['rotor-2-position']) != 1 || strlen($_POST['rotor-3-position']) != 1 || ord(strtoupper($_POST['rotor-1-position'])) < ord('A') || ord(strtoupper($_POST['rotor-1-position'])) > ord('Z') || ord(strtoupper($_POST['rotor-2-position'])) < ord('A') || ord(strtoupper($_POST['rotor-2-position'])) > ord('Z') || ord(strtoupper($_POST['rotor-3-position'])) < ord('A') || ord(strtoupper($_POST['rotor-3-position'])) > ord('Z'))
                {
                    $correct = false;
                }
                elseif(!isset($_POST['reflector']) || ($_POST['reflector'] != 'UKW-B' && $_POST['reflector'] != 'UKW-C'))
                {
                    $correct = false;
                }
                elseif(!isset($_POST['text']))
                {
                    $correct = false;
                }
                else
                {
                    $rotor = array((int)$_POST['rotor-1'], (int)$_POST['rotor-2'], (int)$_POST['rotor-3']);
                    $rotor_setting = array(strtoupper($_POST['rotor-1-setting']), strtoupper($_POST['rotor-2-setting']), strtoupper($_POST['rotor-3-setting']));
                    $rotor_position = array(strtoupper($_POST['rotor-1-position']), strtoupper($_POST['rotor-2-position']), strtoupper($_POST['rotor-3-position']));
                    $reflector = $_POST['reflector'];
                }
            }
        }
    }
    if($correct == false)
    {
        $plugboard = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
        $rotor = array(1, 2, 3);
        $rotor_setting = array('A', 'A', 'A');
        $rotor_position = array('A', 'A', 'A');
        $reflector = 'UKW-B';
    }
    $numerals = array('', 'I', 'II', 'III', 'IV', 'V');
?>
<!DOCTYPE html>
<html lang="en">
 <head>
  <meta charset="UTF-8">
  <title>Enigma emulator</title>
  <link rel="stylesheet" type="text/css" href=".css">
 </head>
 <body>
  <h1>Enigma emulator</h1>
  <form method="post">
   <h2>Plugboard</h2>
   <table>
<?php
    echo "    <tr>\n";
    for($i = ord('A'); $i <= ord('Z'); $i++)
    {
        echo "     <th scope=\"col\">\n      <label for=\"plugboard-", strtolower(chr($i)), '">', chr($i), "</label>\n     </th>\n";
    }
    echo "    </tr>\n    <tr>\n";
    for($i = ord('A'); $i <= ord('Z'); $i++)
    {
        echo "     <td>\n      <select id=\"plugboard-", strtolower(chr($i)), '" name="plugboard-', strtolower(chr($i)), "\">\n";
        for($j = ord('A'); $j <= ord('Z'); $j++)
        {
            echo '       <option value="', chr($j), $plugboard[$i - ord('A')] == chr($j) ? '" selected>': '">', chr($j), "</option>\n";
        }
        echo "      </select>\n     </td>\n";
    }
    echo "    </tr>\n";
?>
   </table>
   <h2>Rotors</h2>
   <table>
    <tr>
     <th scope="col"></th>
     <th scope="col">1<sup>st</sup> rotor</th>
     <th scope="col">2<sup>nd</sup> rotor</th>
     <th scope="col">3<sup>rd</sup> rotor</th>
    </tr>
    <tr>
     <th scope="row">Rotor</th>
<?php
    for($i = 1; $i <= 3; $i++)
    {
        echo "     <td>\n      <select name=\"rotor-$i\">\n";
        for($j = 1; $j <= 5; $j++)
        {
            echo '       <option value="', $j, $rotor[$i - 1] == $j ? '" selected>' : '">', $numerals[$j], "</option>\n";
        }
        echo "      </select>\n     </td>\n";
    }
?>
    </tr>
    <tr>
     <th scope="row">Setting</th>
<?php
    for($i = 1; $i <= 3; $i++)
    {
        echo "     <td>\n      <select name=\"rotor-$i-setting\">\n";
        for($j = ord('A'); $j <= ord('Z'); $j++)
        {
            echo '       <option value="', chr($j), $rotor_setting[$i - 1] == chr($j) ? '" selected>' : '">', chr($j), "</option>\n";
        }
        echo "      </select>\n     </td>\n";
    }
?>
    </tr>
    <tr>
     <th scope="row">Position</th>
<?php
    for($i = 1; $i <= 3; $i++)
    {
        echo "     <td>\n      <select name=\"rotor-$i-position\">\n";
        for($j = ord('A'); $j <= ord('Z'); $j++)
        {
            echo '       <option value="', chr($j), $rotor_position[$i - 1] == chr($j) ? '" selected>' : '">', chr($j), "</option>\n";
        }
        echo "      </select>\n     </td>\n";
    }
?>
    </tr>
   </table>
   <h2>Reflector</h2>
   <select name="reflector">
<?php
    echo '    <option value="UKW-B"', $reflector == 'UKW-B' ? ' selected' : '', ">UKW-B</option>\n";
    echo '    <option value="UKW-C"', $reflector == 'UKW-C' ? ' selected' : '', ">UKW-C</option>\n";
?>
   </select>
   <h2>Text to encrypt/decrypt</h2>
   <textarea name="text"<?php
    if($correct)
    {
        echo '>', htmlspecialchars($_POST['text']);
    }
    else
    {
        echo ' autofocus>';
    }
?></textarea>
   <p>
    <input type="submit" value="OK">
   </p>
  </form>
<?php
    if($correct)
    {
        echo "  <h2>Result</h2>\n  <textarea autofocus>";
        $wheels = array(array('E', 'K', 'M', 'F', 'L', 'G', 'D', 'Q', 'V', 'Z', 'N', 'T', 'O', 'W', 'Y', 'H', 'X', 'U', 'S', 'P', 'A', 'I', 'B', 'R', 'C', 'J'), array('A', 'J', 'D', 'K', 'S', 'I', 'R', 'U', 'X', 'B', 'L', 'H', 'W', 'T', 'M', 'C', 'Q', 'G', 'Z', 'N', 'P', 'Y', 'F', 'V', 'O', 'E'), array('B', 'D', 'F', 'H', 'J', 'L', 'C', 'P', 'R', 'T', 'X', 'V', 'Z', 'N', 'Y', 'E', 'I', 'W', 'G', 'A', 'K', 'M', 'U', 'S', 'Q', 'O'), array('E', 'S', 'O', 'V', 'P', 'Z', 'J', 'A', 'Y', 'Q', 'U', 'I', 'R', 'H', 'X', 'L', 'N', 'F', 'T', 'G', 'K', 'D', 'C', 'M', 'W', 'B'), array('V', 'Z', 'B', 'R', 'G', 'I', 'T', 'Y', 'U', 'P', 'S', 'D', 'N', 'H', 'L', 'X', 'A', 'W', 'M', 'J', 'Q', 'O', 'F', 'E', 'C', 'K'));
        $inverse_wheels = array(array('U', 'W', 'Y', 'G', 'A', 'D', 'F', 'P', 'V', 'Z', 'B', 'E', 'C', 'K', 'M', 'T', 'H', 'X', 'S', 'L', 'R', 'I', 'N', 'Q', 'O', 'J'), array('A', 'J', 'P', 'C', 'Z', 'W', 'R', 'L', 'F', 'B', 'D', 'K', 'O', 'T', 'Y', 'U', 'Q', 'G', 'E', 'N', 'H', 'X', 'M', 'I', 'V', 'S'), array('T', 'A', 'G', 'B', 'P', 'C', 'S', 'D', 'Q', 'E', 'U', 'F', 'V', 'N', 'Z', 'H', 'Y', 'I', 'X', 'J', 'W', 'L', 'R', 'K', 'O', 'M'), array('H', 'Z', 'W', 'V', 'A', 'R', 'T', 'N', 'L', 'G', 'U', 'P', 'X', 'Q', 'C', 'E', 'J', 'M', 'B', 'S', 'K', 'D', 'Y', 'O', 'I', 'F'), array('Q', 'C', 'Y', 'L', 'X', 'W', 'E', 'N', 'F', 'T', 'Z', 'O', 'S', 'M', 'V', 'J', 'U', 'D', 'K', 'G', 'I', 'A', 'R', 'P', 'H', 'B'));
        $turnover = array('R', 'F', 'W', 'K', 'A');
        $reflectors = array(array('Y', 'R', 'U', 'H', 'Q', 'S', 'L', 'D', 'P', 'X', 'N', 'G', 'O', 'K', 'M', 'I', 'E', 'B', 'F', 'Z', 'C', 'W', 'V', 'J', 'A', 'T'), array('F', 'V', 'P', 'J', 'I', 'A', 'O', 'Y', 'E', 'D', 'R', 'Z', 'X', 'W', 'G', 'C', 'T', 'K', 'U', 'Q', 'S', 'B', 'N', 'M', 'H', 'L'));
        for($i = 0; $i < strlen($_POST['text']); $i++)
        {
            $c = strtoupper($_POST['text'][$i]);
            if(ord($c) >= ord('A') && ord($c) <= ord('Z'))
            {
                $middle = false;
                if((ord($rotor_position[1]) - ord('A') + 1) % 26 + ord('A') == ord($turnover[$rotor[1] - 1]))
                {
                    if($rotor_position[0] != 'Z')
                    {
                        $rotor_position[0] = chr(ord($rotor_position[0] + 1));
                    }
                    else
                    {
                        $rotor_position[0] = 'A';
                    }
                    $middle = true;
                }
                if($rotor_position[2] != 'Z')
                {
                    $rotor_position[2] = chr(ord($rotor_position[2]) + 1);
                }
                else
                {
                    $rotor_position[2] = 'A';
                }
                if($rotor_position[2] == $turnover[$rotor[2] - 1])
                {
                    $middle = true;
                }
                if($middle)
                {
                    if($rotor_position[1] != 'Z')
                    {
                        $rotor_position[1] = chr(ord($rotor_position[1]) + 1);
                    }
                    else
                    {
                        $rotor_position[1] = 'A';
                    }
                }
                $c = $plugboard[ord($c) - ord('A')];
                $c = chr((ord($wheels[$rotor[2] - 1][(ord($c) - ord('A') + ord($rotor_position[2]) - ord($rotor_setting[2]) + 26) % 26]) - ord($rotor_position[2]) + ord($rotor_setting[2]) - ord('A') + 26) % 26 + ord('A'));
                $c = chr((ord($wheels[$rotor[1] - 1][(ord($c) - ord('A') + ord($rotor_position[1]) - ord($rotor_setting[1]) + 26) % 26]) - ord($rotor_position[1]) + ord($rotor_setting[1]) - ord('A') + 26) % 26 + ord('A'));
                $c = chr((ord($wheels[$rotor[0] - 1][(ord($c) - ord('A') + ord($rotor_position[0]) - ord($rotor_setting[0]) + 26) % 26]) - ord($rotor_position[0]) + ord($rotor_setting[0]) - ord('A') + 26) % 26 + ord('A'));
                $c = $reflectors[$reflector =='UKW-B' ? 0 : 1][ord($c) - ord('A')];
                $c = chr((ord($inverse_wheels[$rotor[0] - 1][(ord($c) - ord('A') + ord($rotor_position[0]) - ord($rotor_setting[0]) + 26) % 26]) - ord($rotor_position[0]) + ord($rotor_setting[0]) - ord('A') + 26) % 26 + ord('A'));
                $c = chr((ord($inverse_wheels[$rotor[1] - 1][(ord($c) - ord('A') + ord($rotor_position[1]) - ord($rotor_setting[1]) + 26) % 26]) - ord($rotor_position[1]) + ord($rotor_setting[1]) - ord('A') + 26) % 26 + ord('A'));
                $c = chr((ord($inverse_wheels[$rotor[2] - 1][(ord($c) - ord('A') + ord($rotor_position[2]) - ord($rotor_setting[2]) + 26) % 26]) - ord($rotor_position[2]) + ord($rotor_setting[2]) - ord('A') + 26) % 26 + ord('A'));
                $c = $plugboard[ord($c) - ord('A')];
                echo $c;
            }
        }
        echo "</textarea>\n";
    }
?>
 </body>
</html>
