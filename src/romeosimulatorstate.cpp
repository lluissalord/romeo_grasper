#include "romeo_grasper/romeosimulatorstate.h"

#include <actionlib/client/simple_action_client.h>
#include <actionlib/client/terminal_state.h>
#include <sensor_msgs/JointState.h>
//#include <moveit/robot_state/conversions.h>

RomeoSimulatorState::RomeoSimulatorState(ros::NodeHandle nh, std::string trajectory_topic, std::string joints_topic, std::string state_topic)
{
    uint32_t queue_size = 10;
    traj_sub_ = nh.subscribe(trajectory_topic, queue_size, &RomeoSimulatorState::callbackUpdateTrajectory, this);
    joints_sub_ = nh.subscribe(joints_topic, queue_size, &RomeoSimulatorState::callbackUpdateState, this);
    robot_state_pub_ = nh.advertise<moveit_msgs::DisplayRobotState>(state_topic, 1, true);

    //have_robot_state_ = false;

    //pub_thread_ = boost::shared_ptr<boost::thread>(new boost::thread (boost::bind(&RomeoSimulatorState::publishState, this)));
}

//void RomeoSimulatorState::publishState()
//{
//    ros::Rate loop_rate(0.5);
//    while(ros::ok)
//    {
//        if(have_robot_state_)
//        {
//            robot_state_pub_.publish(romeo_state_msg_);
//        }

//        ros::spinOnce();
//        loop_rate.sleep();
//    }
//}

void RomeoSimulatorState::callbackUpdateState(sensor_msgs::JointState data)
{
/*
    moveit::core::RobotState romeo_state;
    have_robot_state_ = moveit::core::jointStateToRobotState(data, romeo_state);
    moveit::core::robotStateToRobotStateMsg(romeo_state, romeo_state_msg_, true);
*/
    // TODO: With this way it cannot attach object (I think)
    romeo_state_msg_.state.joint_state = data;
    romeo_state_msg_.state.is_diff = true;

    robot_state_pub_.publish(romeo_state_msg_);
}

void RomeoSimulatorState::callbackUpdateTrajectory(moveit_msgs::RobotTrajectory data)
{
    // If the first time is 0, the trajectory is not done by Romeo
    // so I increment all the time in a small step to have a delay
    for(int i = 0; i < data.joint_trajectory.points.size(); i++)
    {
        data.joint_trajectory.points[i].time_from_start += ros::Duration(0.01);
    }

    traj_goal_.trajectory = data.joint_trajectory;
    traj_goal_.relative = 0; // Absolute coords
    ROS_INFO_STREAM("Trajectory updated");
}

bool RomeoSimulatorState::executeTrajectory(std::string action_topic)
{
    actionlib::SimpleActionClient<naoqi_bridge_msgs::JointTrajectoryAction> trajectory_ac_(action_topic, true);

    ROS_INFO("Waiting for action server to start.");
    // wait for the action server to start
    trajectory_ac_.waitForServer(); //will wait for infinite time

    ROS_INFO("Action server started, sending goal");

    trajectory_ac_.sendGoal(traj_goal_);

    //wait for the action to return
    bool finished_before_timeout = trajectory_ac_.waitForResult(ros::Duration(30.0));

    if (finished_before_timeout)
    {
        actionlib::SimpleClientGoalState state = trajectory_ac_.getState();
        ROS_INFO("Action finished: %s",state.toString().c_str());

    }
    else
        ROS_INFO("Action did not finish before the time out.");

    return finished_before_timeout;
}
