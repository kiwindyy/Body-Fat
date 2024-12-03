# Estimating Body Fat Using Circumference Measurements

## Overview

This study estimates body fat percentage using a multi-linear regression model based on body measurements such as abdominal circumference, wrist size, height, and age. Abdominal circumference emerged as the strongest predictor, indicating its significant role in assessing body fat. Wrist size and height were also associated, with larger wrists and greater height linked to lower body fat, while age showed a smaller positive relationship. The results highlight an affordable and accessible method for estimating body fat, providing practical applications for monitoring health and identifying potential risks related to extremely high or low body fat percentage.

## File Structure

The repo is structured as:
-   `data/raw_data` contains the raw data as obtained from The Data And Story Library (DASL).
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `other/llm_usage` contains relevant details about LLM chat interactions.
-   `other/datasheet` contains the datasheet & data dictionary for body fat percentage dataset.
-   `other/sketches` contains images of the initial sketches for the body fat percentage dataset.
-   `models` contains final model generated from the 4 selected variables in rds format.
-   `paper` contains the files used to generate the paper, including the Quarto document, reference bibliography file, and the PDF version. 
-   `scripts` contains the R scripts used to simulate, download and clean data.

## Statement on LLM usage

Aspects of the code were written with the help of Chat-GPT 40. The entire chat history is available in other/llms/usage.txt.