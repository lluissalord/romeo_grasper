cmake_minimum_required(VERSION 2.8.3)
project(romeo_grasper)

## Find catkin macros and libraries
find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
  std_srvs
  geometry_msgs
  moveit_ros_planning_interface
  moveit_visual_tools
  object_tracker_msg_definitions
  moveit_simple_grasps
  naoqi_bridge_msgs
#  romeo_moveit_actions
#  transform
)

catkin_python_setup()

add_message_files(
  FILES
	VisualTable.msg
)

generate_messages(
   DEPENDENCIES
)

include_directories(include ${catkin_INCLUDE_DIRS})

# What will find when others package find_package this
catkin_package(
	INCLUDE_DIRS include
	LIBRARIES ${PROJECT_NAME}
	CATKIN_DEPENDS roscpp rospy geometry_msgs std_msgs std_srvs moveit_ros_planning_interface moveit_visual_tools object_tracker_msg_definitions moveit_simple_grasps naoqi_bridge_msgs #romeo_moveit_actions #transform
)

add_executable(romeo_grasper
				src/romeograsperdriver.cpp
				src/romeograsper.cpp
				src/modeledobject.cpp
				src/romeosimulator.cpp
				src/romeo_moveit_actions/action.cpp
				src/romeo_moveit_actions/metablock.cpp
				src/romeo_moveit_actions/postures.cpp)
add_dependencies(romeo_grasper ${catkin_EXPORTED_TARGETS})
target_link_libraries(romeo_grasper ${catkin_LIBRARIES})

install(TARGETS romeo_grasper
        RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})

install(DIRECTORY config launch
   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)
