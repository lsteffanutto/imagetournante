clear all;
clc;
close all;

M1=[1 2];
M2=[3 4];
M3=[5 6];
M4=[7 8];
M5=[9 10];
M6=[11 12];
M7=[13 14];
M8=[15 16];

[A B H]=homographie(M1,M2,M3,M4,M5,M6,M7,M8);