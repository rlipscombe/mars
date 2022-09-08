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

function turn_left(d) {
    if (d == "N")
        return "W"
    else if (d == "E")
        return "N"
    else if (d == "S")
        return "E"
    else if (d == "W")
        return "S"
    else
        error()
}

function turn_right(d) {
    if (d == "N")
        return "E"
    else if (d == "E")
        return "S"
    else if (d == "S")
        return "W"
    else if (d == "W")
        return "N"
    else
        error()
}

function move_forward(r) {
    switch(r[3]) {
    case "N":
        r[2]++
        break
    case "E":
        r[1]++
        break
    case "S":
        r[2]--
        break
    case "W":
        r[1]--
        break
    default:
        error()
    }
}

parser_state == ROBOT_INSTR {
    # run the robot
    len = split($0, instructions, "")
    for (i = 1; i <= len; i++) {
        # printf("robot %d (%d %d %s) %s\n", robot_id, robot[1], robot[2], robot[3], instructions[i])

        switch(instructions[i]) {
        case "L":
            robot[3] = turn_left(robot[3])
            break
        case "R":
            robot[3] = turn_right(robot[3])
            break
        case "F":
            move_forward(robot)
            break
        default:
            error()
        }
    }

    # where did the robot end up?
    printf("%d %d %s\n", robot[1], robot[2], robot[3])

    # go back to looking for the next robot
    parser_state = ROBOT_INIT
    next
}
