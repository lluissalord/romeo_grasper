#!/usr/bin/env python

import rospy
import sys
import math

from geometry_msgs.msg import PoseStamped
from object_tracker_msg_definitions.msg import ObjectInfo
from moveit_msgs.msg import RobotTrajectory

from std_srvs.srv import Trigger

import tf
import tf2_ros
import tf2_geometry_msgs

import moveit_commander
import moveit_msgs.msg

class Experiment1:

	def __init__(self, reachVsGrasp, planningTime, list_object_info):
		self.wait_pose_plan = True
		self.wait_pose_target = True
		self.pose_plan = PoseStamped()
		self.pose_target = PoseStamped()

		self.ns = "/romeo_grasper/"

		self.reachVsGrasp = reachVsGrasp
		rospy.set_param(self.ns + 'reachVsGrasp', self.reachVsGrasp)
		self.planningTime = planningTime
		rospy.set_param(self.ns + 'planning_time', planningTime)

		rospy.set_param(self.ns + 'pose_threshold', 0.0) #To don't have problems if is the same position

		self.list_object_info = list_object_info

		if(reachVsGrasp):
			self.filename = "experiment1_reach_data.txt"
		else:
			self.filename = "experiment1_grasp_data.txt"

		string = "reachVsGrasp" + "," + "planningTime" + "," + "x_target" + "," + "y_target" + "," + "z_target" + "," + "x_pose" + "," + "y_pose" + "," + "z_pose" + "," + "orientation" + "," + "error"
		f = open(self.filename, 'w')
		f.write(string + "\n")
		f.close()

		'''
		self.robot = moveit_commander.RobotCommander()
		move_group = rospy.get_param(self.ns + 'move_group')
		self.group = moveit_commander.MoveGroupCommander(move_group)
		'''
	
		self.pub = rospy.Publisher('/object_tracker/object_pose', ObjectInfo, queue_size=10)

		rospy.Subscriber("/pose_plan", PoseStamped, self.callbackPosePlan)
		rospy.Subscriber("/pose_target", PoseStamped, self.callbackPoseTarget)
		rospy.Subscriber("/trajectory", RobotTrajectory, self.callbackTrajectory)

	def main(self):
		rospy.loginfo("Starts with reachVsGrasp: " + str(self.reachVsGrasp))
		i = 0
		while(i < len(self.list_object_info)):
			obj_info = self.list_object_info[i]
			rospy.loginfo("Publish ObjectInfo:")
			rospy.loginfo(obj_info)
			self.pub.publish(obj_info)
			rospy.sleep(5) #Some time to process the message

			#Wait till the plan is done
			success = False
			while(not success):
				rospy.wait_for_service(self.ns + 'abort_plan')
				try:
					service = rospy.ServiceProxy(self.ns + 'abort_plan', Trigger)
					resp1 = service()
					success = resp1.success
				except rospy.ServiceException, e:
					print "Service call failed: %s"%e
				rospy.sleep(1)
			i = i + 1
		rospy.loginfo("Finish with reachVsGrasp: " + str(self.reachVsGrasp))


	def callbackPosePlan(self,data):
		self.pose_plan = data
		self.wait_pose_plan = False
		if(not self.wait_pose_target):
			self.calculateDistance()
		return

	def callbackPoseTarget(self,data):
		self.pose_target = data
		self.wait_pose_target = False
		if(not self.wait_pose_plan):
			self.calculateDistance()
		return

	def callbackTrajectory(self,data):
		self.trajectory = data.joint_trajectory
		self.createDictForJoints()		
		return

	def calculateDistance(self):
		# May be for the graspPlan is not exactly because for the nature of the move_group class
		# is not possible to know the pose_target. So currently is using the position of the block

		x_pose = self.pose_plan.pose.position.x;
		y_pose = self.pose_plan.pose.position.y;
		z_pose = self.pose_plan.pose.position.z;

		x_target = self.pose_target.pose.position.x;
		y_target = self.pose_target.pose.position.y;
		z_target = self.pose_target.pose.position.z;

		distance = math.sqrt(pow(x_target-x_pose,2)+pow(y_target-y_pose,2)+pow(z_target-z_pose,2))

		#rospy.loginfo(self.pose_plan)
		#rospy.loginfo(self.pose_target)
		rospy.loginfo("Distance: " + str(distance))

		self.writeToFile(distance)

		self.wait_pose_target = True
		self.wait_pose_plan = True
		return

	def writeToFile(self, distance):
		if(self.reachVsGrasp):
			string = "1"
		else:
			string = "0"

		string += "," + str(self.planningTime)

		x_target = self.pose_target.pose.position.x;
		y_target = self.pose_target.pose.position.y;
		z_target = self.pose_target.pose.position.z;

		x_pose = self.pose_plan.pose.position.x;
		y_pose = self.pose_plan.pose.position.y;
		z_pose = self.pose_plan.pose.position.z;

		string += "," + str(x_target) + "," + str(y_target) + "," + str(z_target) + "," + str(x_pose) + "," + str(y_pose) + "," + str(z_pose)

		if(self.pose_target.pose.orientation.w > 0.9): #Horizontal pose
			string += "," + "1"
		else:# Vertical pose
			string += "," + "0"

		string += "," + str(distance)

		with open(self.filename, 'a') as the_file:
			the_file.write(string + "\n")
			the_file.close()
		return

	def createDictForJoints(self):
		self.dict_joints = {}
		last_time_index = len(self.trajectory.points)-1
		i=0
		while(i < len(self.trajectory.joint_names)):
			self.dict_joints[self.trajectory.joint_names[i]] = self.trajectory.points[last_time_index].positions[i]
			i=i+1
		return

# The object list only contain position, orientation is always quaternion = [0,0,0,1] (qx,qy,qz,qw)
def posesToObjectInfo(l_poses):
	l_obj_info = []
	i = 0		
	while(i < len(l_poses)):
		obj = ObjectInfo()
		obj.translation.x = l_poses[i][0]
		obj.translation.y = l_poses[i][1]
		obj.translation.z = l_poses[i][2]
		obj.rotation.x = 0
		obj.rotation.y = 0
		obj.rotation.z = 0
		obj.rotation.w = 1
		obj.confidence = 1

		l_obj_info.append(obj)
		i = i + 1
	return l_obj_info

def addVerticalObj(l_obj_info):
	l_new = l_obj_info[:]
	i = 0		
	while(i < len(l_obj_info)):
		obj = ObjectInfo()
		obj.translation = l_obj_info[i].translation
		obj.confidence = l_obj_info[i].confidence
		obj.rotation.x = 1./math.sqrt(2)
		obj.rotation.y = 0
		obj.rotation.z = 0
		obj.rotation.w = 1./math.sqrt(2)

		l_new.append(obj)
		i = i + 1
	return l_new

if __name__ == '__main__':
	#arg = sys.argv[1]
	# TODO: Make list of obj_info

	l_poses = []
	l_poses.append([-0.3, 0.0, 0.5])
	l_poses.append([-0.25, 0.0, 0.45])
	l_poses.append([-0.20, 0.0, 0.40])
	l_poses.append([-0.15, 0.0, 0.35])
	l_poses.append([-0.05, 0.0, 0.35])
	l_poses.append([-0.3, -0.1, 0.5])
	l_poses.append([-0.25, -0.1, 0.45])
	l_poses.append([-0.20, -0.1, 0.40])
	l_poses.append([-0.15, -0.1, 0.35])
	l_poses.append([-0.05, -0.1, 0.35])
	list_object_info = posesToObjectInfo(l_poses)
	list_object_info = addVerticalObj(list_object_info)
	
	# I don't know why the first one is not used so I put one that is useless.
	obj = ObjectInfo()
	list_object_info.insert(0,obj)

	try:
		rospy.init_node('experiment_1', anonymous=True)
		experimentReach = Experiment1(True, 60, list_object_info)
		experimentReach.main()

		del list_object_info[0]

		experimentGrasp = Experiment1(False, 60, list_object_info)
		experimentGrasp.main()
		
	except rospy.ROSInterruptException:
  		print "program interrupted before completion"
