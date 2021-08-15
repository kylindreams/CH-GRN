%计算所有pattern的和
function [final_pattern,pattern_target] = cal_pattern(target,robot,pattern_simulationrobot)


pattern_target = generate_pattern(target);
pattern_robot = generate_robotpattern(robot);   

final_pattern = pattern_target + pattern_robot + pattern_simulationrobot*0.2;