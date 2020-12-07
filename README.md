# Mars Rovers
## Problem Description
A squad of robotic rovers are to be landed by NASA on a plateau on Mars. This plateau, which is curiously rectangular, must be navigated by the rovers so that their on-board cameras can get a complete view of the surrounding terrain to send back to Earth.

A rover’s position and location is represented by a combination of x and y co-ordinates and a letter representing one of the four cardinal compass points. The plateau is divided up into a grid to simplify navigation. An example position might be 0, 0, N, which means the rover is in the bottom left corner and facing North.

In order to control a rover, NASA sends a simple string of letters. The possible letters are ‘L’, ‘R’ and ‘M’. ‘L’ and ‘R’ makes the rover spin 90 degrees left or right respectively, without moving from its current spot. ‘M’ means move forward one grid point, and maintain the same heading.

Assume that the square directly North from (x, y) is (x, y+1).

### Input
The first line of input is the upper-right coordinates of the plateau, the lower-left coordinates are assumed to be 0,0.

The rest of the input is information pertaining to the rovers that have been deployed. Each rover has two lines of input. The first line gives the rover’s position, and the second line is a series of instructions telling the rover how to explore the plateau.

The position is made up of two integers and a letter separated by spaces, corresponding to the x and y co-ordinates and the rover’s orientation.

Each rover will be finished sequentially, which means that the second rover won’t start to move until the first one has finished moving.

### Output
The output for each rover should be its final co-ordinates and heading.

### Example

#### Input
```
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM
```

#### Expected Output
```
1 3 N
5 1 E
```  
## Solution Design
All the business logic of the solution can be found under `lib` folder. 

The design is oriented in 3 parts:
 * `models` which are used to store information.
 * `services` where logic of different actions is encapsulated in the respective service.
 * `errors` where custom errors are created for error handling purposes.
### Models
For models are used `Expedition` and `Rover` classes. `Expedition` holds information of the plateau surface with starting and ending coordinates, as well as deployed rovers and their respective instructions. `Rover` holds information for the deployment coordinates, deployment orientation, ending coordinates and has the ability to rotate and move.
### Services
Services are classes that execute a desired operation. 

Services are organized based on the domain of the model they serve. In our case services related with `Expedition` can be found under `services/expedition` and services related with `Rover` can be found under `services/rover`
### Errors
Errors are custom Exception classes that derive from `RuntimeError`. The idea behind this is to be able to construct a light error version handling where we mainly check if instructions given to the rover are valid instructions. 
### Testing
For testing purposes `Rspec` has been used all the tests can be found under `spec` folder. 

As well the code is inspected with `Rubocop` with it's configuration `.rubocop.yml`
## Requirements
* Ruby version `2.5.6`
* Bundler version `2.1.4`
## Running Tests
* Run `bundle install`
* Run `rspec`
* Run `rubocop`
## Usage
For purposes of using the code we have created a file `main.rb` which holds a simple script that uses a hard coded input in order to print the solution on the console.

Run the script with:

`ruby main.rb`

The script will print the given input, in case of controlled failure will print a message that something went wrong during execution. After executing all the instructions for all rovers will print in console the state of the rovers.