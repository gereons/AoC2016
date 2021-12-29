//
// Advent of Code 2016 - input for day 24
//

extension Day24 {
static let data = """
#####################################################################################################################################################################################
#...........#...#.....#.....#.....#....7#.................#.............#.....#.#.#...#.#.#.......#.......#.........#.....#.....#...#.....#.#.#.....#.......#.#.....#.....#.#.......#
#.#####.###.#####.###.#.#.#.#.#.#.#.###.###.#.#.#######.###.#.#####.#.#.#.#.###.#.#.#.#.#.#.#####.#.#.###.#.###.#.#.#.###.#.#.###.#.#.#####.#.#.#.#.#####.###.#.#.###.#.#.#.#.#.###.#
#.......#...#...#.#.....#.#.#...#...#...#.....#...#.......#.......#.......#.#.....#.#.....#.........#...#...#.#...#.#.#.....#.....#.......#.#...#.#.......#...#.#...#.#...#.#.#.....#
#.#.#.###.#.#.#.###.###.#.#.###.#.###.#.#.#.###.#.#.#.#.#.#######.#.#####.#.#.###.#.#.###.#.#.#####.#.#.#####.#.#.#.#.#.#.#.#.#.#####.#.#.###.#.#.#.###.###.#.#.#.#.#.#.#.#.#.#.#.#.#
#...........#.#.....#.....#...#...#.#.....#.#.#.........#.....#...#...#...#...#...#.#.....#.#.....#...#.........#...#.........#.#.#...............#.....#.#...#.#...#.#.......#.#...#
#.#####.###.#.###########.#.#.#.#.#.#.#.###.#.#######.#.#.#.#.#.###.#.#.#.#.#.#.#.###.#.#.#.#########.###.#.#####.#.#############.#.#.#.#.#.#.###.#.#.#.#.###.#.#.#.#.#.#####.#.###.#
#...#.#.....#....4#.......#...#.......#.......#...#.......#...#.#...#...#...#.....#.#.#...#.....#...#...#...#...#...#.............#...#...#...#...#.#...#.#...#...#.#...#..0#.....#.#
#.#.#.###.#.#.#.#.###.###.#.###.#####.#.###.#.#.#.#.#####.#.#.###.###.#.###.###.###.###.#.#.#.#.###.#.#.#.#.#.#####.#.#.#####.#.#.###.#.#.#.###.#.#.#.#.###.#.#.#####.#.#.###.#.#.###
#.#...#...........#...#.....#.#...#.#.#.#.#.......#...........#.....#.....#.#.#.#.......#.#...#.....#.#.......#.....#...#.......#.#.....#.#.#.....#.#.#.#.#.#.#.........#.#...#.#.#.#
#.#.#.#.#########.###.#.#.###.#.###.#####.###.#.#.#.###.#.#.###.###.###.#.###.#########.#.###.#.#.#.#.#.#.#.#.#########.#.#####.#.#####.#.#.###.#.#.#.#.#.#####.###.#.#.#.###.#.#.#.#
#.#.....#.....#.......#.#...#.....#...........#.#.#.....#...#.#.........#.#.#.#.........#.#.......#.......#...#...#...#...#.#...........#.#.....#.#.......#...........#...#...#.....#
#.#####.#.#.#.#####.#.#.#.#.#.#.#.#.#.#.#.#.###.###.###.#####.###.###.#.###.#.#.#.###.#######.###.#.#.#.#####.#.#####.#.###.#.#####.#.#.#.#########.#.###.#.#.#.#.#.#.###.#####.###.#
#.#...#.........#.....#...#.......#...#.#...#.......#...#...#.#.......#.......#...#.....#...........#...#.#.....#.................#.#...#.#.........#.#...#.#.#.#.......#.#.....#...#
#.#.#.#.#.###.#.#.###.#.#.#.#####.#.###.#.###.###.###.#######.#.###.###.#.###.#.#.###.#.#.#####.###.#.#.#.#.###.#.###.#######.#.#.#.#.#.#.#.#.#.#######.#.#.#.#.###.#.#.#.###.#.#.###
#.....#.#...#.....#...#.#.#.....#.#.#...#.#.#...........#.....#.#...#.................#.#.#...#.........#.......#.#...#.......#.#.#.....#...#...........#.#...#.........#...........#
###.#.#.#.#.###.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#####.###.###.#.###.#.#.#.#.###.#.#######.#.#####.###.#.#.#.#.#.#.#####.#.#.#.###.#.#.#######.#.#.#.#####.#.###.#.###.###.#.#.###.#####
#.#.#.#.#...#.....#...#...#...#...#.#...#.#.#.......#...#.#...............#...#.....#.....#.....#.....#.#.#.......#...#.#.....#.....#.........#...#...#.#.......#...#.....#.....#...#
#.#.#.#.###.###.#.#.#.#########.#.#.#########.#.#.###.#.#.#.###.#####.###.#.#.#.#.###.#.#.#.#.###.#.#.#.#.#.#.#####.###.#.#.#.###.#.#.#.#.#.#.###.#.#.#.###.#.###.#####.###.#.#.#.#.#
#.....#.....#.....#.......#...........#...#...#.#.....#.#.......#.......#.#.#.........#.............#...#.#.#.....#.....#...#...#.......#...#.......#...#...#...#....1#.....#...#.#.#
###.#.#.#######.#.#.#.###.#.#.###.###.#.###.#.#.#.#.#.#.###.###.###.#.#.#.#.#.#.#.#.#####.#####.###.#.###.#.#.#.#.###.###.#.#####.###.#.#.###.###.#######.#.###.###.#.###.#.#.#.###.#
#...#...#5......#.#...#.......#...#.........#.....#...........#...#.#.......#.#...........#...#.......#.....#.#.......#...#.....#.......#...#.#.................#.....#...#...#.....#
#.###.#.#.#.#####.#####.#####.###.#.#########.###.###.#.#.#####.#.#.###.#.###.###.#.#.#.#.#.###.#.#######.#.#.#.#.#.###.#.#.###.#.#####.###.#.#.#.###.#.#.###.#.###.#########.#####.#
#.#.#...#...#.....#.....#.#.....#.#.....#.........#...#...#.....#.#.#.......#.......#.......#...#.........#...#...#.....#.#.#...#.........#.#.#.#.#.....#.#.....#.........#.....#...#
###.###.###.#.#.#.#.###.#.#.#.#.#.#.#.#.#.#####.#.#.#.#.###.#.#####.#.###.#.#.###.#.#.#.#.#.###.#.#.###.#.#########.#.#####.###.#.###.#####.#.#.#.#.#.#.###.#.#.#.#.#.###.#.#.#.#.#.#
#.#.#.#.......#...#.#...#.....#.#.................#.#.........#.....#...#...#.#.....#.....#.....#...#...#.....#...#...#...#.#.#...#...#...#...#...#...#.#...#.......................#
#.###.#############.#.#######.#.###.###########.#.#.###.###.#.#.###.###.#.###.###.#.#.###.#.#.###.#.#.#.###.#.###.#.#.#.#.#.#.#.###.#.#.#.#.#.#.#.#.#.#.#.###.###.#.#.#.#.#.#.#.#.#.#
#.....#.#.......#...............#.....#...........#...#.#.#...#...#...#.#.#...#.......#...#...#.....#.....#.#.#...............#.#...#.....#.....#.#.#.#.......#...#.#...#...#.....#.#
#.#.###.#.###.#.#.#######.#.###.#.###.#.#.#.#.#####.#.#.#.#.#.#.#.###.#######.#.#.###.###.#.#.#.#######.#.###.#.#.###########.###.#########.#.#####.#.#.#.#.#.#.#.#.#.#####.###.#.###
#...#...#.#...............#.#.......#.#...#.#.......#.#...#.#.....#.....#.#.......#.........#.#.#...#.#...................#...#...#.............#.......#.......#.#...#...#.....#.#.#
#.#.#####.#.#######.#.###.#.#####.#.#.#.#.###.#.#.#.###.#.#.#####.###.###.#.#.#.#.#.#####.#.###.#.#.#.#.###.#.#####.#######.#.###.#.#.#.#.#####.#.#####.###.#######.#.#.#.#.###.#.#.#
#.........#.#...#.#.......#...#...#...........#.....#.....#.......#.....#.....#.#.#...#.#...#.....#.....#.....#...#.#.........#.....#.....#.#.#.....#...#...#.......#.#.#.....#...#.#
###.#######.#.#.#.#.###.#.###.#.###.###.#.###.#.#.#.#.#.#.###.#.###.#.#.#.###.###.#.#.#.#.###.#.#.###.#.#.#.#.#.#.#.#.#.#.#####.#####.###.#.#.#.#####.###.###.#.#.#####.#.#####.#.###
#...#.......#.......#...#...#.........#.....#...#...#...#.#...#.........#...#.....#...#.#.#.#.#...#.....#.#.....#.....#.#.........#.....#.#.#.....#...#...#.......#.#3....#...#.....#
#.###.###.#####.###.###.###.#.###.#.###.###.#.###.###.#.#.#######.#.#.#.#.###.#.#.#.###.###.#.#.###.#.#.#.#####.###.###.###.#.###.#.#.###.#.#.#####.###.#.#.###.#.#.###.#.#.#.###.#.#
#.#...#.....#.#...#...#.#...........#...#.#...#.#.#.....#.#.......#.#.....#...#...#.....#...#.......#.........#...#.#...#.#.#.#.....#.....#.......#.........#.....#.....#.#...#.#...#
#.#.#.#####.#.###########.###.#.#####.###.###.#.###.###.#.#.#####.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.###.#.###.#.#.#.#.###.#.#.#.#.#####################.###.###.###.#.#.#.#.#.#
#.#...#.#...#.....#...#...#.....#.......#.......#.....#.#...#.....#...#.....#...#.......#...#.#...#.#...#.#...........#...#.#...#.#.......#.........#.#.......#...........#...#...#.#
###.###.#.#.#.#.#.#.#####.#.#.#.###.#.#######.#.###.#.#####.#.###.###.#.#.###.#.#.#.###.#.#######.#.#.#.###.###.#.#######.#.#.#.#.#.#.###.#.#.#.#.#.#.#.#.#.#.###.#.#.###.###.#.#.###
#.#...#.......#.#...#.#.........#.........#...#.#...#.........#.#...#...#.........#...#.....#.......#...#.....#.....#...........#..2#.....#.#.....#...#.#.....#.......#...#...#...#.#
#.#.#.#.#.#.#.#.###.#.###.#.###.#.#.###.#.#.#.#.#.#.###.#.#####.#.###.###.#.###.#.#.#.#####.#.#.###.#.###.###.###.#.#####.#.#####.#####.#.#.#.#.#.###.#.#.#####.#.#.#.#.###.#.#.###.#
#.#..6#.........#...#.#.......#.#.......#.........#...#.....#.#...#...#.#.#.....#.....#.#.........................#.......#...#.#.........#.#...#...........#...#.....#.....#...#...#
#####################################################################################################################################################################################
"""
}
