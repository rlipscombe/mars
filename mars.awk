#!/usr/bin/env -S gawk -f
BEGIN {
    GRID = 0; ROBOT_INIT = 1; ROBOT_INSTR = 2;
    parser_state = GRID;
    robot_id = 0;
}

# Looking for the grid definition; place the two numbers in grid[1] and grid[2]
parser_state == GRID && match($0, /([0-9]+) ([0-9]+)/, grid) {
    # print "grid: x: " grid[1] " y: " grid[2]
    parser_state = 1
    next
}

# Looking for a robot initialisation; place the two coordinates in robot[1] and robot[2]; direction in robot[3]
parser_state == ROBOT_INIT && match($0, /([0-9]+) ([0-9]+) ([NESW])/, robot) {
    # print "robot-init: " robot[1] robot[2] robot[3]
    parser_state = ROBOT_INSTR
    robot_id++;
    next
}

parser_state == ROBOT_INSTR {
    # run the robot
    len = split($0, instructions, "")
    for (i = 1; i <= len; i++) {
        printf("robot %d: %s\n", robot_id, instructions[i])
    }

    # go back to looking for the next robot
    parser_state = ROBOT_INIT
    next
}
