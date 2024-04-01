function Convert-Words {
    param (
        [int64]$Number
    )

    # Define arrays for the word representations
    $units = @("", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine")
    $teens = @("Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen")
    $tens = @("", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety")
    $thousands = @("", "Thousand", "Million", "Billion", "Trillion", "Quadrillion", "Quintillion")

    # Define a function to convert a number less than 1000 to words
    function Convert-Thousand {
        param (
            [int64]$num
        )
       
        if ($num -eq 0) {
            return ""
        }
        elseif ($num -lt 10) {
            return $units[$num]
        }
        elseif ($num -lt 20) {
            return $teens[$num - 10]
        }
        elseif ($num -lt 100) {
            return "$($tens[$num / 10]) $($units[$num % 10])"
        }
        else {
            return "$($units[$num / 100]) Hundred $(Convert-Thousand ($num % 100))"
        }
    }

    if ($Number -eq 0) {
        return "Zero"
    }

    $words = ""
    for ($i = 0; $i -lt $thousands.Length; $i++) {
        if ($Number % 1000 -ne 0) {
            $words = "$(Convert-Thousand ($Number % 1000)) $($thousands[$i]) $($words)"
        }
        $Number = [math]::DivRem($Number, 1000, [ref]$null)
    }

    return $words.Trim()
}

try{
$Outut = while ($true) {
    $userInput = Read-Host "Enter a number"
    if ($userInput -match '^\d+$') {
        $userInput = [int64]$userInput
        if ($userInput -lt 0 -or $userInput -gt [int64]::MaxValue) {
            Write-Host "Please enter a valid integer within the range of 0 to $([int64]::MaxValue)"
            continue
        }
        Write-Host "Program Output: $(Convert-Words $userInput)"
        break
    }
    else {
        Write-Host "Please enter a valid integer."
    }
}

}
Catch{
 Write-Output "Error while covert number to words: $_. "
}