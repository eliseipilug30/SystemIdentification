clear all;
close all;
clc;
load('dataset2_lab7_2.mat');
figure,
plot(system_simulator(1,u));