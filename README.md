# C_elegans_Simulink

**Communication**

<a style="text-decoration: none" href="https://twitter.com/hogelungfish_" target="_blank">
    <img src="https://img.shields.io/badge/twitter-%40hogelungfish_-1da1f2.svg" alt="Twitter">
</a>
<p>

**Language**
<p>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/matlab/matlab-original.svg" width="60"/>
<p>


An integrated neuromechanical model for the nematode, C. elegans,  which is modeled by Jordan H. Boyle (Boyle et al., 2012)[^1].

## Overview
An integrated neuromechanical model for the nematode, C. elegans,  which is modeled by Jordan H. Boyle (Boyle et al., 2012).
This nematode model is ported in MATLAB Simulink, which is verified in MATLAB R2018a.


## Block diagram

![image](https://user-images.githubusercontent.com/114337358/204077618-f508f60c-c642-44ee-8ed2-62f99a33cb3e.png)

## Usage

__[Step 1]__ Open "GUI.fig" 

__[Step 2]__ Push "parameter" button

__[Step 3]__ Select the fluid model

__in Water__
```
C_par = 5.2e-6; %% 横方向抗力 [kg/s]
C_per = 3.3e-6; %% 推進方向抗力 [kg/s]
```

__on Agar__
```
C_par = 128e-3; %% 横方向抗力 [kg/s]
C_per = 3.2e-3; %% 推進方向抗力 [kg/s]
```
__[Step 3]__ Execute the "exe.m" to start numerical analysis

__[Step 4]__ Push "plot" button to see results



## Image

__in Water__

![untitled](https://user-images.githubusercontent.com/114337358/204078363-8d8c5584-e77d-4e1f-b329-3f881905d8ab.png)


__on Agar__

![untitled](https://user-images.githubusercontent.com/114337358/204078029-f7bdfb7b-c29b-4289-be38-ac9ead6c833b.png)

## Demonstration movie

[![](https://img.youtube.com/vi/rrz9yFbLrSA/0.jpg)](https://youtu.be/rrz9yFbLrSA)



### Reference
[^1]: Boyle et al., Gait modulation in C. elegans: an integrated neuromechanical model, Frontiers in Computational Neuroscience, Vol. 6, 2012. DOI: 10.3389/fncom.2012.00010.



