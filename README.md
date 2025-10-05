## `task_R_controller`

**Input**

`SW1, SW3` - Switch inputs to start/stop the movement

`clk` - Basys3 Clock

`x, y` - Current $x, y$ coordinates

**Output**

`pixel_data` - Color for the next pixel

## `display_group_id`

**Input**

`clk` - Basys3 Clock

**Output**

`an` - Pins to control which digit is on.

` seg`- Pins for the 7 segment + dp.
