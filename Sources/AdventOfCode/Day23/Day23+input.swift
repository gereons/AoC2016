//
// Advent of Code 2016 - input for day 23
//

extension Day23 {
static let data = """
cpy a b
dec b
cpy a d
cpy 0 a
cpy b c
inc a
dec c
jnz c -2
dec d
jnz d -5
dec b
cpy b c
cpy c d
dec d
inc c
jnz d -2
tgl c
cpy -16 c
jnz 1 c
cpy 75 c
jnz 85 d
inc a
inc d
jnz d -2
inc c
jnz c -5
"""
}
