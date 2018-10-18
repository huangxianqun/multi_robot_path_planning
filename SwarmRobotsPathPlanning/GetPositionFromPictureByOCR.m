%function [ output_args ] = Untitled( input_args )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
clear all;
close all;
businessCard   = imread('1.png');
ocrResults = ocr(businessCard, 'TextLayout', 'Block');
recognizedText = ocrResults.Text;


%end

