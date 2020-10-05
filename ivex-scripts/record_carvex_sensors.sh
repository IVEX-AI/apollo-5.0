# Copyright 2020, IVEX NV
# All rights reserved.
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential

SENSORS="all"

for i in "$@"
do
case $i in
    -s=*|--sensors=*)
    SENSORS="${i#*=}"
    shift # past argument=value
    ;;
    *)
esac
done

HELP="--help"

if [ "$1" = "$HELP" ]; then
	echo "The required parameters are:
	--sensors | -s: sensors modules to be recorded (all, sensor-setup, cameras-only - default: all)"

	exit
fi

if [ "$SENSORS" == "all" ]; then
	cyber_recorder record -a

elif [ "$SENSORS" == "sensor-setup" ]; then
	cyber_recorder record \
		-c /apollo/sensor/gnss/best_pose \
		-c /apollo/sensor/gnss/odometry \
		-c /apollo/sensor/gnss/corrected_imu \
		-c /apollo/sensor/gnss/imu \
		-c /apollo/sensor/gnss/ins_stat \
		-c /apollo/sensor/lidar128/compensator/PointCloud2  \
		-c /apollo/sensor/radar_front \
		-c /apollo/sensor/radar_rear \
		-c /apollo/sensor/camera/front_6mm/image/compressed \
		-c /apollo/sensor/camera/front_12mm/image/compressed \
		-c /apollo/sensor/camera/left_front/image/compressed \
		-c /apollo/sensor/camera/right_front/image/compressed \
		-c /apollo/sensor/camera/rear_6mm/image/compressed \
		-c /tf \
		-c /tf_static

elif [ "$SENSORS" == "cameras-only" ]; then
	cyber_recorder record \
		-c /apollo/sensor/gnss/best_pose \
		-c /apollo/sensor/gnss/odometry \
		-c /apollo/sensor/gnss/corrected_imu \
		-c /apollo/sensor/gnss/imu \
		-c /apollo/sensor/gnss/ins_stat \
		-c /apollo/sensor/camera/front_6mm/image/compressed \
		-c /apollo/sensor/camera/front_12mm/image/compressed \
		-c /apollo/sensor/camera/left_front/image/compressed \
		-c /apollo/sensor/camera/right_front/image/compressed \
		-c /apollo/sensor/camera/rear_6mm/image/compressed \
		-c /tf \
		-c /tf_static
else
	echo "Sensor record configuration '$SENSORS' not supported, should be 'cameras-only', 'sensor-setup' or 'all'."
fi
