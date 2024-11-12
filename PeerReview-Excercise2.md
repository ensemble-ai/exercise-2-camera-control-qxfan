# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* James Jasper Fadden O'Roarke
* *email:* jfaddenoroarke@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The position lock camera controller always centers on the player vessel without stutter. `draw_camera_logic` enables a 5x5 unit cross at the center of the screen.

___
### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The side scrolling camera properly restricts the players movement within a z-x plane box while also pushing them forward from the left side when idle. The only slight issue
is that the player stutters when moving into the right bound of the playing field.

___
### Stage 3 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The lerp smoothed position lock camera works as expected. It normally follows the player at a set `follow_speed` but switches smoothly to `catchup_speed` when the player is idle.
It has a slight jitter during normal movement though, and `follow+speed` has no modifier to allow it to keep up when the player moves at hyper speed (resulting the player very quickly going off-screen).
Leash distance appears to not work as intended as there is no measure to prevent the player from going infinitely beyond the screen. Draw logic works as expected.

___
### Stage 4 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The target focus camera works mostly as expected. It leads in front of the player at a high enough `lead_speed` but then follows the player again at a `catchup_speed` when idle.
However, it has the same problems as the lerp smoothed position lock camera. There is a slight jitter to normal movement, and `lead_speed` has no modifier for hyper speed.
Leashing again doesn't function, so not only does the player go faster than the target focus camera at any high hyper speed multiplier, but simply moving diagonally will 
cause the camera to lead too fast beyond the player and let them fall off-screen. Draw logic works as expected.

___
### Stage 5 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The four way speedup camera partially works as expected. The player moving into the bounding boxes of the camera works perfectly besides minor stuttering. However, the speedup
logic doesn't fully work. The camera properly moves at push_ratio in the direction they are moving, but it doesn't properly respect the bounds of the speedup box. Moving even
within the inner camera box will often lead to the camera moving when it shouldn't. Moving from one side of the bounding box to the other will also move the camera at `push_ratio`
for the entire duration. Occasionally the camera will remain still as it's supposed to. Draw logic works as expected however (technically going beyond the assignment instructions 
in a very useful way).

___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.

### Code Style Review ###

The code near perfectly follows the [GD Script Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html) well.

#### Style Guide Infractions ####

While the title of target_focus.gd is in proper snake case, it does not match its [class name](https://github.com/ensemble-ai/exercise-2-camera-control-qxfan/blob/edbd788d5a6e80b63b01f7e397b320561cc9f124/Obscura/scripts/camera_controllers/target_focus.gd#L1)

#### Style Guide Exemplars ####

The 100 line character limit is never crossed aside from [draw logic mesh code](https://github.com/ensemble-ai/exercise-2-camera-control-qxfan/blob/edbd788d5a6e80b63b01f7e397b320561cc9f124/Obscura/scripts/camera_controllers/target_focus.gd#L60) that was provided with the project

Most style guide conventions are followed, such as variables being named in snake_case and general whitespace (tabs not being mixed with spaces, etc).
___
#### Put style guide infractures ####

___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####

[Cardinal vector lengths](https://github.com/ensemble-ai/exercise-2-camera-control-qxfan/blob/edbd788d5a6e80b63b01f7e397b320561cc9f124/Obscura/scripts/camera_controllers/auto_scroll.gd#L8) used in certain
camera controllers would ideally be private (have an underscore before their variable name).

Only 4 commits were amde to the project since its creation, two of which had very vague names. It's ideal to split work into chunks and commit whenever possible.

#### Best Practices Exemplars ####

I could not find any variables that were untyped (besides cpos and such which were untyped in the bounding box camera example).

Instead of using things like "top_left.x" in any camera controllers, there are 
[cardinal vector length](https://github.com/ensemble-ai/exercise-2-camera-control-qxfan/blob/edbd788d5a6e80b63b01f7e397b320561cc9f124/Obscura/scripts/camera_controllers/auto_scroll.gd#L8) for readability purposes.





