This is a visualisiation for Newton's fractal with the equation of x^3 - 1

# How to use:

- Clone the gitRepo and run the executable in builds/windows
- Or Download newtonFractal.zip from the releases page
- Click the increase itterations button to add detail to the fractal
- Click decrease itterations to reduce detail
- You can use a custom integer number of itterations by typing it in

# How it works:

- Newton's fractal is based on Newton's method and imaginary numbers
- Newton's method is a way to approximate the zeros of a polynomial function by taking an inital guess then moving it closer to a zero
- If the initial function is f(x) and the derivetive is f'(x) then you adjust your guess by -(f(x)/f'(x)) where x is the newest guess
- To make the fractal each pixle is assosiated with a complex number where x position is the real part and y position is the imaginary part
- Newton's method is then used on each pixle until the max number of itterations has been reached
- Each pixle is then colored based on which zero of the function it is closest too
- The simulation is a shader so that it can be run in parallel on the gpu so it can color the pixles much faster then if it was ran on the cpu
- The coolest part of the simulation is that as the max number of itterations reaches infinety, at any point two colors meet all colors actually meet.

# Resourses I used:

- https://www.youtube.com/watch?v=-RdOwhmqP5s&t=93s
- https://en.wikipedia.org/wiki/Newton_fractal
- https://en.wikipedia.org/wiki/Newton%27s_method
