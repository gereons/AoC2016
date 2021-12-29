#!/bin/sh

YEAR=2016
DAY=$1

if [ -z "$DAY" ]; then
    DAY=$(date +%d)
fi

echo "getting puzzle input for day $DAY"

D2=$(printf "%02d" $DAY)

TMP=.input.$$.tmp

curl -s https://adventofcode.com/$YEAR/day/$DAY/input --cookie "session=$AOC_SESSION" >$TMP

(
cat <<END
//
// Advent of Code $YEAR - input for day $D2
//

extension Day$D2 {
static let data = """
END

cat $TMP

cat <<END
"""
}
END
) >Sources/AdventOfCode/Day$D2/Day$D2+input.swift

rm $TMP
