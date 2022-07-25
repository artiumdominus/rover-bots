# Test Rover

## Problem

A squad of robotic rovers are to be landed by NASA on a plateau on Mars. This plateau, which is a curiously rectangular, must be navigated by the rovers so that their on-board cameras can get a complete view of the surrounding terrain to send back to Earth.

A rover's position and location is represented by a combination of x and y co-ordinates and a letter representing one of the four cardinal compass points. The plateau is divided up into a grid to simplify navigation. An example position might be 0, 0, N, which means the rover is in the bottom left corner and facing North.

In order to control a rover, NASA sends a simple string of letters. The possible letters are 'L', 'R' and 'M'. 'L' and 'R' makes the rover spin 90 degrees left or right respectively, without moving from its current spot. 'M' means move forward ore grid point, and maintain the same heading.

Assume that the square directly Noth from (x, y) is (x, y+1).

## Input

The first line of input is the upper-right coordinates of the plateau, the lower-left coordinates are assumed to be 0, 0.

The rest of the input is information pertaining to the rovers that have been deployed. Each rover has two lines of input. The first line gives the rover's position, and the second line is a series of instructions telling the rover how to explore the plateau.

The position is made up of two integers and a letter separated by spaces, corresponding to the x and y co-ordinates and the rover's orientation.

Each rover will be finished sequentially, which means that the second rover won't start to move until the first one has finished moving.

## Output

The Output for each rover should be its final co-ordinates and heading.

## Example

### Test Input

```
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM
```

### Expected Output

```
1 3 N
5 1 E
```

## Solution

Some assumptions was made about the problem:
1. A rover occupy exactly one cell in the grid.
2. The behavior of a rover when colliding with the edge of the plateau or with another rover, is to not move from his current spot
3. A rover will just land in the plateau and execute his instructions when the previous finish.

Ruby version: `3.1.0`
RSpec version: `3.11`

How to execute the program:
- Use the command `$ ruby app.rb`, then inform the file name (or path and name)

How to test:
- Install RSpec and use the command `$ ruby specs.rb`
- Alternatively you can use the command for each `_spec.rb` file individually: `$ ruby spec/<name>_spec.rb`

