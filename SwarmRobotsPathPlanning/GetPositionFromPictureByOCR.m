%function [ output_args ] = Untitled( input_args )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
clear all;
close all;
businessCard   = imread('1.png');
ocrResults = ocr(businessCard, 'TextLayout', 'Block');
recognizedText = ocrResults.Text;


%end

