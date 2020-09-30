# sensewear

Application to capture accelerometer data on wearos for extended period of time.

## Current Features

- Sample Accelerometer data at 50Hz.
- Calculate the mean of the accelerometer data per second, and get the resultant.
- Convert the data into a csv file.
- Upload the data to firebase storage every 15 minutes.
- Device set to always on state, so it can collect data until it runs out of battery.

## Future

- Collect heart rate along with inertial sensors data.
- Optimize app to be more energy effecient.