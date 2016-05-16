#include "romeo_grasper/romeograspingobject.h"

int main(int argc, char** argv)
{
    ros::init(argc, argv, "romeo_grasper_object");
    //ros::NodeHandle nh;

    ros::AsyncSpinner spinner(1);
    spinner.start();

    RomeoGrasperObject romeo_grasper = RomeoGrasperObject();
    romeo_grasper.exit();
    return 0;
}
