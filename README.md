# romeo_grasper

This repository is part of my Master Thesis during Master in Industrial Engineering (Automation and Robotics). You can find the pdf [here](https://github.com/lluissalord/romeo_grasper/blob/master/Report/TFM.pdf).

## Abstract

Romeo as humanoid robot, which has for main goal help people who has some kind ofdisability, needs to be capable to grasp objects. Considering that it has led to do this firstapproach to grasp with Romeo. Moreover, it is wanted to grasp object which has beenrecognised by the RTM software (Recognition, Tracking and Modelling Objects) with aRomeo camera or an external one. This approach is included in the ROS framework as anindependent package namedromeo_grasperwhose code is free to be shared or improved.

The general idea of the approach starts with the RTM software getting the position,on camera reference, of the object, which has to be previously modelled or at least inthe database. Then, this pose is transformed on robot reference and sent to MoveIt, thatcombined with the Rviz simulator and some ROS packages for Romeo, moves the arm ofthe robot to an optimal position for the grasp. Currently, it is used the IK solver fromthe KDL library, but here it is also explained how has been tried to implement the IKFastsolver on Romeo, but without success.

Finally, it is achieved to make work together all the systems, but the grasp has asome imprecision, producing that sometime it cannot be accomplish. However, in theexperiments, it has been discerned where this inaccuracy comes from and it has beenproposed some ways to reduce it.  Furthermore, some guidelines has been set to leadRomeo to achieve a grasp using machine learning and allowing it to accomplish its goal,help the ones who need it.

## License

The romeo_moveit_actions folders are from https://github.com/ros-aldebaran/romeo_moveit_actions so they are under their own license and not included in this package license.

TODO:
- Fix the problem to can link properly the romeo_moveit_actions package
