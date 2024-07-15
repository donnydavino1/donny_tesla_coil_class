import matplotlib.pyplot as plt
import matplotlib.animation as animation
import csv
import time
import pandas as pd

# Parameters
x_len = 3000         # Number of points to display
y_range = [0, 150]  # Range of possible Y values to display

# Create figure for plotting
fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
x_value = list(range(0, 3000))
y_value = [0] * x_len
ax.set_ylim(y_range)

# Create a blank line. We will update the line in animate
line, = ax.plot(x_value, y_value)

# Add labels
plt.title('Temperature over Time')
plt.xlabel('Samples')
plt.ylabel('Temperature (deg C)') #Change to F here if desired.

# This function is called periodically from FuncAnimation
def animate(i, y_value):
    data = pd.read_csv('data_1s.csv')
    x_value = data['x_value']
    y_value = data['y_value']

    # Add y to list
    ##########y_value.append(y_value)

    # Limit y list to set number of items
    y_value = y_value[-x_len:]

    # Update line with new Y values
    line.set_ydata(y_value)

    return line,

# Set up plot to call animate() function periodically
ani = animation.FuncAnimation(fig,
    animate,
    fargs=(y_value,),
    interval=500,
    blit=True)
plt.show()
