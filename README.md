# mathematical_modeling_outreach_2023

This repository contains an outreach activity designed to introduce students to mathematical modeling using MATLAB, based upon the work in the paper "**Beaching model for buoyant marine debris in bore-driven swash**" by Davidson et al., 2023, published in the Jounral _Flow_.

## Contents

- **LICENSE**: MIT License details.

- **Handout.pdf**: Student handout which walks the student through the activity while posing questions for reflection along the way (includes pre-survey and wrap up questions).

- **activity_files**: Folder of student ready files.  The MATLAB codes need editing and additional lines as prompted in the handout.
  - **Beach_Flow_Model_1.m**: Activity part 1: beach set up, shoreline motion, water surface, and water velocity.
  - **Beach_Debris_Modeling_2.m**: Activity part 2: solve the particle position, solve the particle velocity, iterate the solution to every step of run-up.
  - **Debris_Beaching_#.m**: Activity part 3: debris beaching, animate particle on beach, and compare to experiments.
  - **experimental_data.mat**: Experimental data used in comparison of part 3.
  - **Full_Model_4**: Full model example for students to work through if they finish parts 1-3.
    - **figure8.m**: Main script to create Figure 8 frim the reference paper.
    - **fiugre8_data.mat**: Data used in **figure8.m**.
    - **swash_part_model.m**: Function that solves for particle position, velocity, and time given input particle conditions.
    - **swashinertialparticle_int.m**: Function that sets up the integration of **swashinertialparticle_ode.m**
    - **swashinertialparticle_ode.m**: The inertial particle acceleration function which is integrated to solve for the particle velocity and position.
- **activity_files_filled**: Folder of filled activity files all lines left for students to fill are completed.
  - **Beach_Flow_Model_1.m**: FILLED - Activity part 1: beach set up, shoreline motion, water surface, and water velocity.
  - **Beach_Debris_Modeling_2.m**: FILLED - Activity part 2: solve the particle position, solve the particle velocity, iterate the solution to every step of run-up.
  - **Debris_Beaching_#.m**: FILLED - Activity part 3: debris beaching, animate particle on beach, and compare to experiments.
  - **experimental_data.mat**: Experimental data used in comparison of part 3.

## Requirements

- MATLAB R2022a or later

## Reference Citation

Davidson, et al. (2023). Beaching model for buoyant marine debris in bore-driven swash. *Flow*.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
