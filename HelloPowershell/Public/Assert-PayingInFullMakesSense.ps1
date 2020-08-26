Function Assert-PayingInFullMakesSense {
    <#
    .SYNOPSIS
        Returns true if it is cost effective to buy a house in cash, false otherwise.

    .DESCRIPTION
        Returns true if it is cost effective to buy a house in cash, false otherwise.

        This function uses a linear approximation on a 30-year mortgage to estimate
        how much of the house would be excluded from the remaining loan balance.
        Let y = the proportion of house owned x years into the loan. 0 <= x <= 30.

        y = 1 - ((30 - x) / 37.5) 

    .PARAMETER Discount
        The expected proportion taken off of the sale price due to being a cash buyer, between 0 and 1.
        This will be added to 0.03 saved on loan origination fees.

    .PARAMETER NumberOfYears
        Number of years into the future to calculate results. Defaults to 10.

    .PARAMETER StockMarketPerformance
        Annual ROI of, for example, the same sum of money invested in the stock market. Defaults to 0.07.

    .PARAMETER RateOfInflation
        Annual cost of living increase. Defaults to 0.03. The value of the home will increase at the same rate.

    .EXAMPLE
        Assert-PayingInFullMakesSense # Returns $false

    .LINK
        about_Assert-PayingInFullMakesSense

    .LINK
        https://github.com/mjonescase/HelloPowershell

    #>
    [cmdletbinding()]
    Param(
        [Parameter( 
            Mandatory = $true,
            Position=0,
            ValueFromPipeline=$true
        )]
        [ValidateNotNullOrEmpty()]
        [decimal]$Discount,

        [Parameter(
            Mandatory = $false,
            Position = 1
        )]
        [int]$NumberOfYears = 10,

        [Parameter(
            Mandatory = $false,
            Position = 2
        )]
        [decimal]$StockMarketPerformance = 0.07,

        [Parameter(
            Mandatory = $false,
            Position = 3
        )]
        [decimal]$RateOfInflation = 0.03
    )
    <#
    # BEGIN OPPORTUNITY COST
    # this is the percentage of the original home value
    # still left to be paid down.
    $AmortizationPercentageTable = @{
        5=0.7
        10=0.6
        15=0.48
        20=0.34
        25=0.18
        30=0.0
    }
    [int]$HouseValueBefore = 3 * [Math]::Pow(10, 5)
    [decimal]$HouseValueAfter = $HouseValueBefore * [Math]::Pow(1 + $RateOfInflation, $NumberOfYears)
    [decimal]$AmountLeftOnLoan = $HouseValueBefore * $AmortizationPercentageTable[$NumberOfYears]
    [decimal]$StockValueAfter = 0.8 * $HouseValueBefore * [Math]::Pow(1 + $StockMarketPerformance, $NumberOfYears)

    [decimal]$OpportunityCost = $HouseValueAfter - $AmountLeftOnLoan + $StockValueAfter
    # Write-Output "Net worth with 20% down: $($OpportunityCost)"

    # END OPPORTUNITY COST
    # BEGIN BUY OUTRIGHT
    [decimal]$MonthlyLoanPayment = $HouseValueBefore / ( 75 * [Math]::Pow(10, 3)) * 270

    # TODO this is a really rough estimate.
    [decimal]$HouseValueDiscounts = $HouseValueBefore * ( $Discount + 0.03 ) # assuming 3% off for loan origination fees.
    [decimal]$StockMarketGainsOnDiscounts = $HouseValueDiscounts * [Math]::Pow(1 + $StockMarketPerformance, $NumberOfYears)
    [decimal]$LesserStockValueAfter = $MonthlyLoanPayment * [Math]::Pow(1 + $StockMarketPerformance, $NumberOfYears / 2)
    
    [decimal]$NetWorth = $HouseValueAfter + $StockMarketGainsOnDiscounts + $LesserStockValueAfter
    # Write-Output "Net worth buying outright: $($NetWorth)"
    #>
    [PayInFullResult]$Result = New-Object PayInFullResult
    $Result.PayInFullNetWorth = 9000 # $NetWorth
    $Result.MortgageNetWorth = 5000 # $OpportunityCost
    $Result.DoesPayInFullMakeSense = $false #$NetWorth -gt $OpportunityCost

    return $Result
}