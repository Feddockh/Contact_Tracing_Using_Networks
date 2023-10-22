clear
clc
%Generate the X and Y grid arrays using the MESHGRID function.
r = randi(10, 50); %r will represent input matrix. current state is for demo purposes

%integers for item representation

int_person = 0;
int_accessPoint = 1;
int_rangeRadius = 2;


imagesc(r)

%timing system to be implemented