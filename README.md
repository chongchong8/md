### Back to [Table of content](https://chongchong8.github.io/home/)
# Hot to install gromacs
[one video](https://www.youtube.com/watch?v=MoRXFKqQPIk&list=PLOzRYVm0a65fCJJQendwEEcSrC8iwvgBn&index=35)
# Manual reading guidelines
* Chapter 1: Very general introduction. Is it helpful for the practical calculation skills? No. Thus, it is recommended to just through once and put more effort on the other important chapters. Recommendation **%**%%%%%
* Chapter 2: Mention the units. Recommendation **%%**%%%%

# Useful information
## On youtube
### Video 1. Free Energy of Solvation of Methane
* from one [31 minutes video](https://www.youtube.com/watch?v=zodHyKUyUbM)
* details of this video: 
  It talks the thermodynamcs integration method, which is used to calculate the hydration free energy.
## Gromacs Tutorials
* from Justin A. Lemkul [7 tutorials available](http://www.mdtutorials.com/gmx/index.html)

### Comprehensive Video
* start from [video 31](https://www.youtube.com/watch?v=nKYrzrwaRmc&list=PLOzRYVm0a65fCJJQendwEEcSrC8iwvgBn&index=33)

# Topic 1 Solvation energy
Online materials:
> First from Prof. B. L. Tembe Bombay [31 minutes video](https://www.youtube.com/watch?v=zodHyKUyUbM)

> Second from Justin A. Lemkul [tutorial 6](http://www.mdtutorials.com/gmx/free_energy/index.html)
# be careful with the format of pdb file
<a href="http://tinypic.com?ref=2vjdhg5" target="_blank"><img src="http://i63.tinypic.com/2vjdhg5.png" border="0" alt="Image and video hosting by TinyPic"></a>
# Setting mdp file
Some popular parameters. I don't have to summarize it here. For reference, click link [here](http://manual.gromacs.org/documentation/2018/user-guide/mdp-options.html)
## Run control
integrator               = steep 
integrator               = sd       ; Langevin dynamics
## I will summarize several examples for exercise
### Example 1: Water
This example is based on [this video]https://www.youtube.com/watch?v=zCTGd5xYwoQ&list=PLOzRYVm0a65fCJJQendwEEcSrC8iwvgBn&index=36.

The unit packmol pdb file is angstrom while gromacs uses nanometer.

## Practice makes perfect
1. 6 tutorials [here]https://www.svedruziclab.com/tutorials/gromacs/

2. 7 tutorials [here]http://www.mdtutorials.com/gmx/index.html

3. using VMD [here]http://www.ks.uiuc.edu/Training/Tutorials/vmd/tutorial-html/index.html

## Notes
[editconf命令可以用于gro文件与pdb文件的相互转换。用-f指定源文件，-o指定所需文件名即可]https://www.cnblogs.com/w-guangyu/p/7787240.html

