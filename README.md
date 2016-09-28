# Price Optimizer
After asking potential customers what they would be willing to pay for a certain product, this script calculates the optimal price to set. Most managers pick prices based on guesses, averages, or competition. This simple proof-of-concept chooses the best price by maximizing profit in a data-driven approach.

## Background
This script was written in class (BUSM 478B at BYU) during a discussion on the same topic. The discussion focused more on creating a regression line to base the optimizations off of. The problem with that method is that it adds additional assumptions and uncertainties regarding the type of regression to make and which outliers to reject. It also adds an unneeded layer of math that could be accomplished much more simply and accurately with discreet processes (such as this script). In any case, the faults in the sampled data will always force the calculated optimal price to be no more than an approximation.

## Usage
This script can process a .csv spreadsheet or data inputed directly as arguments.

### Spreadsheet
To read in a spreadsheet, follow the following format:
```bash
./pricing.rb -f <filename> [-c <cost>]
```
This reads in a file and sets the manufacturing cost if given (defaults to $0). For example, to process the file included with this script given a manufacturing cost of $20 do the following:
```bash
./pricing.rb -f example.csv -c 20
```
The script will automatically find the data column labeled "willingness to pay" or "wtp" and use that as the input data.

### Command Line
To pass in the willingness-to-pay data directly over the command line, follow the following format:
```bash
./pricing.rb [-c 20] <wtp1> <wtp2> ...
```
This uses the prices given by wtp1, wtp2, and so on as the inputs to the script. In addition, the manufacturing cost can also be set with the "-c" argument (defaults to 0).
